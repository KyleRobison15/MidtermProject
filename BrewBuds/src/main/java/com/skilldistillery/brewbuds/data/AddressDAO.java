package com.skilldistillery.brewbuds.data;

import com.skilldistillery.brewbuds.entities.Address;

public interface AddressDAO {

	public Address findById(int id);
	public Address addAddress(Address address);
	
}
