package com.example.mapper;

import com.example.entity.Comment;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CommentMapper {
    int insert(Comment comment);

    int deleteById(Integer id);

    int updateById(Comment comment);

    Comment selectById(Integer id);

    List<Comment> selectAll(Comment comment);


    /**
     *  查询该商家所有被评分的所有信息
     * @param businessId
     * @return
     */
    @Select("select * from comment where business_id = #{businessId}")
    List<Comment> selectByBusinessId(Integer businessId);
}
