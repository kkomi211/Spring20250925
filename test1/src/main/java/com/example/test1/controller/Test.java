package com.example.test1.controller;

import java.util.Random;

public class Test {
	public static void main(String[] args) {
		Random ran = new Random();
		String num = "";
		for(int i = 0; i<6; i++) {
			num += ran.nextInt(10);
		}
		System.out.println(num);
		
		
	}
}
