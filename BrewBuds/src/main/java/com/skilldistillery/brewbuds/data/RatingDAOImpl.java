package com.skilldistillery.brewbuds.data;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Brewery;
import com.skilldistillery.brewbuds.entities.Rating;
import com.skilldistillery.brewbuds.entities.RatingId;
import com.skilldistillery.brewbuds.entities.User;

@Service
@Transactional
public class RatingDAOImpl implements RatingDAO {
	
	@PersistenceContext
	EntityManager em;
	String jpql;
	
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
		
		//rating.setRatingDate(null);

		em.persist(rating);
		System.out.println("Success");
		
	}

	@Override
	public void updateBeerRating(int beerId, int userId, int ratingVal, String comment) {

		RatingId ratingId = new RatingId();
		ratingId.setUserId(userId);
		ratingId.setBeerId(beerId);
		
		Rating rating = em.find(Rating.class, ratingId);
		
		rating.setRating(ratingVal);
		rating.setComment(comment);
		//rating.setRatingDate(null);
		
		//em.getTransaction().commit();
		
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
		
		if(beer.getRatings().size() == 0) {
			return 0;
		}
		
		int total = 0;
		
		for (Rating rating : beer.getRatings()) {
			
			total += rating.getRating();
			
		}
		
		average = (double) total / (double) beer.getRatings().size();
		
		
        DecimalFormat df = new DecimalFormat("#.##");
        average = Double.valueOf(df.format(average));
		
		return average;
	}
	
	@Override
	public double findAverageBeerRating(int beerId, boolean isBreweryRating) {
		
		//String jpql = "SELECT AVG(r.rating) FROM Rating r WHERE r.beer_id= :beerId";
		
		//Double average = em.createQuery(jpql, Double.class).setParameter("beerId", beerId).getSingleResult();
		
		double average;
		
		Beer beer = em.find(Beer.class, beerId);
		
		if(beer.getRatings().size() == 0) {
			return 0;
		}
		
		int total = 0;
		
		for (Rating rating : beer.getRatings()) {
			
			total += rating.getRating();
			
		}
		
		average = (double) total / (double) beer.getRatings().size();
		
		
//		DecimalFormat df = new DecimalFormat("#.##");
//		average = Double.valueOf(df.format(average));
		
		return average;
	}
	
	
	@Override
	public double findAverageUserRating(int userId) {
		
		double average;
		
		User user = em.find(User.class, userId);
		
		
		if(user.getAddedBeers().size() == 0) {
			return 0;
		}
		
		int total = 0;
		for(Beer beer : user.getAddedBeers()) {
			
			total += findAverageBeerRating(beer.getId());
			
		}
	
		average = (double) total / (double) user.getAddedBeers().size();
		
//		double d = 1.234567;
        DecimalFormat df = new DecimalFormat("#.##");
        average = Double.valueOf(df.format(average));
		
		return average;
		
	}


	@Override
	public double findAverageBreweryRating(int breweryId) {

		double average;
		
		Brewery brewery = em.find(Brewery.class, breweryId);
		
		List<Beer> beers = brewery.getBeers();
		
		int total = 0;
		
		for(Beer beer : beers) {
			
			total += findAverageBeerRating(beer.getId(),true);
		}
		
		average = (double) total / (double) beers.size();
		
        DecimalFormat df = new DecimalFormat("#.##");
        average = Double.valueOf(df.format(average));
		
		return average;
	}

	@Override
	public Rating getRating(RatingId ratingId) {

		return em.find(Rating.class, ratingId);
	}


	@Override
	public int getMerit(int userId) {
		
		User user = em.find(User.class, userId);
		
		List<Beer> addedBeers = user.getAddedBeers();
		
		int merit = 0;
		
		for (Beer beer : addedBeers) {
			merit += beer.getRatings().size();
		}
		
		return merit;
		
	}
	
	@Override
	public Map<User, Integer> getUserAndMerit(List<User> users) {
		Map<User, Integer> userAndMerit = new HashMap<>();
		
		for (User user : users) {
			int merit = getMerit(user.getId());
			userAndMerit.put(user, merit);
		}
		return userAndMerit;
	}

	@Override
	public Map<Double, Beer> getBeersAndRatingsSortedByRating() {
		
//		jpql = "SELECT r.beer FROM Rating r GROUP BY r.beer ORDER BY AVG(r.rating) DESC";
		jpql = "SELECT r.beer, AVG(r.rating) FROM Rating r GROUP BY r.beer ORDER BY AVG(r.rating) DESC, r.beer.name";
		
		List<Object[]> results = em.createQuery(jpql, Object[].class).getResultList();
	
		Map<Double, Beer> ratingAndBeer = new TreeMap<>((d1,d2)-> (int)(100*(d2-d1)));
		
		for (Object[] o : results) {
			ratingAndBeer.put((Double)o[1], (Beer)o[0]);
		}
		
		return ratingAndBeer;
	}

	
	@Override
	public List<Beer> getBeersSortedByRating() {
		
		List<Beer> beersSortedByRating = null;
		
		jpql = "SELECT r.beer FROM Rating r GROUP BY r.beer ORDER BY AVG(r.rating) DESC";
//		jpql = "SELECT r.beer, AVG(r.rating) FROM Rating r GROUP BY r.beer ORDER BY AVG(r.rating) DESC";
		
		beersSortedByRating = em.createQuery(jpql, Beer.class).getResultList();

		return beersSortedByRating;
	}
	
	@Override
	public Map<Double, Brewery> getBreweriesSortedByRating() {
		
		jpql = "SELECT b FROM Brewery b";
		List<Brewery> breweries = em.createQuery(jpql,Brewery.class).getResultList();
		
		Map<Brewery, Double> breweryAndRating = new HashMap<>();
		
		for(Brewery brewery : breweries) {
			Double breweryRating = findAverageBreweryRating(brewery.getId()); 
			breweryAndRating.put(brewery, breweryRating); 
		}
		
		Map<Double, Brewery> ratingAndBrewery = new TreeMap<>((d1,d2)-> (int)(100*(d2-d1)));
		
		Set<Brewery> keySet = breweryAndRating.keySet();
		for (Brewery brewery : keySet) {
			ratingAndBrewery.put(breweryAndRating.get(brewery), brewery);
		}
		
		return ratingAndBrewery;
	}

	@Override
	public Map<Double, User> getUsersSortedByRating() {
		
		jpql = "SELECT u FROM User u";
		List<User> users = em.createQuery(jpql,User.class).getResultList();
		
		Map<User, Double> userAndRating = new HashMap<>();
		
		int counter = 0; 
		for(User user : users) {
			System.out.println(counter);
			counter++;
			Double userRating = findAverageUserRating(user.getId()); 
			userAndRating.put(user, userRating); 
		}
		
		Map<Double, User> ratingAndUser = new TreeMap<>((d1,d2)-> (int)(100*(d2-d1)));
		
		Set<User> keySet = userAndRating.keySet();
		for (User user : keySet) {
			ratingAndUser.put(userAndRating.get(user), user);
		}
		
		return ratingAndUser;
	}

	@Override
	public Map<Double, Beer> getBeersAndRatingsByKeyword(String keyword) {
		
//		jpql = "SELECT r.beer FROM Rating r GROUP BY r.beer ORDER BY AVG(r.rating) DESC";
		jpql = "SELECT r.beer, AVG(r.rating) FROM Rating r"
				+ " WHERE r.beer.name LIKE :keyword"
				+ " OR r.beer.description LIKE :keyword"
				+ " OR r.beer.brewery.name LIKE :keyword"
				+ " GROUP BY r.beer ORDER BY AVG(r.rating) DESC, r.beer.name";
				
		List<Object[]> results = em.createQuery(jpql, Object[].class)
				.setParameter("keyword", "%" + keyword + "%")
				.getResultList();
	
		Map<Double, Beer> ratingAndBeer = new TreeMap<>((d1,d2)-> (int)(100*(d2-d1)));
		
		for (Object[] o : results) {
			ratingAndBeer.put((Double)o[1], (Beer)o[0]);
		}
		
		return ratingAndBeer;
	}
	
}
