package com.skilldistillery.brewbuds.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.AddressDAO;
import com.skilldistillery.brewbuds.data.UserDAO;
import com.skilldistillery.brewbuds.entities.User;

@Controller
public class AccountController {

	@Autowired
	private UserDAO userDao;
	private AddressDAO addressDao;
	
	@RequestMapping(path = "createAccount.do", method = RequestMethod.POST)
	public String createAccount(User newUser, String confirmPassword, RedirectAttributes redir, Model model) {
		
		boolean isCreated = userDao.createUserAccount(newUser, confirmPassword);
		
		
		if (isCreated) {
			redir.addFlashAttribute("newUser", newUser);
			return "redirect:accountCreated.do";
		}
			model.addAttribute("newUser",newUser);
		return "creationFailed";
	}
	
	@RequestMapping(path = "accountCreated.do", method = RequestMethod.GET)
	public String confirmCreateAccount(User newUser, Model model) {
		model.addAttribute("newUser", newUser);
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
