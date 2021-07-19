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

class MainCategoryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private MainCategory main;  

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
		main = em.find(MainCategory.class, 4);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		main = null; 
	}
	
	@Test
	@DisplayName("testing main_category mapping")
	void test1() {
		assertNotNull(main);
		assertEquals("India Pale Ale", main.getName()); 
	}
	
	@Test
	@DisplayName("TEST: List<SubCategory> Mapping Test")
	void test2() {
		assertNotNull(main.getSubCategories());
		assertEquals(4, main.getSubCategories().size()); 
		assertEquals("India Pale Ale", main.getName());
	}
	
}
