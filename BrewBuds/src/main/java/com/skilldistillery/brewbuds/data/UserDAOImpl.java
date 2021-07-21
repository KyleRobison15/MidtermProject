package com.skilldistillery.brewbuds.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.Address;
import com.skilldistillery.brewbuds.entities.Beer;
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
		Address address = new Address(); 	// Instantiate a new Address (make it a managed entity)

		jpql = "SELECT u.username, u.email FROM User u WHERE u.username = :username OR u.email = :email";

		List<Object[]> verification = em.createQuery(jpql, Object[].class)
				.setParameter("username", newUser.getUsername()).setParameter("email", newUser.getEmail())
				.getResultList(); 

		if (!verification.isEmpty()) {		// If result list is not empty - duplicate username or email
			return false; 					// Return false to indicate newUser was NOT created
		}

		if (newUser.getPassword().equals(confirmPassword)) { // Check user entered password correctly
			
			em.persist(address); 				// Persist the address to the DB so we have a foreign key for the new user
			newUser.setAddress(address); 		// Assign the new address to the new user											 
			em.persist(newUser);				// Persist the new user
			
		} else {
			return false; 					// Return false if passwords didn't match
		}

		return true;
	}

	@Override
	public User getUserByLoginCredentials(String username, String password) {

		jpql = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";

		List<User> users = em.createQuery(jpql, User.class)
				.setParameter("username", username)
				.setParameter("password", password)
				.getResultList();
		
		if (users.size() > 0 && users.size() <= 1) {
			return users.get(0);
		}
		return null;
	}
	
	@Override
	public User updateUser(int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Beer> addToFavorite(int beerId, int userId) {
		
		User user = em.find(User.class, userId);
		Beer beer = em.find(Beer.class, beerId);
		
		user.addFavoriteBeer(beer);
		
		return user.getFavoriteBeers();
	}

	@Override
	public List<Beer> getFavoriteList(int userId) {
		User user = em.find(User.class, userId);
		return user.getFavoriteBeers();
	}

	@Override
	public boolean removeFromFavoriteList(int beerId, int userId) {
		
		User user = em.find(User.class, userId);
		Beer beer = em.find(Beer.class, beerId);
		
		user.removeFavoriteBeer(beer);
		
		boolean successfulRemove; 
		
		successfulRemove = !user.getFavoriteBeers().contains(beer);
			
		return successfulRemove;
	}

}
