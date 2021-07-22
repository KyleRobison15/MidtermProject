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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.brewbuds.data.BeerDAO;
import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.SubCategoryDAO;
import com.skilldistillery.brewbuds.data.UserDAO;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;
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
	
	@Autowired
	private UserDAO userDao;
	
//	@RequestMapping(path = {"/", "home.do"})
//	public String home(Model model) {
//		return "home";
//	}
	
	@RequestMapping(path = "ShowAll.do", method = RequestMethod.GET)
	public String showReviews(Model model, HttpSession session) {

		List<Beer> beers = dao.showAllBeers();
		Map<Double, Beer> ratingAndBeer = new HashMap<>();
		
		for(Beer beer : beers) {
			Double ratings = ratingDao.findAverageBeerRating(beer.getId());
			ratingAndBeer.put(ratings, beer);
		}
		
		model.addAttribute("beers", ratingAndBeer);
		
		return "reviews";
	}
	
	@RequestMapping(path = "submitRating.do", method = RequestMethod.POST,
					params = {"rating", "comment"})
	public ModelAndView submitRating(String rating, String comment, String userId, String beerId) {
		ModelAndView mv = new ModelAndView();
		
		//Checks to see if user has already left a rating
		//Variables setup:
		RatingId ratingId = new RatingId();
		ratingId.setBeerId(Integer.valueOf(beerId));
		ratingId.setUserId(Integer.valueOf(userId));
		
		User user = userDao.findById(Integer.valueOf(userId));
		boolean alreadyRated = false;
		System.out.println("----------------------------------------------------------------------");
		System.out.println("In submit.do already rated = false");
		System.out.println("----------------------------------------------------------------------");
		
		Rating rating1 = new Rating();
		rating1.setId(ratingId);
		
		//these were moved up from the if statement...
		rating1 = ratingDao.getRating(ratingId);
		mv.addObject("userReview", rating1);
		
		//Check if user owns a rating for this beer:
			//if so, updates the beer rating and adds the updated beer rating to the model
		if(user.getRatings().contains(rating1)) {
			ratingDao.updateBeerRating(Integer.valueOf(beerId), Integer.valueOf(userId), Integer.valueOf(rating), comment);
			alreadyRated = true;
			System.out.println("----------------------------------------------------------------------");
			System.out.println("In submit.do already rated = true");
			System.out.println("----------------------------------------------------------------------");
			//moved up to line 68...
			//ratingDao.updateBeerRating(Integer.valueOf(beerId), Integer.valueOf(userId), Integer.valueOf(rating), comment);
			//rating1 = ratingDao.getRating(ratingId);
			//mv.addObject("userReview", rating1);
		}
		else {
			
			//Adds beer rating if one doesn't already exist
			ratingDao.addBeerRating(Integer.valueOf(beerId), Integer.valueOf(userId), Integer.valueOf(rating), comment);
			alreadyRated = true;
			rating1 = ratingDao.getRating(ratingId);
			mv.addObject("userReview", rating1);
		}
		
		
		//Adds beer to model
		mv.addObject("beer", dao.findBeerById(Integer.valueOf(beerId)));
		
		//Adds average rating of beer to model
		double average = ratingDao.findAverageBeerRating(Integer.valueOf(beerId));
		mv.addObject("average", average);
		
		//Adds already rated boolean to model
		mv.addObject("alreadyRated", alreadyRated);
		
		
		
		mv.setViewName("beerProfile");
		return mv;
	}
	
	@RequestMapping(path = "beerProfile.do", method = RequestMethod.GET)
	public String beerProfile(Model model, Integer id, HttpSession session) {
		
		model.addAttribute("beer", dao.findBeerById(id));
		
		
		User loggedUser = (User) session.getAttribute("user");
		
		if(loggedUser != null) {
		//Checks to see if user has already left a rating
				RatingId ratingId = new RatingId();
				ratingId.setBeerId(Integer.valueOf(id));
				ratingId.setUserId(Integer.valueOf(loggedUser.getId()));
				
				User user = userDao.findById(Integer.valueOf(loggedUser.getId()));
				boolean alreadyRated = false;
				System.out.println("----------------------------------------------------------------------");
				System.out.println("In beerProfile.do already rated = false");
				System.out.println("----------------------------------------------------------------------");
				
				Rating rating1 = new Rating();
				rating1.setId(ratingId);
				
				//Moved up from if statement
				rating1 = ratingDao.getRating(ratingId);
				model.addAttribute("userReview", rating1);
				
				if(user.getRatings().contains(rating1)) {
					alreadyRated = true;
					System.out.println("----------------------------------------------------------------------");
					System.out.println("In beerProfile.do already rated = true");
					System.out.println("----------------------------------------------------------------------");
				}
				model.addAttribute("alreadyRated", alreadyRated);
		////////////////////////////////////////////////////////////
		}

		
		Double average = ratingDao.findAverageBeerRating(id);
		model.addAttribute("average", average);
		
//		model.addAttribute("beer", dao.find(id));
		
		
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
								RedirectAttributes redir, Model model, String rating, String comment) {
		
		
		user = (User)session.getAttribute("user");
		
		
		Beer newBeer = dao.addBeer(beer,user,breweryName,subCatName);
				
		if (newBeer != null) {
//			redir.addFlashAttribute("id", newBeer.getId());
			
			//TODO: add beers rating here
			ratingDao.addBeerRating(newBeer.getId(), user.getId(), Integer.valueOf(rating), comment);
			
			redir.addFlashAttribute("beer",newBeer);
			return "redirect:beerAdded.do";
		}
			model.addAttribute("beer",newBeer);
		return "addBeerFailed";
	}
	
	@RequestMapping(path="beerAdded.do", method=RequestMethod.GET)
	public String beerAdded(Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		boolean alreadyRated = true;
		RatingId ratingId = new RatingId();
		Beer beer = (Beer) model.getAttribute("beer");
		ratingId.setBeerId(beer.getId());
		ratingId.setUserId(user.getId());
		Rating userReview = ratingDao.getRating(ratingId);
		double average = ratingDao.findAverageBeerRating(beer.getId());
		model.addAttribute("average", average);
		model.addAttribute("alreadyRated", alreadyRated);
		model.addAttribute("userReview", userReview);
		beer = dao.findBeerById(beer.getId());
		model.addAttribute("beer", beer);
		
		return"beerProfile";
	}
	

	@RequestMapping(path="deleteRating.do", method=RequestMethod.POST)
	ModelAndView deleteRating(String beerId, String userId) {
		ModelAndView mv = new ModelAndView();
		
		RatingId ratingId = new RatingId();
		ratingId.setBeerId(Integer.valueOf(beerId));
		ratingId.setUserId(Integer.valueOf(userId));
		
		ratingDao.deleteBeerRating(ratingId);
		Beer beer = dao.findBeerById(Integer.valueOf(beerId));
		//User user = userDao.findById(Integer.valueOf(userId));
		mv.addObject("beer", beer);
		//mv.addObject(beerId);
		//mv.addObject(userId);
		
		double average = ratingDao.findAverageBeerRating(Integer.valueOf(beerId));
		
		mv.addObject("average", average);
		mv.setViewName("beerProfile");
		
		return mv;
	}

	@RequestMapping(path = "findBeers.do", params = "keyword")
	public String findBeers(String keyword, Model model) {		
		Map<Double, Beer> ratingAndBeer = ratingDao.getBeersAndRatingsByKeyword(keyword); 
		model.addAttribute("beers", ratingAndBeer);
		return"reviews";
	}
	
}
