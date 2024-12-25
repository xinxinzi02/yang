package com.example.mapper;

import com.example.entity.Goods;

import java.util.List;

public interface GoodsMapper {
    int insert(Goods goods);

    int deleteById(Integer id);

    int updateById(Goods goods);

    Goods selectById(Integer id);

    List<Goods> selectAll(Goods goods);
}
