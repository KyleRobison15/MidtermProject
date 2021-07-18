package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.skilldistillery.brewbuds.data.UserDAO;

@Controller
public class LoginController {

	@Autowired
	private UserDAO userDao;
	
	
}
