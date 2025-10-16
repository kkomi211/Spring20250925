package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.google.gson.Gson;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/mgr/member/list.do")
	public String mgr(Model model) throws Exception{
		
		return "/mgr/member-list";
	}
	
	@RequestMapping("/mgr/member/view.do")
	public String view(Model model) throws Exception{
		
		return "/mgr/member-view";
	}
	
	@RequestMapping("/member/login.do")
	public String login(Model model) throws Exception{
		
		return "/member/member-login";
	}
	
	@RequestMapping("/member/pwd.do")
	public String pwd(Model model) throws Exception{
		
		return "/member/pwd";
	}
	
	@RequestMapping("/member/join.do")
	public String join(Model model) throws Exception{
		
		return "/member/member-join";
	}
	
	@RequestMapping("/addr.do")
	public String addr(Model model) throws Exception{
		
		return "/jusoPopup";
	}
	
	@RequestMapping(value = "/member/auth.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String auth(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.authId(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/edit/pwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updatePwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.updatePwd(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.login(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.logout(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.idCheck(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String join(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.join(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/mgr/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String List(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/mgr/member/clear.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String clear(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.cntClear(map);
		
		return new Gson().toJson(resultMap);
	}
}
