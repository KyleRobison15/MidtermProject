<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Account</title>
</head>
<body>

	<div class="container">
		<h1 class="display-3">Update Account</h1>
	</div>
	
	<div class="container">
		<div class="form">
			<form action="updateAccount.do?id=${user.id }" method="POST">

<!-- ///////////////////////////////////////////// FIRST NAME ////////////////////////////////////////////////////////////// -->

		<label for="firstName" class="col-sm-2 col-form-label">First Name</label>
		<input type="text" class="form-control" id="firstName" name="firstName" value="${user.firstName }" required>

<!-- ///////////////////////////////////////////// LAST NAME ////////////////////////////////////////////////////////////// -->
			
		<label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
		<input type="text" class="form-control" id="lastName" name="lastName" value="${user.lastName }" required>

<!-- ///////////////////////////////////////////// PROFILE IMAGE ////////////////////////////////////////////////////////////// -->
			
		<label for="url" class="col-sm-2 col-form-label">Profile Photo</label>
		<input type="url" pattern="https://.*" class="form-control" id="url" name="imageURL" value="${user.imageURL }">
		
<!-- ///////////////////////////////////////////// PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="password" class="col-sm-2 col-form-label">Password</label>
		<input type="password" class="form-control" id="password" name="password" required>
		
<!-- ///////////////////////////////////////////// CONFIRM PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="confirmPassword" class="col-sm-2 col-form-label">Confirm Password</label>
		<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
		
		
<!-- ///////////////////////////////////////////// SUBMIT ////////////////////////////////////////////////////////////// -->

		<br/><button type="submit" class="btn btn-outline-dark">Update!</button>
		
			</form>
		</div>
	</div>
	
</body>
</html>