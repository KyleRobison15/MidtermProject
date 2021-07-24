package com.skilldistillery.brewbuds.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.brewbuds.data.BeerDAO;
import com.skilldistillery.brewbuds.data.BreweryDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.UserDAO;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Brewery;
import com.skilldistillery.brewbuds.entities.User;

@Controller
public class HomeController {
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired 
	private BeerDAO beerDAO;
	
	@Autowired 
	private BreweryDAO breweryDAO; 
	
	@Autowired
	private RatingDAO ratingDao;
	
	@RequestMapping(path = {"/", "home.do"}, method = RequestMethod.GET)
	public String home(Model model, String message) {
		
//		model.addAttribute("beers", beerDAO.showTopFive());
//		model.addAttribute("breweries", breweryDAO.showTopFive());
//		Double average = ratingDao.findAverageBeerRating(id);
//		model.addAttribute("average", average);
//		List<Beer> beers = beerDAO.showTopFive();
		
		//Get sorted Beers, Breweries, and Users
		Map<Double, Beer> ratingAndBeer = ratingDao.getBeersAndRatingsSortedByRating(); 
		Map<Double, Brewery> ratingAndBrewery = ratingDao.getBreweriesSortedByRating(); 
		Map<Double, User> ratingAndUser = ratingDao.getUsersSortedByRating(); 
		List<User> allUsers = userDao.getAllUsers();
		Map<User, Integer> usersAndMerit = ratingDao.getUserAndMerit(allUsers);
		//Pass the sorted maps to home.jsp
		model.addAttribute("beers", ratingAndBeer);
		model.addAttribute("breweries", ratingAndBrewery); 
		model.addAttribute("users", ratingAndUser); 
		model.addAttribute("usersAndMerit", usersAndMerit);
		model.addAttribute("message", message);
		return "home";
	}
	
	@RequestMapping(path = "createAccountPage.do")
	public String showCreateAccountPage(Model model) {
		return "createAccount";
	}
	
	@RequestMapping(path = "updateAccountPage.do")
	public String showUpdateAccountPage(Model model, int id) {
		model.addAttribute("user",userDao.findById(id));
		return "updateAccount";
	}

	@RequestMapping(path = "loginPage.do")
	public String showLoginPage(Model model) {
		return "login";
	}
	
	@RequestMapping(path = "about.do")
	public String showAboutPage(Model model) {
		return "about";
	}
	
}
