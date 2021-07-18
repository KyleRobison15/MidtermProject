package com.skilldistillery.brewbuds.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.UserDAO;
import com.skilldistillery.brewbuds.entities.User;

public class AccountController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = "createAccount.do", method = RequestMethod.POST)
	public String createAccount(User newUser, String confirmPassword, RedirectAttributes redir) {
		userDao.createUserAccount(newUser, confirmPassword);

		//Check password and confirmPassword
		
		return "redirect: confirmAccount.do";
	}
	
	@RequestMapping(path = "confirmAccount.do", method = RequestMethod.GET)
	public String confirmCreateAccount(User newUser) {
		return"accountCreated";
	}
	
	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String account(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "account";
		}
		
		return "";
	}
	
}
