package com.skilldistillery.brewbuds.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Address;
import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.Brewery;
import com.skilldistillery.brewbuds.entities.SubCategory;
import com.skilldistillery.brewbuds.entities.User;

@Service
@Transactional
public class BeerDAOImpl implements BeerDAO {
	
	@PersistenceContext
	private EntityManager em; 
	private String jpql;

	@Override
	public Beer addBeer(Beer beer, User user, String breweryName, String subCatName) {
		System.out.println("------------------------------------------------------------------");
		System.out.println(user);
		System.out.println("------------------------------------------------------------------");
		
		///////////// Check if beer name already exists /////////////
		
		jpql = "SELECT b.name FROM Beer b WHERE b.name = :name";
		List<String> names = em.createQuery(jpql, String.class)
				.setParameter("name", beer.getName())
				.getResultList();
		
		if (names.size() > 0) {
			return null;
		}
		
		//////////////// Set the beer's User //////////////////
			
		beer.setUser(user);
		
		//////////////// Set the beer's SubCategory //////////////////
		
		jpql = "SELECT s FROM SubCategory s WHERE s.name = :subCatName";
		
		SubCategory subCat = em.createQuery(jpql, SubCategory.class)
				.setParameter("subCatName", subCatName)
				.getSingleResult();
		
		beer.setSubCategory(subCat);
		
		//////////////// Set the beer's Brewery //////////////////
		
		jpql = "SELECT b FROM Brewery b WHERE b.name = :breweryName";
		
		List<Brewery> breweries = em.createQuery(jpql, Brewery.class)
				.setParameter("breweryName", breweryName)
				.getResultList();
	
		if (breweries.size() > 0 && breweries.size() <= 1) {
			beer.setBrewery(breweries.get(0));  // If brewery exists, set beer's brewery to the brewery that was returned from DB.
		}
		else {
			Address breweryAddress = new Address();
			Brewery newBrewery = new Brewery();
			newBrewery.setAddress(breweryAddress);
			em.persist(breweryAddress);
			newBrewery.setName(breweryName);
			em.persist(newBrewery);
			beer.setBrewery(newBrewery);
		}
		
		
		//////////////// Persist the new Beer //////////////////
		em.persist(beer); 
		
		
		//////////////// Add beer to User's list of addedBeers //////////////////
		
		user.addBeer(beer);
		return beer;
	}

	@Override
	public Beer updateBeer(int id, Beer beer) {
		Beer dbBeer = em.find(Beer.class,id);
		dbBeer.setAlcoholByVolume(beer.getAlcoholByVolume());
		dbBeer.setBitterness(beer.getBitterness());
		dbBeer.setBrewery(beer.getBrewery());
		dbBeer.setColor(beer.getColor());
		dbBeer.setDescription(beer.getDescription());
		dbBeer.setName(beer.getName());
		return dbBeer;
	}

	@Override
	public boolean removeBeer(int id) {
		Beer beer = em.find(Beer.class, id);
		em.remove(beer);
		boolean successfulRemove; 
		successfulRemove = !em.contains(beer); //True => false; False => true; 
		return successfulRemove;
	}

	@Override
	public List<Beer> showAllBeers() {
		String jpql = "SELECT b FROM Beer b";
		List<Beer> beers = em.createQuery(jpql, Beer.class).getResultList();
//		System.out.println("=========================================================================================");
//		System.out.println(beers.size());
//		System.out.println("=========================================================================================");
		return beers;
	}

	@Override
	public Beer findBeerById(int beerId) {
		return em.find(Beer.class, beerId);
	}

	//Make sure to switch to (-5) on Line 122 once DB is populated w/ more reviews
	@Override
	public List<Beer> showTopFive() {
		
		String jpql = "SELECT b FROM Beer b";
		List<Beer> beers = em.createQuery(jpql, Beer.class).getResultList();
		
		
		
		List<Beer> topFive = new ArrayList<Beer>(beers.subList(beers.size() -5, beers.size()));
		
		return topFive;
	}

	@Override
	public List<Beer> findBeerByKeyword(String keyword) {
		
		jpql = "SELECT b FROM Beer b"
				+ " WHERE b.name LIKE :keyword"
				+ " OR b.description LIKE :keyword"
				+ " OR b.brewery.name LIKE :keyword";
		
		List<Beer> beers = em.createQuery(jpql, Beer.class)
				.setParameter("keyword", "%" + keyword + "%")
				.getResultList();
				
		return beers;
	} 

}
