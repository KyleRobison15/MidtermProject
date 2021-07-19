package com.skilldistillery.brewbuds.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Brewery;

@Service
@Transactional
public class BreweryDAOImpl implements BreweryDAO {

	@PersistenceContext
	private EntityManager em; 
	
	@Override
	public Brewery getBrewery(int id) {
		return em.find(Brewery.class, id); 
	}

	@Override
	public Brewery create(Brewery brew) {
		em.persist(brew); 
		return brew;
	}

	@Override
	public Brewery update(int id, Brewery brew) {
		Brewery dbBrewery = em.find(Brewery.class,id);
		dbBrewery.setBeers(brew.getBeers());
		dbBrewery.setAddress(brew.getAddress());
		dbBrewery.setDescription(brew.getDescription());
		dbBrewery.setName(brew.getName());
		return dbBrewery;
	}

	@Override
	public boolean remove(int id) {
		Brewery Brew = em.find(Brewery.class, id);
		em.remove(Brew);
		boolean successfulRemove; 
		successfulRemove = !em.contains(Brew); //True => false; False => true; 
		return successfulRemove;
	}

	@Override
	public List<Brewery> showBeers() {
		String jpql = "SELECT b FROM Brewery b";
		List<Brewery> Brews = em.createQuery(jpql, Brewery.class).getResultList();
		return Brews;
	}

	//Add Average Rating Calculation 
	//It will average all of the Brewery's Beers Ratings - Beer Rating Total / Number of Beers
	
	
}
