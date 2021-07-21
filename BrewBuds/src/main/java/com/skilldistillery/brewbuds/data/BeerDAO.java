package com.skilldistillery.brewbuds.data;

import java.util.List;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.User;

public interface BeerDAO {
	public Beer addBeer(Beer beer, User user, String breweryName, String subCatName); 
	public Beer updateBeer(int id, Beer beer); 
	public boolean removeBeer(int id); 
	public List<Beer> showAllBeers();
	public Beer findBeerById(int beerId);
	public List<Beer> findBeerByKeyword(String keyword);
	public List<Beer> showTopFive(); 
}
