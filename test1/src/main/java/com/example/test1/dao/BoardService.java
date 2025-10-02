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
		int cnt = boardmapper.selectBoardCnt(map);
		
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
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
		
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> infoBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Board board = boardmapper.boardInfo(map);
		List<Board> fileList = boardmapper.selectFileList(map);
		
		
		resultMap.put("fileList", fileList);
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
	
	public HashMap<String, Object> insertComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.insertComment(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> BoardComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardmapper.boardComment(map);
		
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	
	public HashMap<String, Object> upCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardCnt(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> commentDelete(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.commentDelete(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> boardtDeleteList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardDeleteList(map);
		
		resultMap.put("result", "success");
		
		
		return resultMap;
	}

	public void addBoardImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		int cnt = boardmapper.insertBoardImg(map);
		
	}
	
}