package com.skilldistillery.brewbuds.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	
	@BeforeAll
	static void setUP() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABrewBuds");
	}
	
	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}
	
	@AfterEach	
	void tearDown() throws Exception {
		em.close();
		user = null;
	}
	
	@Test
	@DisplayName("TEST: User Field Mappings")
	void test1() throws Exception {
		assertNotNull(user);
		
		assertEquals("BeerTaster25", user.getUsername()); // username mapping
		assertEquals("beer", user.getPassword()); // password mapping
		assertTrue(user.isEnabled()); // enabled mapping
		assertEquals("user", user.getRole()); // role mapping
		
		
		assertEquals("Kyle", user.getFirstName()); // firstName mapping
		assertEquals("Robison", user.getLastName()); // lastName mapping
		assertEquals("kyler@gmail.com", user.getEmail()); // email mapping
		
	}

}
