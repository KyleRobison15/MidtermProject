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
	
	@Override
	public User findById(int id) {
		// TODO Auto-generated method stub
		return em.find(User.class, id);
	}

}
