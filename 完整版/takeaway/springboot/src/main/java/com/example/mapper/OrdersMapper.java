package com.example.mapper;

import com.example.entity.Orders;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作orders相关数据接口
 */
public interface OrdersMapper {

    /**
     * 新增
     */
    int insert(Orders orders);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Orders orders);

    /**
     * 根据ID查询
     */
    Orders selectById(Integer id);

    /**
     * 查询所有
     */
    List<Orders> selectAll(Orders orders);

    /**
     * 统计出所有有效的订单,即是支付过的订单才可以
     * @param businessId
     * @return
     */
    @Select("select * from  orders where  business_id =  #{businessId} and  (status = '待评价' or  status='已完成') ")
    List<Orders> selectUsageByBusinessId(Integer businessId);

}