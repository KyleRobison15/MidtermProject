package com.skilldistillery.brewbuds.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.BeerDAO;
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
	@Autowired
	private BeerDAO beerDao;
	
	
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
	public String login(User user, HttpSession session, Model model) {
		String message = null;
		
		if (session.getAttribute("user") != null) {
			return "redirect:home.do";
		}
		
		User u = userDao.getUserByLoginCredentials(user.getUsername(), user.getPassword());
		
		if (u != null) {
			session.setAttribute("user", u);
			return "redirect:showProfileAdd.do";
		}
		else {
			message = "Incorrect Password";
			model.addAttribute("message", message);
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
			//model.addAttribute("addedBeers", addedBeers);
			
			//Make map of beers to their ratings
			Map<Beer, Double> beerAndRating = new HashMap<>();
			for(Beer beer : addedBeers) {
				Double beerRating = ratingDao.findAverageBeerRating(beer.getId());
				beerAndRating.put(beer, beerRating);
			}
			model.addAttribute("addedBeers", beerAndRating);
			
			//Adds merit to user profile
			model.addAttribute("merit", ratingDao.getMerit(loggedUser.getId()));
			
			return "userProfile";
		}
		return "home";
	}
	@RequestMapping(path = "showProfileFind.do", method = RequestMethod.GET)
	public String showProfileFind(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "userFavorites";
		}
		return "home";
	}
	
	//Add a Favorite
	@RequestMapping(path = "AddFavoriteReviewsPage.do", method = RequestMethod.POST)
	public String addFavoritesReviewsPage(Integer id, Model model, HttpSession session, RedirectAttributes redir) {
		
		User user = (User) session.getAttribute("user"); 
		
		
		//Alert Message if User selects "Add to Favorite"
		//and selected Beer is already in User's Favorite List
		String message = null; 
		
		if(user.getFavoriteBeers().contains(beerDao.findBeerById(id))) {
			message = "Beer is already in your Favorites!";
			redir.addFlashAttribute("message", message);
			return "redirect:ShowAll.do";
		} else {
			userDao.addToFavorite(id, user);
			session.setAttribute("user", user);
			redir.addFlashAttribute("user", user);
			return "redirect:ShowFavorites.do";
		}
		
	}
	
	//Add a Favorite
	@RequestMapping(path = "AddFavoriteBeerProfilePage.do", method = RequestMethod.POST)
	public String addFavoritesBeerPofilePage(Integer id, Model model, HttpSession session, RedirectAttributes redir) {
		
		User user = (User) session.getAttribute("user"); 
		
		
		//Alert Message if User selects "Add to Favorite"
		//and selected Beer is already in User's Favorite List
		String message = null; 
		
		if(user.getFavoriteBeers().contains(beerDao.findBeerById(id))) {
			message = "Beer is already in your Favorites!";
			redir.addFlashAttribute("message", message);
			redir.addFlashAttribute("id", id);
			return "redirect:beerProfile.do?id=" + id;
		} else {
			userDao.addToFavorite(id, user);
			session.setAttribute("user", user);
			redir.addFlashAttribute("user", user);
			return "redirect:ShowFavorites.do";
		}
		
	}
	
	//Remove a Favorite
	@RequestMapping(path = "RemoveFavorite.do", method = RequestMethod.POST)
	public String removeFavorite(@RequestParam("beerId") int beerId, Model model, HttpSession session, RedirectAttributes redir) {
		
		User user = (User) session.getAttribute("user"); 
		
//		userDao.removeFromFavoriteList(beerId, user.getId());
		userDao.removeFromFavoriteList(beerId, user);
		
		session.setAttribute("user", user);
		
		redir.addFlashAttribute("user", user);
		
		return "redirect:ShowFavorites.do"; 
	}
	
	@RequestMapping(path = "ShowFavorites.do", method = RequestMethod.GET)
	public String showFavorites(Model model, User user) {
		
		List<Beer> favorites = userDao.getFavoriteList(user.getId());
		model.addAttribute("beers", favorites);

		return "userFavorites";
	}
	
	@RequestMapping(path = "ShowFavoritesAlt.do", method = RequestMethod.GET)
	public String showFavoritesAlt(Model model, @RequestParam("userId") int userId) {
		
		List<Beer> favorites = userDao.getFavoriteList(userId);
		model.addAttribute("beers", favorites);
		
		return "userFavorites";
	}
	
 }
