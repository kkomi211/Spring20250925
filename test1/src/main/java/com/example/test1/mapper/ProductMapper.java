package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {

	List<Product> selectProList(HashMap<String, Object> map);
	
	int insertProduct(HashMap<String, Object> map);
	
	List<Menu> selectMenuList(HashMap<String, Object> map);
	
	int insertFoodImg(HashMap<String, Object> map);
	
	int insertMenu(HashMap<String, Object> map);
}
