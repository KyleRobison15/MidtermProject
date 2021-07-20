package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.brewbuds.data.BeerDAO;
import com.skilldistillery.brewbuds.data.BreweryDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.UserDAO;

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
	public String home(Model model) {
		model.addAttribute("beers", beerDAO.showTopFive());
		model.addAttribute("breweries", breweryDAO.showTopFive());
//		Double average = ratingDao.findAverageBeerRating(id);
//		model.addAttribute("average", average);
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
	
}
