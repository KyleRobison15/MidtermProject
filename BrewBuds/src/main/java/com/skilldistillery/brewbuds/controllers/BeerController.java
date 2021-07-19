package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.brewbuds.data.BeerDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.entities.Beer;

@Controller
public class BeerController {

	@Autowired
	private BeerDAO dao;
	
	@Autowired
	private RatingDAO ratingDao;
	
//	@RequestMapping(path = {"/", "home.do"})
//	public String home(Model model) {
//		return "home";
//	}
	
	@RequestMapping(path = "ShowAll.do", method = RequestMethod.GET)
	public String showReviews(Model model) {
		model.addAttribute("beers", dao.showAll());
		return "beer/reviews";
	}
	
	@RequestMapping(path = "submitRating.do", method = RequestMethod.POST,
					params = {"rating", "comment"})
	public ModelAndView submitRating(String rating, String comment, String userId, String beerId) {
		ModelAndView mv = new ModelAndView();
		
		ratingDao.addBeerRating(Integer.valueOf(beerId), Integer.valueOf(userId), Integer.valueOf(rating), comment);
		
		mv.addObject("beer", dao.find(Integer.valueOf(beerId)));
		mv.setViewName("beer/beerProfile");
		return mv;
	}
	
	@RequestMapping(path = "beerProfile.do", method = RequestMethod.GET)
	public String beerProfile(Model model, int id) {
		model.addAttribute("beer", dao.find(id));
		return "beer/beerProfile";
	}
	
	
}
