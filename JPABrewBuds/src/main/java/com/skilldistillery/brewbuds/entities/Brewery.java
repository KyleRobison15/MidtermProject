package com.skilldistillery.brewbuds.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity 
public class Brewery {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	
	private String name; 
	
	private String description; 
	
	@Column(name="address_id")
	private int addressId;
	
	@Column(name="logo_image_url")
	private String logoImageUrl; 
	
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

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getLogoImageUrl() {
		return logoImageUrl;
	}

	public void setLogoImageUrl(String logoImageUrl) {
		this.logoImageUrl = logoImageUrl;
	}

	@Override
	public String toString() {
		return "Brewery [id=" + id + ", name=" + name + ", description=" + description + ", addressId=" + addressId
				+ ", logoImageUrl=" + logoImageUrl + "]";
	}

}
