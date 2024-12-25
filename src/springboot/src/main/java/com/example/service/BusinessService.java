package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.exception.CustomException;
import com.example.mapper.BusinessMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

@Service
public class BusinessService {
    @Resource
    private BusinessMapper businessMapper;
    @Resource
    private CollectService collectService;
    @Resource
    private OrdersService ordersService;//统计订单信息

    @Resource
    private  OrdersItemService ordersItemService;//统计订单详情信息
    @Resource
    private CommentService commentService;
    /**
     * 新增
     * @param business
     */
    public void add(Business business){
        Business dbBusiness = this.selectByUsername(business.getUsername());
        //如果根据新增的账号查询到了数据，那么这个数据不允许插入，账号不能重复
        if(ObjectUtil.isNotEmpty(dbBusiness)){
            //返回错误信息
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        business.setRole(RoleEnum.BUSINESS.name());
        businessMapper.insert(business);
    }

    /**
     * 根据账号查询
     * @param username
     * @return
     */
    public Business selectByUsername(String username) {
        Business params = new Business();
        params.setUsername(username);
        //根据params中的username，然后对数据库进行查询，看数据库中有没有这个username
        List<Business> list = this.selectAll(params);
        return list.size() == 0 ? null : list.get(0);
    }


    /**
     * 查询所有
     */
    public List<Business> selectAll(Business business) {
        List<Business> businesses = businessMapper.selectAll(business);
        for (Business b : businesses){
            wrapBusiness(b);
        }
        return businesses;
    }


    

    /**
     * 修改商家
     * @param business
     */
    public void upDateById(Business business) {
        //先根据商家id查询商家是否存在，不存在则返回错误
        Business dbBusiness1 = selectById(business.getId());
        if (ObjectUtil.isEmpty(dbBusiness1)){
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        Business dbBusiness2 = this.selectByUsername(business.getUsername());
        //根据当前更新的商家的账号查询数据库，如果用户名一样，则报错，不能重复修改
        if (ObjectUtil.isNotEmpty(dbBusiness2) && ! Objects.equals(dbBusiness2.getId(),business.getId())){
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        businessMapper.upDateById(business);
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public Business selectById(Integer id) {
        Business business = this.selectBasicBusinessById(id);
        if (business != null){
            Account currentUser = TokenUtils.getCurrentUser();
            Collect collect = collectService.selectByUserIdAndBusiness(currentUser.getId(),id);
            business.setIsCollect(collect !=null);
        }
        return business;
    }

    /**
     * 查询基础的商家信息
     * @param id 商家id
     * @return 上机信息
     */
    public Business selectBasicBusinessById(Integer id) {
        Business params = new Business();
        params.setId(id);
        List<Business> list = this.selectAll(params);
        return list.size() == 0 ? null : list.get(0);
    }

    /**
     * 分页查询
     */
    public PageInfo<Business> selectPage(Business business,Integer pageNum,Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        List<Business> list = businessMapper.selectAll(business);
        return PageInfo.of(list);
    }


    /**
     * 单个删除
     * @param id
     */
    public void deleteById(Integer id) {
        businessMapper.deleteById(id);
    }

    /**
     * 批量删除
     * @param ids
     */
    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            //调用单个删除
            this.deleteById(id);
        }
    }
    /**
     * 检查商家的权限  看看是否可以新增数据
     */
    public void checkBusinessAuth() {
        Account currentUser = TokenUtils.getCurrentUser();//获取当前用户信息
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())){
            //如果是商家的话
            Business business = selectById(currentUser.getId());
            if (!"通过".equals(business.getStatus())){
                //状态不是通过的商家不可以添加数据
                throw new CustomException(ResultCodeEnum.NO_AUTH);
            }
        }

    }
    /**
     * 统计该商家的评分和 统计该商家的销售额
     */
    private void wrapBusiness(Business b) {
        List<Comment> commentList = commentService.selectByBusinessId(b.getId());//  从comment拿到该商家被用户评论的所有信息，即commentList
        //将评分的星星加和在一起      5D是5分是基础分，该商家没有用户参与评分的时候，默认五分，等有人评分的时候，要把这个五分基础分加进去
        double sum = commentList.stream().map(Comment::getStar).reduce(Double::sum).orElse(0D) + 5D;
        // 5 + 4.5 / 1 + 1
        //将该商家的所有的评分加和在一起，在除以评价的人数，计算出该商家总的评分（保留一位小数并向上取整，转换为double类型）
        double score = BigDecimal.valueOf(sum).divide(BigDecimal.valueOf(commentList.size() + 1), 1, BigDecimal.ROUND_UP).doubleValue();
        b.setScore(score);

        // 查出所有有效的订单
        List<Orders> ordersList = ordersService.selectUsageByBusinessId(b.getId());
        int nums = 0;
        for (Orders orders : ordersList) {//从有效订单查出订单详情信息
            List<OrdersItem> ordersItemList = ordersItemService.selectByOrderId(orders.getId());
            // 聚合函数查出订单的商品数量，将商品数量进行相加
            nums += ordersItemList.stream().map(OrdersItem::getNum).reduce(Integer::sum).orElse(0);
        }
        b.setNums(nums);
    }
    /**
     *
     * 商家注册
     */
    public void register(Account account) {
        Business business = new Business();
        BeanUtils.copyProperties(account, business);  // 拷贝 账号和密码2个属性
        if (ObjectUtil.isEmpty(account.getName())) {
            business.setName(business.getUsername());
        }
        this.add(business);  // 添加账户信息
    }

    /**
     * 商家登录
     */
    public Account login(Account account) {
        Account dbBusiness = this.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbBusiness)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbBusiness.getPassword())) {   // 比较用户输入密码和数据库密码是否一致
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String tokenData = dbBusiness.getId() + "-" + RoleEnum.BUSINESS.name();//根据商家id和商家生成一个token
        String token = TokenUtils.createToken(tokenData, dbBusiness.getPassword());
        dbBusiness.setToken(token);
        return dbBusiness;
    }
    /**
     * 修改商家密码
     */
    public void updatePassword(Account account) {
        Business dbBusiness = this.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbBusiness)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbBusiness.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbBusiness.setPassword(account.getNewPassword());
        this.upDateById(dbBusiness);
    }



}


