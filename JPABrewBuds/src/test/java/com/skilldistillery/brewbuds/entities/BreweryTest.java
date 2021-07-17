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

class BreweryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Brewery brewery; 

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABrewBuds");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		brewery = em.find(Brewery.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		brewery = null; 
	}
	
	@Test
	@DisplayName("testing brewery mapping")
	void test() {
		assertNotNull(brewery);
		assertEquals("Sierra Nevada", brewery.getName());
		assertEquals("It changed tastes, made hops famous, and brought an industry back from extinction. That’s a hard-working beer."
						, brewery.getDescription());
	}
	
	@Test
	@DisplayName("testing brewery and beer mapping")
	void test2() {
		assertNotNull(brewery);
		assertNotNull(brewery.getBeers());
		assertTrue(brewery.getBeers().size() > 0); 
		assertEquals(1, brewery.getBeers().size());
	}
	


}
