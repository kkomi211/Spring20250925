package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {

	List<Area> selectArea(HashMap<String, Object> map);
	
	int offset(HashMap<String, Object> map);
	
	List<Area> selectSiList(HashMap<String, Object> map);
}
