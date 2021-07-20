package com.skilldistillery.brewbuds.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.brewbuds.entities.SubCategory;

@Service
@Transactional
public class SubCategoryDAOImpl implements SubCategoryDAO {
	
	@PersistenceContext
	EntityManager em;
	private String jpql;
	
	@Override
	public List<SubCategory> getAllSubCategories() {
		
		jpql = "SELECT s FROM SubCategory s";
		List<SubCategory> subCategories = em.createQuery(jpql, SubCategory.class).getResultList();
		
		return subCategories;
	}

}
