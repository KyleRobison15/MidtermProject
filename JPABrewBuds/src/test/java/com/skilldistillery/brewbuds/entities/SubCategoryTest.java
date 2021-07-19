package com.skilldistillery.brewbuds.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class SubCategoryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private SubCategory sub;  

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
		sub = em.find(SubCategory.class, 17);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		sub = null; 
	}
	
	@Test
	@DisplayName("testing main_category mapping")
	void test1() {
		assertNotNull(sub);
		assertEquals("New England IPA", sub.getName()); 
	}
	
	@Test
	@DisplayName("TEST: MainCategory Mapping")
	void test2() {
		assertEquals("India Pale Ale", sub.getMainCategory().getName()); 
	}
	
	@Test
	@DisplayName("TEST: MainCategory Mapping")
	void test3() {
		assertNotNull(sub.getBeers());
		assertEquals(1, sub.getBeers().size());
	}
}
