package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.brewbuds.data.UserDAO;

@Controller
public class HomeController {
	
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = {"/", "home.do"})
	public String home(Model model) {
		return "home";
	}
	
	@RequestMapping(path = "createAccountPage.do")
	public String showCreateAccountPage(Model model) {
		return "createAccount";
	}

	@RequestMapping(path = "loginPage.do")
	public String showLoginPage(Model model) {
		return "login";
	}
	
<<<<<<< HEAD
}
=======
}
>>>>>>> 35769507a1c767573dcc5462c6e3b91ad4bdd463
