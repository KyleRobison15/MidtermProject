package com.skilldistillery.brewbuds.data;

import java.util.List;

import com.skilldistillery.brewbuds.entities.Brewery;

public interface BreweryDAO {
	public Brewery getBrewery(int id); 
	public Brewery create(Brewery brew); 
	public Brewery update(int id, Brewery brew); 
	public boolean remove(int id); 
	public List<Brewery> showBeers();
}
