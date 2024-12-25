package com.example.mapper;

import com.example.entity.Orders;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OrdersMapper {
    int insert(Orders orders);

    int deleteById(Integer id);

    int updateById(Orders orders);

    Orders selectById(Integer id);

    List<Orders> selectAll(Orders orders);

    /**
     * 统计出所有有效的订单,即是支付过的订单才可以
     * @param businessId
     * @return
     */
    @Select("select * from  orders where  business_id =  #{businessId} and  (status = '待评价' or  status='已完成') ")
    List<Orders> selectUsageByBusinessId(Integer businessId);

}
