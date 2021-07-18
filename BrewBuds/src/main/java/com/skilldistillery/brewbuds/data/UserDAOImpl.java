package com.skilldistillery.brewbuds.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;
	private String jpql;
	
	@Override
	public User findById(int id) {
		return em.find(User.class, id);
	}
	
	@Override
	public boolean createUserAccount(User newUser, String confirmPassword) {
		
		if (newUser.getPassword().equals(confirmPassword)) { // Check that the user entered the password they intended for their account
			try {
				em.persist(newUser); 	// Try to persist newUser
			} catch (Exception e) { 	// Catch SQL exceptions if username and/or email are the same as existing entry in DB
				return false; 			// Return false to indicate newUser was NOT created
			}
		}
		else {
			return false;				// Return false if passwords didn't match
		}
		
		return true;
	}

	@Override
	public User getUserByLoginCredentials(String username, String password) {
	    User u = null;
	    
	    jpql = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
	    
	    u = em.createQuery(jpql, User.class)
	    		.setParameter("username", username)
	    		.setParameter("password", password)
	    		.getSingleResult();

	    return u;
	}

	@Override
	public User updateUser(int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
