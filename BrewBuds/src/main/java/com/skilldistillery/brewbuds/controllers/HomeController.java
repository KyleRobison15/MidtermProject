package com.skilldistillery.brewbuds.controllers;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
		
//		model.addAttribute("beers", beerDAO.showTopFive());
//		model.addAttribute("breweries", breweryDAO.showTopFive());
//		Double average = ratingDao.findAverageBeerRating(id);
//		model.addAttribute("average", average);
		
		Map<Beer, Double> beerAndRating = new HashMap<>(); 
		List<Beer> beers = beerDAO.showTopFive();
		
		for(Beer beer : beers) {
			Double beerRating = ratingDao.findAverageBeerRating(beer.getId()); 
			beerAndRating.put(beer, beerRating); 
		}
		
		model.addAttribute("beers", beerAndRating); 
		
		

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
