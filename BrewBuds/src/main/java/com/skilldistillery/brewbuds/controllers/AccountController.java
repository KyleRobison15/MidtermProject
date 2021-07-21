package com.skilldistillery.brewbuds.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.UserDAO;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.User;

@Controller
public class AccountController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private RatingDAO ratingDao;
	
	
	
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
		
	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String login(User user, HttpSession session) {
	
		if (session.getAttribute("user") != null) {
			return "redirect:home.do";
		}
		
		User u = userDao.getUserByLoginCredentials(user.getUsername(), user.getPassword());
		
		if (u != null) {
			session.setAttribute("user", u);
			return "redirect:showProfileAdd.do";
		}
		else {
			return "login";
		}	
	}
	
	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String account(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "account";
		}
		return "home";
	}
	
	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logOut(HttpSession session) {
		session.removeAttribute("user");
		
		return "redirect:home.do";
	}
	
	@RequestMapping(path = "showProfileAdd.do", method = RequestMethod.GET)
	public String showProfileAdd(Model model, HttpSession session) {
		if (session.getAttribute("user") != null) {
			User loggedUser = (User) session.getAttribute("user");
			Double rating = ratingDao.findAverageUserRating(loggedUser.getId());
			model.addAttribute("rating", rating);
			List<Beer> addedBeers = loggedUser.getAddedBeers();
			model.addAttribute("addedBeers", addedBeers);
			
			return "userProfileAdd";
		}
		return "home";
	}
	@RequestMapping(path = "showProfileFind.do", method = RequestMethod.GET)
	public String showProfileFind(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "userProfileFind";
		}
		return "home";
	}
	
	@RequestMapping(path = "AddFavorite.do", method = RequestMethod.POST)
	public String addFavorites(@RequestParam("beerId") int beerId, Model model, HttpSession session, RedirectAttributes redir) {
		
		User user = (User) session.getAttribute("user"); 
		userDao.addToFavorite(beerId, user.getId());
		
		redir.addFlashAttribute("user", user);
		
		return "redirect:ShowFavorites.do";
	}
	
	@RequestMapping(path = "ShowFavorites.do", method = RequestMethod.GET)
	public String showFavorites(Model model, User user) {
		model.addAttribute("beers", userDao.getFavoriteList(user.getId()));
		return "userProfileFind";
	}
	
	@RequestMapping(path = "ShowFavoritesAlt.do", method = RequestMethod.GET)
	public String showFavoritesAlt(Model model, @RequestParam("userId") int userId) {
		model.addAttribute("beers", userDao.getFavoriteList(userId));
		return "userProfileFind";
	}

}
