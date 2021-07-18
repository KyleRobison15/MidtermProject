<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Account</title>
</head>
<body>

	<div class="container">
		<h1 class="display-3">Get started by creating a BrewBuds account.</h1>
		<p>Become a brew master by posting delicious beers, or simply find a cold one to try out! Already have an account? <a href="loginPage.do">Log in</a></p> 
	</div>
	
	<div class="container">
		<div class="form">
			<form action="createAccount.do">
<!-- ///////////////////////////////////////////// EMAIL ////////////////////////////////////////////////////////////// -->
		
		<label for="email" class="col-sm-2 col-form-label">Email</label>
		<input type="text" class="form-control" id="email" name="email" required>
		
<!-- ///////////////////////////////////////////// USERNAME ////////////////////////////////////////////////////////////// -->

		<label for="username" class="col-sm-2 col-form-label">Username</label>
		<input type="text" class="form-control" id="username" name="username" required>
		
<!-- ///////////////////////////////////////////// PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="password" class="col-sm-2 col-form-label">Password</label>
		<input type="text" class="form-control" id="password" name="password" required>
		
<!-- ///////////////////////////////////////////// CONFIRM PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="confirmPassword" class="col-sm-2 col-form-label">Password</label>
		<input type="text" class="form-control" id="confirmPassword" name="confirmPassword" required>
			
<!-- ///////////////////////////////////////////// FIRST NAME ////////////////////////////////////////////////////////////// -->

		<label for="firstName" class="col-sm-2 col-form-label">First Name</label>
		<input type="text" class="form-control" id="firstName" name="firstName" required>

<!-- ///////////////////////////////////////////// LAST NAME ////////////////////////////////////////////////////////////// -->
			
		<label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
		<input type="text" class="form-control" id="lastName" name="lastName" required>
			
<!-- ///////////////////////////////////////////// SUBMIT ////////////////////////////////////////////////////////////// -->

		<br/><button type="submit" class="btn btn-outline-dark">Get Started!</button>
		
			</form>
		</div>
	</div>
	
	
	
</body>
</html>