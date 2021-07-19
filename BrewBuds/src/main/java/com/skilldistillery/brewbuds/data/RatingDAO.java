package com.skilldistillery.brewbuds.data;

import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;

public interface RatingDAO {

	//add rating for beer
	void addBeerRating(int beerId, int userId, int ratingVal, String comment);
	void deleteBeerRating(RatingId ratingId);
	//void updateBeerRating();
	double findAverageBeerRating(int beerId);
	double findAverageUserRating(int userId);
}
