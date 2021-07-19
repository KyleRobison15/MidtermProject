package com.skilldistillery.brewbuds.data;

import com.skilldistillery.brewbuds.entities.User;

public interface UserDAO {
	
	public User findById(int id);
	public boolean createUserAccount(User newUser, String confirmPassword);
	public User getUserByLoginCredentials(String username, String password);
	public User updateUser(int userId, User user);

}
