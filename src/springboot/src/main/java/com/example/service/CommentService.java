package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Comment;
import com.example.entity.Orders;
import com.example.mapper.CommentMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentService {
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private OrdersService orderService;
    /**
     * 新增
     */
    @Transactional
    public void add(Comment comment){
        comment.setTime(DateUtil.now());
        Orders orders = orderService.selectById(comment.getOrderId());
        if (orders != null){
            comment.setBusinessId(orders.getBusinessId());
            orders.setStatus(OrderStatusEnum.DONE.getValue());
            orderService.updateById(orders);
        }
        Account currentUser = TokenUtils.getCurrentUser();
        comment.setUserId(currentUser.getId());
        commentMapper.insert(comment);

    }


    public void deleteById(Integer id) {
        commentMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            commentMapper.deleteById(id);
        }
    }

    public void updateById(Comment comment) {
        commentMapper.updateById(comment);
    }

    public Comment selectById(Integer id) {
        return commentMapper.selectById(id);
    }

    public List<Comment> selectAll(Comment comment) {
        return commentMapper.selectAll(comment);
    }

    public PageInfo<Comment> selectPage(Comment comment, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        String role = currentUser.getRole();
        if(RoleEnum.BUSINESS.name().equals(role)){//如果是商家，只能查询自己的评价，用商家自己的ID作为查询的条件
            comment.setBusinessId(currentUser.getId());
        }
        PageHelper.startPage(pageNum,pageSize);
        List<Comment> list = commentMapper.selectAll(comment);
        return PageInfo.of(list);
    }

    /**
     * 查询该商家被评分的所有信息
     * @param businessId
     * @return
     */
    public List<Comment> selectByBusinessId(Integer businessId) {
        return commentMapper.selectByBusinessId(businessId);
    }
}