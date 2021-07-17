package com.skilldistillery.brewbuds.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
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
	@DisplayName("TEST: User Mappings for Non-Foreign Key Fields")
	void test1() throws Exception {
		assertNotNull(user);
		
		assertEquals("KyleRobison", user.getUsername()); // username mapping
		assertEquals("admin1", user.getPassword()); // password mapping
		assertTrue(user.isEnabled()); // enabled mapping
		assertEquals("admin", user.getRole()); // role mapping
		
		
		assertEquals("Kyle", user.getFirstName()); // firstName mapping
		assertEquals("Robison", user.getLastName()); // lastName mapping
		assertEquals("admin1@example.com", user.getEmail()); // email mapping
		
		assertEquals(2017, user.getCreateDate().getYear());
		assertEquals(07, user.getCreateDate().getMonthValue()); // createDate mapping
		assertEquals(16, user.getCreateDate().getDayOfMonth());
		
	}
	
	@Test
	@DisplayName("TEST: User Address Mapping")
	void test2() throws Exception {
		assertNotNull(user);
		
		assertEquals(2, user.getAddress().getId());
		assertEquals("100 Main Street", user.getAddress().getAddress());
		assertNull(user.getAddress().getAddress2());
		assertEquals("Atlanta", user.getAddress().getCity());
		assertEquals("GA", user.getAddress().getStateProvince());
		assertEquals("50000", user.getAddress().getPostalCode());
		assertEquals("US", user.getAddress().getCountryCode());
		assertNull(user.getAddress().getPhone());
		
	}

}
