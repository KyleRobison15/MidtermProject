<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Beer Reviews</title>
</head>
<body>

<h2>Beer Reviews:</h2>

<div>
<c:choose>
<c:when test="${!empty beers}">
		<table>
			<thead> 
				<tr>
				<th>Beer</th>
				<th>Brewery</th>
				<th>Description</th>
				<th>Style</th>
				<th>User</th>
				<th>Rating</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<c:forEach var="beer" items="${beers}">
		 		<td><a href="beerProfile.do?id=${beer.id}">${beer.name}</a></td>
		 		<td><a href="BreweryInfo.do?id=${beer.brewery.id}">${beer.brewery.name}</a></td>
		 		<td>${beer.description}</td>
		 		
		 		<!--Beer Category Table Data here  -->
		 		
				</c:forEach>
			</tbody>
		</table>
</c:when>

<c:otherwise>
	<p>No Reviews Found</p>
</c:otherwise>

</c:choose>
</div>

<p>${beers.size()} Reviews Found</p>

<br>
<form action="home.do" method="get"><input type="submit" value="Go to Home"></form>
	


</body>
</html>