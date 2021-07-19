package com.skilldistillery.brewbuds;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.skilldistillery.brewbuds.data.RatingDAO;
import com.skilldistillery.brewbuds.data.RatingDAOImpl;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;
import com.skilldistillery.brewbuds.entities.User;


public class RatingDAOTestDraft {
	

	public static void main(String[] args) {
//		
//		EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPABrewBuds");
//		EntityManager em = emf.createEntityManager();	
		
		RatingDAO dao = new RatingDAOImpl();
		
		String comment = "This is totally a test rating";
		int ratingVal = 3;
		int beerId = 1;
		int userId = 1;
		
		dao.addBeerRating(beerId, userId, ratingVal, comment);
		
//				em.getTransaction().begin();
//				RatingId ratingId = new RatingId();
//				ratingId.setBeerId(beerId);
//				ratingId.setUserId(userId);
//				
//				Rating rating = new Rating();
//				rating.setId(ratingId);
//				
//				Beer beer = em.find(Beer.class, beerId);
//				rating.setBeer(beer);
//				
//				User user = em.find(User.class, userId);
//				rating.setUser(user);
//				
//				rating.setRating(ratingVal);
//				rating.setComment(comment);
//				rating.setRatingDate(null);
//
//				em.persist(rating);
//				em.getTransaction().commit();
		
		System.out.println("Great success!");
		
//		EntityManagerFactory emf = Persistence.createEntityManagerFactory("JPABrewBuds");
//		EntityManager em = emf.createEntityManager();	
//		em.getTransaction().begin();
//		
//		RatingDAO dao = new RatingDAOImpl();
//
//////		delete beer a rating
////		RatingId ratingId = new RatingId();
////		ratingId.setBeerId(1);
////		ratingId.setUserId(2);
////		
////		dao.deleteBeerRating(ratingId);
//		
//		RatingId ratingId = new RatingId();
//		ratingId.setBeerId(1);
//		ratingId.setUserId(1);
//		
//		
//		Rating rating = new Rating();
//		rating.setId(ratingId);
//		
//		Beer beer1 = em.find(Beer.class, 1);
//		rating.setBeer(beer1);
//		
//		User user1 = em.find(User.class, 1);
//		rating.setUser(user1);
//		
//		rating.setRating(3);
//		rating.setComment("this is just a test comment");
//		rating.setRatingDate(null);
//		
////		rating.setBeer(beer);
////		rating.setUser(user);
//		
//		//dao.addBeerRating(rating);
//		em.persist(rating);
//		em.getTransaction().commit();
//		System.out.println("Success");
		
		
//		System.out.println("-------------------------------------------------------------------------------------------------------------------------------------");
//		System.out.println("Avg. rating for user id 2: " + dao.findAverageUserRating(2));
//		System.out.println("-------------------------------------------------------------------------------------------------------------------------------------");
//		System.out.println("Avg. rating for beer id 1: " + dao.findAverageBeerRating(1));
//		System.out.println("Avg. rating for brewery id 1: " + dao.findAverageBreweryRating(1));
		
		
	}

}
