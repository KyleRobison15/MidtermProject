package com.skilldistillery.brewbuds.data;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;
import com.skilldistillery.brewbuds.entities.User;

@Service
@Transactional
public class RatingDAOImpl implements RatingDAO {
	
	@PersistenceContext
	EntityManager em;
	
	@Override
	public void addBeerRating(int beerId, int userId, int ratingVal, String comment) {

		RatingId ratingId = new RatingId();
		ratingId.setBeerId(beerId);
		ratingId.setUserId(userId);
		
		Rating rating = new Rating();
		rating.setId(ratingId);
		
		Beer beer = em.find(Beer.class, beerId);
		rating.setBeer(beer);
		
		User user = em.find(User.class, userId);
		rating.setUser(user);
		
		rating.setRating(ratingVal);
		rating.setComment(comment);
		rating.setRatingDate(null);

		em.persist(rating);
		System.out.println("Success");
		
	}

	
	@Override
	public void deleteBeerRating(RatingId ratingId) {
		Rating rating = em.find(Rating.class, ratingId);
		System.out.println("-----------------------------------------------------------------------------------------------------------");
		System.out.println(rating);
		rating.getUser().removeRating(rating);
		rating.getBeer().removeRating(rating);
		
		em.remove(rating);
	}


	@Override
	public double findAverageBeerRating(int beerId) {

		//String jpql = "SELECT AVG(r.rating) FROM Rating r WHERE r.beer_id= :beerId";
		
		//Double average = em.createQuery(jpql, Double.class).setParameter("beerId", beerId).getSingleResult();
		
		double average;
		
		Beer beer = em.find(Beer.class, beerId);
		
		int total = 0;
		
		for (Rating rating : beer.getRatings()) {
			
			total += rating.getRating();
			
		}
		
		average = (double) total / (double) beer.getRatings().size();
		
		return average;
	}


	@Override
	public double findAverageUserRating(int userId) {
		
		double average;
		
		User user = em.find(User.class, userId);
		
		int total = 0;
		
		for (Rating rating : user.getRatings()) {
			
			total += rating.getRating();
			
		}
		
		average = (double) total / (double) user.getRatings().size();
		
		return average;
		
	}
	
}
