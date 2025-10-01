package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;

@Mapper
public interface BoardMapper {
	
	List<Board> boardList(HashMap<String, Object> map);
	
	int selectBoardCnt(HashMap<String, Object> map);
	
	int boardDelete(HashMap<String, Object> map);
	
	int insertBoard(HashMap<String, Object> map);
	
	Board boardInfo(HashMap<String, Object> map);
	
	int boardEdit(HashMap<String, Object> map);
	
	int insertComment(HashMap<String, Object> map);
	
	List<Board> boardComment(HashMap<String, Object> map);
	
	int boardCnt(HashMap<String, Object> map);
	
	int commentDelete(HashMap<String, Object> map);
	
}
