package com.skilldistillery.brewbuds.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class RatingId implements Serializable {
	
	///////////
	// Fields

	private static final long serialVersionUID = 1L;
	
	@Column(name = "beer_id")
	private int beerId;
	
	@Column(name = "user_id")
	private int userId;

	
	////////////
	// Methods
	
	public RatingId() {}
	
	public int getBeerId() {
		return beerId;
	}
	
	public void setBeerId(int beerId) {
		this.beerId = beerId;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + beerId;
		result = prime * result + userId;
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
		RatingId other = (RatingId) obj;
		if (beerId != other.beerId)
			return false;
		if (userId != other.userId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RatingId [beerId=" + beerId + ", userId=" + userId + "]";
	}
	
	
	
}
