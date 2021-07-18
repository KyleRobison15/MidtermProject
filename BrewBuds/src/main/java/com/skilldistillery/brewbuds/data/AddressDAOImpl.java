package com.skilldistillery.brewbuds.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import org.springframework.stereotype.Service;
import com.skilldistillery.brewbuds.entities.Address;

@Service
@Transactional
public class AddressDAOImpl implements AddressDAO {

	@PersistenceContext
	private EntityManager em;
	private String jpql;
	
	@Override
	public Address findById(int id) {
		
		Address address = em.find(Address.class, id);
		
		return address;
	}

	@Override
	public Address addAddress(Address address) {
		em.persist(address);
		return address;
	}
	
	

	
	
}
