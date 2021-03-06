package com.skilldistillery.brewbuds.entities;

import java.time.LocalDateTime;
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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
public class User {
	
//////////////////////// FIELDS ///////////////////////////////
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	
	private String password;
	
	private boolean enabled;
	
	private String role;
	
	@Column(name="profile_image_url")
	private String imageURL;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String email;
	
	@Column(name="create_date")
	@CreationTimestamp
	private LocalDateTime createDate;
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user")
	private List<Beer> addedBeers;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany
	@JoinTable(name="favorite_beer", 
	joinColumns=@JoinColumn(name= "user_id"), 
	inverseJoinColumns=@JoinColumn(name="beer_id"))
	private List<Beer> favoriteBeers;
	
	@OneToMany(mappedBy = "user")
	private List<Rating> ratings;
	
//////////////////////// CONSTRUCTORS //////////////////////////
	
	public User() {}

//////////////////////// METHODS ///////////////////////////////
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public boolean isEnabled() {
		return enabled;
	}


	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public LocalDateTime getCreateDate() {
		return createDate;
	}


	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}
	
	public List<Beer> getAddedBeers() {
		return addedBeers;
	}

	public void setAddedBeers(List<Beer> addedBeers) {
		this.addedBeers = addedBeers;
	}

	public List<Beer> getFavoriteBeers() {
		return favoriteBeers;
	}

	public void setFavoriteBeers(List<Beer> favoriteBeers) {
		this.favoriteBeers = favoriteBeers;
	}

	public void addRating(Rating rating) {
		if(ratings == null) {
			ratings = new ArrayList<>();
		}
		if(!ratings.contains(rating)) {
			ratings.add(rating);
			if(rating.getUser() != null) {
				rating.getUser().getRatings().remove(rating);
			}
			rating.setUser(this);
		}
	}
	public void removeRating(Rating rating) {
		rating.setUser(null);
		if(ratings != null) {
			ratings.remove(rating);
		}
	}
	
	public void addBeer(Beer beer) {
		if (addedBeers == null) {
			addedBeers = new ArrayList<>(); 
		}
		if (!addedBeers.contains(beer)) {
			addedBeers.add(beer);
			beer.setUser(this);
		}
		
	}
	
	public void removeBeer(Beer beer) {
		if (addedBeers != null && addedBeers.contains(beer)) {
			addedBeers.remove(beer);
			beer.setUser(null);
		}
	}
	
	public void addFavoriteBeer(Beer beer) {
		if(favoriteBeers == null) {
			favoriteBeers = new ArrayList<>();
		}
		if(!favoriteBeers.contains(beer)) {
			favoriteBeers.add(beer);
			beer.addFavoriteUser(this);
		}
	}
	
	public void removeFavoriteBeer(Beer beer) {
		if(favoriteBeers != null && favoriteBeers.contains(beer)) {
			favoriteBeers.remove(beer);
			beer.removeFavoriteUser(this);
		}
	}
	
	
	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=").append(id).append(", username=").append(username).append(", password=")
				.append(password).append(", enabled=").append(enabled).append(", role=").append(role)
				.append(", firstName=").append(firstName).append(", lastName=").append(lastName).append(", email=")
				.append(email).append(", createDate=").append(createDate).append("]");
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
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
