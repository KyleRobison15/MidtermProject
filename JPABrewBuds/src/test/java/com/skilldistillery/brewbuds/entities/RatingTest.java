package com.skilldistillery.brewbuds.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class RatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Rating rating;
	
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
		RatingId ratingId = new RatingId();
		ratingId.setBeerId(1);
		ratingId.setUserId(2);
		rating = em.find(Rating.class, ratingId);
	}
	
	@AfterEach	
	void tearDown() throws Exception {
		em.close();
		rating = null;
	}
	
	@Test
	@DisplayName("Testing rating mappings")
	void test1() throws Exception {
		
		assertNotNull(rating);
		assertEquals(5, rating.getRating());
		
	}

}
