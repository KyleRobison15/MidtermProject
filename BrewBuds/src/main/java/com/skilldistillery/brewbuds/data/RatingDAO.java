package com.skilldistillery.brewbuds.data;

import java.util.List;
import java.util.Map;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Brewery;
import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;
import com.skilldistillery.brewbuds.entities.User;

public interface RatingDAO {

	//add rating for beer
	void addBeerRating(int beerId, int userId, int ratingVal, String comment);
	void deleteBeerRating(RatingId ratingId);
	//void updateBeerRating();
	double findAverageBeerRating(int beerId);
	double findAverageBeerRating(int beerId, boolean isBreweryRating);
	double findAverageUserRating(int userId);
	double findAverageBreweryRating(int breweryId);
	void updateBeerRating(int beerId, int userId, int ratingVal, String comment);
	Rating getRating(RatingId ratingId);
	int getMerit(int userId);
	Map<User, Integer> getUserAndMerit(List<User> users);
	public Map<Double, Brewery> getBreweriesSortedByRating();
	public Map<Double, Beer> getBeersAndRatingsSortedByRating();
	public Map<Double, Beer> getBeersAndRatingsByKeyword(String keyword);
	public Map<Double, User> getUsersSortedByRating(); 
	public List<Beer> getBeersSortedByRating();
	
}