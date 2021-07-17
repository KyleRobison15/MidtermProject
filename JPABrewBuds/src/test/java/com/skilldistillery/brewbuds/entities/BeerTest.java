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

class BeerTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Beer beer;
	
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
		beer = em.find(Beer.class, 1);
	}
	
	@AfterEach	
	void tearDown() throws Exception {
		em.close();
		beer = null;
	}
	
	@Test
	@DisplayName("TEST: Beer Field Mappings for Non-Foreign Keys")
	void test1() throws Exception {
		assertNotNull(beer);
		
		assertEquals("Hazy Little Thing", beer.getName()); // name mapping
		assertEquals("Nice Hazy IPA", beer.getDescription()); // description mapping
		assertEquals(6.7, beer.getAlcoholByVolume()); // ABV mapping
		assertEquals(6, beer.getColor()); // color mapping
		assertEquals(35, beer.getBitterness()); // bitterness mapping

	}
	
/*
	 
Beer Non Foreign Key Mapping Test:
	SELECT * FROM beer WHERE id = 1;
	+----+-------------------+---------------+-------------------+-----------------+----------------+------------+---------+-----------------+----------------+
	| id | name              | description   | alcohol_by_volume | color_srm_value | bitterness_ibu | brewery_id | user_id | sub_category_id | beer_image_url |
	+----+-------------------+---------------+-------------------+-----------------+----------------+------------+---------+-----------------+----------------+
	|  1 | Hazy Little Thing | Nice Hazy IPA |               6.7 |               6 |             35 |          1 |       1 |              17 | NULL           |
	+----+-------------------+---------------+-------------------+-----------------+----------------+------------+---------+-----------------+----------------+

*/	

}
