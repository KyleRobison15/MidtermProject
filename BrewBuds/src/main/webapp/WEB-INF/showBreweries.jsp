<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="userProfileNav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Breweries</title>
</head>
<body>
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">City</th>
					<th scope="col">State</th>
					<th scope="col">Country</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${breweries }" var="brewery">
					<tr>
						<td><a href="BreweryInfo.do?id=${brewery.id }">${brewery.name }</a></td>
						<td>${brewery.address.city }</td>
						<td>${brewery.address.stateProvince }</td>
						<td>${brewery.address.countryCode }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>