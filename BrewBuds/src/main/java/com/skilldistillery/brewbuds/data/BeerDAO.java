package com.skilldistillery.brewbuds.data;

import java.util.List;

import com.skilldistillery.brewbuds.entities.Beer;

public interface BeerDAO {
	public Beer create(Beer beer); 
	public Beer update(int id, Beer beer); 
	public boolean remove(int id); 
	public List<Beer> showAll();
}
