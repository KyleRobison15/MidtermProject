<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Brewery Info</title>
</head>
<body>

<h2>${brewery.name}</h2>

<div>
	<ul>
		<li>Brewery ID: ${brewery.id}</li>
		<li>Description: ${brewery.description}</li>
		<li>Address:</li>	
			<ul>
				<li>${brewery.address.address}</li>
				<li>${brewery.address.city}, 
					${brewery.address.stateProvince} 
					${brewery.address.postalCode}</li>
			</ul>
	</ul>
</div>


</body>
</html>