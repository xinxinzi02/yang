package com.example.service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.exception.CustomException;
import com.example.mapper.OrdersMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrdersService {
    private static final Logger log = LoggerFactory.getLogger(OrdersService.class);
    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    private OrdersItemService ordersItemService;
    @Resource
    private CartService cartService;

    /**
     * 新增
     */
    public void add(Orders orders) {
        ordersMapper.insert(orders);
    }

    /**
     * 删除   注意：删除订单要删除订单关联的数据
     */
    public void deleteById(Integer id) {

        ordersMapper.deleteById(id);
//        删除订单详情
         ordersItemService.deleteByOrderId(id);
    }
    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            this.deleteById(id);
        }
    }

    public void updateById(Orders orders) {
        //支付完成后设置一个支付时间
        if(OrderStatusEnum.NO_SEND.getValue().equals(orders.getStatus())){
            orders.setPayTime(DateUtil.now());
        }
        ordersMapper.updateById(orders);
    }

    public Orders selectById(Integer id) {
        return ordersMapper.selectById(id);
    }

    public List<Orders> selectAll(Orders orders){
        //删除按钮只有管理员能看到
        //商家只能看到自己店铺到订单
        //拿到当前登陆的用户信息
        Account currentUser = TokenUtils.getCurrentUser();
        String role = currentUser.getRole();
        if (RoleEnum.BUSINESS.name().equals(role)){//如果是商家只允许查询自己的分类
            orders.setBusinessId(currentUser.getId());//设置商家自己的id作为查询条件
        }
        return ordersMapper.selectAll(orders);
    }

    public PageInfo<Orders> selectPage(Orders orders,Integer pageNum,Integer pageSize){
        //删除按钮只有管理员能看到
        //商家只能看到自己店铺到订单
        //拿到当前登陆的用户信息
        Account currentUser = TokenUtils.getCurrentUser();
        String role = currentUser.getRole();
        if (RoleEnum.BUSINESS.name().equals(role)){//如果是商家只允许查询自己的分类
            orders.setBusinessId(currentUser.getId());//设置商家自己的id作为查询条件
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }

    /**
     * 统计有效订单
     * @param businessId
     * @return
     */
    public List<Orders>  selectUsageByBusinessId(Integer businessId) {
        return ordersMapper.selectUsageByBusinessId(businessId);
    }


    /**
     * 前台用户下单
     * @param ordersDTO
     */
    @Transactional
    public void addOrder(OrdersDTO ordersDTO) {
        Integer businessId = ordersDTO.getBusinessId();
        Account currentUser = TokenUtils.getCurrentUser();
        Integer userId = currentUser.getId();
        if (userId == null) {//如果未登录直接抛出异常
            throw new CustomException(ResultCodeEnum.NO_AUTH);
        }
        List<Cart> cartList = cartService.selectUserCart(currentUser.getId(), businessId);//查出购物车的信息
        if (CollUtil.isEmpty(cartList)) {//购物无商品的时候不允许下单
            throw new CustomException(ResultCodeEnum.NO_GOODS);
        }
        Orders orders = new Orders();//构建orders里面的基础信息
        orders.setBusinessId(businessId);
        String now = DateUtil.now();
        orders.setTime(now);//下单时间
        orders.setPayType(ordersDTO.getPayType());//支付方式
        orders.setUserId(userId);//用户id
        orders.setAddress(ordersDTO.getAddress());//收货地址
        orders.setUser(ordersDTO.getUser());//用户
        orders.setPhone(ordersDTO.getPhone());//电话
        orders.setComment(ordersDTO.getComment());//备注信息

        // 设置商品信息(金额)
        AmountDTO amountDTO = cartService.calc(userId, businessId);
        orders.setAmount(amountDTO.getAmount());//总价格
        orders.setDiscount(amountDTO.getDiscount());//优惠信息
        orders.setActual(amountDTO.getActual());//实际付款信息

        // 得到购物车商品的总数
        Integer nums = cartList.stream().map(Cart::getNum).reduce(Integer::sum).orElse(0);//取出商品的数量，商品数量相加
        orders.setName(cartList.get(0).getGoods().getName() + "等" + nums + "件商品");
        orders.setCover(cartList.get(0).getGoods().getImg());//订单封面

        // 最后设置一个订单编号
        orders.setOrderNo(IdUtil.getSnowflakeNextIdStr());  // 雪花算法生成唯一的ID作为订单号
        // 设置订单状态
        orders.setStatus(OrderStatusEnum.NO_PAY.getValue());
        this.add(orders);

        // 再设置订单的 详细信息
        for (Cart cart : cartList) {
            OrdersItem ordersItem = new OrdersItem();
            ordersItem.setOrderId(orders.getId());
            ordersItem.setGoodsName(cart.getGoods().getName());
            ordersItem.setGoodsImg(cart.getGoods().getImg());
            ordersItem.setPrice(cart.getGoods().getActualPrice());
            ordersItem.setNum(cart.getNum());
            ordersItem.setGoodsId(cart.getGoodsId());
            ordersItemService.add(ordersItem);//插入到数据库中
        }

        // 清空购物车
        cartService.deleteBusiness(businessId, userId);
    }


}