package com.skilldistillery.brewbuds.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.BeerDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.SubCategoryDAO;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.SubCategory;
import com.skilldistillery.brewbuds.entities.User;

@Controller
public class BeerController {

	@Autowired
	private BeerDAO dao;
	
	@Autowired
	private RatingDAO ratingDao;
	
	@Autowired
	private SubCategoryDAO subDao;
	
//	@RequestMapping(path = {"/", "home.do"})
//	public String home(Model model) {
//		return "home";
//	}
	
	@RequestMapping(path = "ShowAll.do", method = RequestMethod.GET)
	public String showReviews(Model model) {
		model.addAttribute("beers", dao.showAllBeers());
		return "reviews";
	}
	
	@RequestMapping(path = "submitRating.do", method = RequestMethod.POST,
					params = {"rating", "comment"})
	public ModelAndView submitRating(String rating, String comment, String userId, String beerId) {
		ModelAndView mv = new ModelAndView();
		
		ratingDao.addBeerRating(Integer.valueOf(beerId), Integer.valueOf(userId), Integer.valueOf(rating), comment);
		
		mv.addObject("beer", dao.findBeerById(Integer.valueOf(beerId)));
		mv.setViewName("beerProfile");
		return mv;
	}
	
	@RequestMapping(path = "beerProfile.do", method = RequestMethod.GET)
	public String beerProfile(Model model, int id) {
		model.addAttribute("beer", dao.findBeerById(id));
		return "beerProfile";
	}
	
	@RequestMapping(path="addBeerPage.do", method=RequestMethod.GET)
	public String addBeerPage(Model model, HttpSession session) {
		List<SubCategory> subCategories = subDao.getAllSubCategories();
		model.addAttribute("subCategories",subCategories);
		model.addAttribute("user",session.getAttribute("user"));
		return"addBeer";
	}
	
	@RequestMapping(path = "addBeer.do", method = RequestMethod.POST)
	public String addBeer(Beer beer, User user, HttpSession session, String breweryName, String subCatName,
								RedirectAttributes redir, Model model) {
		
		
		user = (User)session.getAttribute("user");
		
		
		Beer newBeer = dao.addBeer(beer,user,breweryName,subCatName);
				
		if (newBeer != null) {
//			redir.addFlashAttribute("id", newBeer.getId());
			redir.addFlashAttribute("beer",newBeer);
			return "redirect:beerAdded.do";
		}
			model.addAttribute("beer",newBeer);
		return "addBeerFailed";
	}
	
	@RequestMapping(path="beerAdded.do", method=RequestMethod.GET)
	public String beerAdded(Model model) {
		
		Beer beer = (Beer) model.getAttribute("beer");
		model.addAttribute("beer", beer);
		
		return"beerProfile";
	}
	
}
