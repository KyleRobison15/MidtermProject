package com.skilldistillery.brewbuds.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Beer;

@Service
@Transactional
public class BeerDAOImpl implements BeerDAO {
	
	@PersistenceContext
	private EntityManager em; 

	@Override
	public Beer create(Beer beer) {
		em.persist(beer); 
		return beer;
	}

	@Override
	public Beer update(int id, Beer beer) {
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
	public boolean remove(int id) {
		Beer beer = em.find(Beer.class, id);
		em.remove(beer);
		boolean successfulRemove; 
		successfulRemove = !em.contains(beer); //True => false; False => true; 
		return successfulRemove;
	}

	@Override
	public List<Beer> showAll() {
		String jpql = "SELECT b FROM Beer b";
		List<Beer> beers = em.createQuery(jpql, Beer.class).getResultList();
		return beers;
	}

	@Override
	public Beer find(int beerId) {

		return em.find(Beer.class, beerId);
	}

}
