package com.skilldistillery.brewbuds.data;

import java.util.List;

import com.skilldistillery.brewbuds.entities.Beer;
import com.skilldistillery.brewbuds.entities.User;

public interface UserDAO {
	
	public User findById(int id);
	public List<User> getAllUsers();
	public boolean createUserAccount(User newUser, String confirmPassword);
	public User getUserByLoginCredentials(String username, String password);
	public boolean updateUser(User user, String confirmPassword);
	public List<Beer> addToFavorite(int beerId, int userId); 
	public List<Beer> getFavoriteList(int userId); 
	public boolean removeFromFavoriteList(int beerId, User user);
	public List<Beer> addToFavorite(Integer id, User user);
}
