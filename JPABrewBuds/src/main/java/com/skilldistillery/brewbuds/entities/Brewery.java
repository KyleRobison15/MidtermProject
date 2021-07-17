package com.skilldistillery.brewbuds.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity 
public class Brewery {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	
	private String name; 
	
	private String description; 
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@Column(name="logo_image_url")
	private String logoImageUrl; 
	
	@OneToMany(mappedBy= "brewery")
	private List<Beer> beers;
	
	//no-arg constructor
	public Brewery() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getLogoImageUrl() {
		return logoImageUrl;
	}

	public void setLogoImageUrl(String logoImageUrl) {
		this.logoImageUrl = logoImageUrl;
	}
	
	public List<Beer> getBeers() {
		return beers;
	}

	public void setBeers(List<Beer> beers) {
		this.beers = beers;
	}

	@Override
	public String toString() {
		return "Brewery [id=" + id + ", name=" + name + ", description=" + description + ", logoImageUrl="
				+ logoImageUrl + "]";
	}


}
