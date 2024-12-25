package com.example.service;

import com.example.entity.OrdersItem;
import com.example.mapper.OrdersItemMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrdersItemService {
    @Resource
    private OrdersItemMapper ordersItemMapper;

    public void add(OrdersItem ordersItem) {
        ordersItemMapper.insert(ordersItem);
    }

    public void deleteById(Integer id) {
        ordersItemMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
        ordersItemMapper.deleteById(id);
        }
    }

    public void updateById(OrdersItem ordersItem) {
        ordersItemMapper.updateById(ordersItem);
    }

    public OrdersItem selectById(Integer id) {
        return ordersItemMapper.selectById(id);
    }

    public List<OrdersItem> selectAll(OrdersItem ordersItem) {
        return ordersItemMapper.selectAll(ordersItem);
    }

    public PageInfo<OrdersItem> selectPage(OrdersItem ordersItem, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<OrdersItem> list = ordersItemMapper.selectAll(ordersItem);
        return PageInfo.of(list);
    }
    public void deleteByOrderId(Integer orderId){
        ordersItemMapper.deleteByOrderId(orderId);
    }

    /**
     *    从有效订单查出订单详情
     */
    public List<OrdersItem> selectByOrderId(Integer ordersId) {
        OrdersItem ordersItem  = new OrdersItem();
        ordersItem.setOrderId(ordersId);
        return  ordersItemMapper.selectAll(ordersItem);

    }

    public List<OrdersItem> selectByGoodsId(Integer goodsId) {
        OrdersItem ordersItem  = new OrdersItem();
        ordersItem.setGoodsId(goodsId);
        return  ordersItemMapper.selectAll(ordersItem);
    }
}
