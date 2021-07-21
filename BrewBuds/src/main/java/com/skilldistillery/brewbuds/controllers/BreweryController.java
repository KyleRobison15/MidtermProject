package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.brewbuds.data.BreweryDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;

@Controller
public class BreweryController {

	@Autowired
	BreweryDAO dao; 
	
	@Autowired
	RatingDAO ratingDao;
	
	@RequestMapping(path = "BreweryInfo.do", method = RequestMethod.GET)
	public String showReviews(int id, Model model) {
		model.addAttribute("brewery", dao.getBrewery(id));
//		model.addAttribute("average", ratingDao.findAverageBreweryRating(id));
//		model.addAttribute("beers", dao.showBeers());
		model.addAttribute("beers", dao.getBrewery(id).getBeers());
		return "info";
	}
	
	@RequestMapping(path = "findBreweries.do", params = "keyword")
	public String findBeers(String keyword, Model model) {		
		model.addAttribute("breweries", dao.findBreweryByKeyword(keyword));
		return"showBreweries";
	}
	
}
