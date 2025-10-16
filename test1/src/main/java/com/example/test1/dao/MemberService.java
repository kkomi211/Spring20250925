package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.test1.controller.BoardController;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

    private final BoardController boardController;

		@Autowired
		MemberMapper memberMapper;
		
		@Autowired
		PasswordEncoder passwordEncoder;
		
		@Autowired
		HttpSession session;


    MemberService(BoardController boardController) {
        this.boardController = boardController;
    }
		
		
		
		public HashMap<String, Object> login(HashMap<String, Object> map) {
			String message = "";
			String result = "fail";
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			Member memberId = memberMapper.memberLoginId(map);
			Member memberPwd = memberMapper.memberLoginPwd(map);

			if(memberId == null) {
				message = "아이디가 존재하지 않습니다";
			}
			else if(!passwordEncoder.matches((String) map.get("pwd"), memberId.getPassword())) {
				if(memberId.getCnt() >= 5) {
					message = "비밀번호를 5회 이상 잘못 입력하셨습니다.";
					memberMapper.cntUp(map);
				}
				else {
					message = "패스워드를 확인해주세요";
					memberMapper.cntUp(map);
				}
				
			}
			else {
				if(memberId.getCnt() >=	 5) {
					message = "비밀번호를 5회 이상 잘못 입력하셨습니다.";
				}
				else {
					message = "로그인 성공";
					result = "success"; 
					memberMapper.cntZero(map);
					session.setAttribute("sessionId", memberId.getUserId());
					session.setAttribute("sessionName", memberId.getName());
					session.setAttribute("status", memberId.getStatus());
					if(memberId.getStatus().equals("A")) {
						resultMap.put("url", "/mgr/member/list.do");
					}
					else {
						resultMap.put("url", "/main.do");
					}
					
				}
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
			String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
			map.put("hashPwd", hashPwd);
			int cnt = memberMapper.memberJoin(map);
			System.out.println(map);
			
			resultMap.put("userId", map.get("userId"));	
			resultMap.put("result","success");
			
			return resultMap;
		}
		
		public HashMap<String, Object> memberList(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				List<Member> member = memberMapper.memberList(map);
				resultMap.put("list", member);
				resultMap.put("result", "success");
			} catch (Exception e) {
				resultMap.put("result", "fail");
				System.out.println(e.getMessage());
			}
			return resultMap;
		}
		
		public HashMap<String, Object> cntClear(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int cnt = memberMapper.cntZero(map);
			
			
			
			resultMap.put("result","success");	
			
			return resultMap;
		}
		
		public HashMap<String, Object> authId(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				System.out.println(map.get("phone"));
				Member member = memberMapper.memberAuth(map);
				String result = member != null ? "success" : "fail";
				resultMap.put("info", member);	
				resultMap.put("result", result);
			} catch(Exception e) {
				resultMap.put("result", "fail");
			}
			
			return resultMap;
		}
		
		public HashMap<String, Object> updatePwd(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
				Member member = memberMapper.memberLoginId(map);
				String result = "";
				if(!passwordEncoder.matches((String) map.get("pwd"), member.getPassword())) {
					map.put("hashPwd", hashPwd);
					int cnt = memberMapper.updatePwd(map);
					result = cnt != 0 ? "success" : "fail";
				} else {
					result = "same";
					
				}
				
				resultMap.put("result", result);
			} catch(Exception e) {
				resultMap.put("result", "fail");
			}
			
			return resultMap;
		}
		
}
