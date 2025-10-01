package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

		@Autowired
		MemberMapper memberMapper;
		
		@Autowired
		HttpSession session;
		
		public HashMap<String, Object> login(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			Member member = memberMapper.memberLogin(map);
			String message = member != null ? "로그인 성공~!" : "로그인 실패~!";
			String result = member != null ? "success" : "fail";
			
			if(member != null) {
				session.setAttribute("sessionId", member.getUserId());
				session.setAttribute("sessionName", member.getName());
				session.setAttribute("status", member.getStatus());
			}
			
			resultMap.put("msg", message);
			resultMap.put("result", result);
			return resultMap;
		}
		
		public HashMap<String, Object> idCheck(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			Member member = memberMapper.memberCheck(map);
			String message = member != null ? "이미 사용중인 아이디입니다" : "사용 가능한 아이디입니다";
			String result = member == null ? "success" : "fail";
			
			resultMap.put("msg", message);
			resultMap.put("result", result);
			return resultMap;
		}
		
		public HashMap<String, Object> logout(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			String message = session.getAttribute("name") + "님 로그아웃 되었습니다.";
			resultMap.put("msg", message);
			
//			session.removeAttribute("sessionId"); 1개씩 삭제
			session.invalidate(); // 세션정보 전체 삭제
			return resultMap;
		}
		
		public HashMap<String, Object> join(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int cnt = memberMapper.memberJoin(map);
			resultMap.put("result","success");
			
			return resultMap;
		}
		
}
