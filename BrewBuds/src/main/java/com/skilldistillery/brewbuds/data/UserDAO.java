package com.skilldistillery.brewbuds.data;

import java.util.List;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.User;

public interface UserDAO {
	
	public User findById(int id);
	public boolean createUserAccount(User newUser, String confirmPassword);
	public User getUserByLoginCredentials(String username, String password);
	public User updateUser(int userId, User user);
	public List<Beer> addToFavorite(int beerId, int userId); 
	public List<Beer> getFavoriteList(int userId); 
	public boolean removeFromFavoriteList(int beerId, int userId);
}
