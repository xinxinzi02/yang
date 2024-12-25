package com.example.service;

import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Category;
import com.example.mapper.CategoryMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class CategoryService {
    @Resource
    private BusinessService businessService;
    @Resource
    private CategoryMapper categoryMapper;
    /**
     * 新增
     */
    public void add(Category category){
        //校验权限
        businessService.checkBusinessAuth();
        Account currentUser = TokenUtils.getCurrentUser();//获取当前用户信息
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())){
            //如果是商家，默认给一个id
            category.setBusinessId(currentUser.getId());
        }
        categoryMapper.insert(category);

    }
    /**
     * 删除
     */
    public void deleteById(Integer id) {
        //校验权限，只有通过的商家才可以新增
        businessService.checkBusinessAuth();
        categoryMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        //校验权限，只有通过的商家才可以新增
        businessService.checkBusinessAuth();
        for (Integer id : ids) {
            categoryMapper.deleteById(id);
        }
    }
    /**
     * 修改
     */
    public void updateById(Category category) {
        //校验权限，只有通过的商家才可以新增
        businessService.checkBusinessAuth();
        categoryMapper.updateById(category);
    }

    /**
     * 根据ID查询
     */
    public Category selectById(Integer id) {

        return categoryMapper.selectById(id);
    }
    /**
     * 查询所有
     */
    public List<Category> selectAll(Category category) {
        //拿到当前的登录用户信息
        Account currentUser = TokenUtils.getCurrentUser();
        String role = currentUser.getRole();
        if (RoleEnum.BUSINESS.name().equals(role)){   //如果是商家的话，只能查询自己的分类
            category.setBusinessId(currentUser.getId());  //设置商家自己的ID作为查询条件

        }



        return categoryMapper.selectAll(category);
    }

    /**
     * 分页查询
     */
    public PageInfo<Category> selectPage(Category category, Integer pageNum, Integer pageSize) {
        //拿到当前的登录用户信息
        Account currentUser = TokenUtils.getCurrentUser();
        String role = currentUser.getRole();//获取当前的登录用户的角色信息
        if (RoleEnum.BUSINESS.name().equals(role)){   //如果是商家的话，只能查询自己的分类
            category.setBusinessId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Category> list = categoryMapper.selectAll(category);
        return PageInfo.of(list);
    }

}
