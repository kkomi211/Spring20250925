package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	Member memberLoginId(HashMap<String, Object> map);
	
	Member memberLoginPwd(HashMap<String, Object> map);
	
	
	Member memberCheck(HashMap<String, Object> map);
	
	int memberJoin(HashMap<String, Object> map);
	
	List<Member> memberList(HashMap<String, Object> map);
	
	int cntUp(HashMap<String, Object> map);
	
	int cntZero(HashMap<String, Object> map);
	
	Member memberAuth(HashMap<String, Object> map);
	
	int updatePwd(HashMap<String, Object> map);
}
