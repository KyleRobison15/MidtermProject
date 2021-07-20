package com.skilldistillery.brewbuds.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Beer {

//////////////////////// FIELDS ///////////////////////////////
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	
	private String description;
	
	@Column(name="alcohol_by_volume")
	private Double alcoholByVolume;
	
	@Column(name="color_srm")
	private Integer color;
	
	@Column(name="bitterness_ibu")
	private Integer bitterness;
	
	@Column(name="beer_image_url")
	private String imageURL;
	
	@ManyToOne
	@JoinColumn(name="brewery_id")
	private Brewery brewery;
	
	@ManyToOne
	@JoinColumn(name="user_id") 
	private User user;  					// User who added this beer
	
	@ManyToMany
	@JoinTable(name="favorite_beer", 
	joinColumns=@JoinColumn(name= "beer_id"), 
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> users;				// Users who have this beer in their favorites list
	
	@OneToMany(mappedBy = "beer")
	private List<Rating> ratings;
	
	@ManyToOne
	@JoinColumn(name="sub_category_id")
	private SubCategory subCategory;
	
//////////////////////// CONSTRUCTORS //////////////////////////	
	
	public Beer() {}

//////////////////////// METHODS ///////////////////////////////	
	
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

	public Double getAlcoholByVolume() {
		return alcoholByVolume;
	}

	public void setAlcoholByVolume(Double alcoholByVolume) {
		this.alcoholByVolume = alcoholByVolume;
	}

	public Integer getColor() {
		return color;
	}

	public void setColor(Integer color) {
		this.color = color;
	}

	public Integer getBitterness() {
		return bitterness;
	}

	public void setBitterness(Integer bitterness) {
		this.bitterness = bitterness;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	
	public Brewery getBrewery() {
		return brewery;
	}

	public void setBrewery(Brewery brewery) {
		this.brewery = brewery;
	}

	public User getUser() { // User who added this beer
		return user;
	}

	public void setUser(User user) { // User who added this beer
		this.user = user;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}
	
	public List<User> getUsers() { // Users who have this beer in their favorites list
		return users; 
	}

	public void setUsers(List<User> users) { // Users who have this beer in their favorites list
		this.users = users;
	}

	public void addRating(Rating rating) {
		if(ratings == null) {
			ratings = new ArrayList<>();
		}
		if(!ratings.contains(rating)) {
			ratings.add(rating);
			if(rating.getBeer() != null) {
				rating.getBeer().getRatings().remove(rating);
			}
			rating.setBeer(this);
		}
	}
	public void removeRating(Rating rating) {
		rating.setBeer(null);
		if(ratings != null) {
			ratings.remove(rating);
		}
	}
	
	public void addUser(User user) {
		if (users == null) {
			users = new ArrayList<>(); // If films is null - we need to instantiate a new ArrayList
		}
		if (!users.contains(user)) {
			users.add(user);
			user.addBeer(this);
		}

	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeBeer(this);
		}
	}

	public SubCategory getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(SubCategory subCategory) {
		this.subCategory = subCategory;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Beer [id=").append(id).append(", name=").append(name).append(", description=")
				.append(description).append(", alcoholByVolume=").append(alcoholByVolume).append(", color=")
				.append(color).append(", bitterness=").append(bitterness).append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Beer other = (Beer) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
