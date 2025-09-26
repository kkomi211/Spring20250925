package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardmapper;
	
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardmapper.boardList(map);
		
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> deleteBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardDelete(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> insertBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.insertBoard(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> infoBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Board board = boardmapper.boardInfo(map);
		resultMap.put("info", board);
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> BoardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardEdit(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
}