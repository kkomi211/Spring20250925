package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class ProductController {
	
	@Autowired
	ProductService productService;

	@RequestMapping("/product.do") 
    public String product(Model model) throws Exception{
        return "/product";
    }
	
	@RequestMapping("/product/add.do")
	public String productAdd(Model model) throws Exception{
		return "/product-add";
	}
	
	@RequestMapping("/product/login.do") 
    public String productLogin(Model model) throws Exception{
        return "/product-login";
    }
	
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getProList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.addProduct(map);
		
		return new Gson().toJson(resultMap);
	}
}
