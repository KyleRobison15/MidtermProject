<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username }</title>
</head>
<body>

<!-- Display User's Account Information -->

	<div class="container">
		<h1 class="display-4">${user.username }</h1>
		<ul class="list-group">
			<li class="list-group-item"><h5>First Name</h5> ${user.firstName} </li>
			<li class="list-group-item"><h5>Last Name</h5> ${user.lastName } </li>
			<li class="list-group-item"><h5>Email</h5> ${user.email } </li>
			<li class="list-group-item"><h5>Phone</h5> ${user.address.phone } </li>
			<li class="list-group-item"><h5>User Since</h5> ${user.createDate} </li>
			<li class="list-group-item"><h5>Address</h5> ${user.address.address } </li>
				<c:choose>
					<c:when test="${!empty user.address.address2 }">
						<li class="list-group-item"><h5>Address2</h5> ${user.address.address2 } </li>
					</c:when>
				</c:choose>
			<li class="list-group-item"><h5>City</h5> ${user.address.city } </li>
			<li class="list-group-item"><h5>State</h5> ${user.address.stateProvince } </li>
			<li class="list-group-item"><h5>Postal Code</h5> ${user.address.postalCode } </li>
			<li class="list-group-item"><h5>Country</h5> ${user.address.countryCode } </li>
		</ul>
		
		<br/><a class="btn btn-outline-dark" href="#">Update Account Information</a>
	</div>
	
	
</body>
</html>