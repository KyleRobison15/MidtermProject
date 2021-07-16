package com.skilldistillery.brewbuds.data;

import com.skilldistillery.brewbuds.entities.User;

public interface UserDAO {
	
	User findById(int id);

}
