package com.skilldistillery.brewbuds.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.brewbuds.data.BreweryDAO;

@Controller
public class BreweryController {

	@Autowired
	BreweryDAO dao; 
	
	@RequestMapping(path = "BreweryInfo.do", method = RequestMethod.GET)
	public String showReviews(int id, Model model) {
		model.addAttribute("brewery", dao.getBrewery(id));
		model.addAttribute("beers", dao.showBeers());
		return "brewery/info";
	}
	
}
