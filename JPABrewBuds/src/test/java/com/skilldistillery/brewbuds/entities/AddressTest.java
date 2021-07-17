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

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address; 
	
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
		address = em.find(Address.class, 1); 
 	}
	@AfterEach
	void tearDown() throws Exception {
		em.close(); 
		address = null; 
	}
	
	@Test
	@DisplayName("test address entity mapping")
	void test1() {
		assertNotNull(address);
		assertEquals("US", address.getCountryCode());
		assertEquals("1075 E 20th Street", address.getAddress());
		assertEquals("Chico", address.getCity());
		assertEquals("CA", address.getStateProvince());
		assertEquals("95928", address.getPostalCode());
		assertEquals("5308933520", address.getPhone());
		
	}
	
	@Test
	@DisplayName("test user to address mapping")
	void test2() {
		assertNotNull(address);
		assertEquals("US", address.getCountryCode());
	
		
	}
	

}
