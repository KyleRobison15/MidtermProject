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
		<h1 class="display-3">Oops! Let's try that again.</h1>
		<p>One of three things could be holding you up: </p>
		<ol>
			<li>You failed to confirm your password</li>
			<li>This username is taken</li>
			<li>There is already an account associated with this email</li>
		</ol>
	</div>

	<div class="container">
		<div class="form">
			<form action="createAccount.do" method ="POST">
<!-- ///////////////////////////////////////////// EMAIL ////////////////////////////////////////////////////////////// -->
		
		<label for="email" class="col-sm-2 col-form-label">Email</label>
		<input type="email" class="form-control" id="email" name="email" value="${newUser.email }" required>
		
<!-- ///////////////////////////////////////////// USERNAME ////////////////////////////////////////////////////////////// -->

		<label for="username" class="col-sm-2 col-form-label">Username</label>
		<input type="text" class="form-control" id="username" name="username" value="${newUser.username }" required>
		
<!-- ///////////////////////////////////////////// FIRST NAME ////////////////////////////////////////////////////////////// -->

		<label for="firstName" class="col-sm-2 col-form-label">First Name</label>
		<input type="text" class="form-control" id="firstName" name="firstName" value="${newUser.firstName }" required>

<!-- ///////////////////////////////////////////// LAST NAME ////////////////////////////////////////////////////////////// -->
			
		<label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
		<input type="text" class="form-control" id="lastName" name="lastName" value="${newUser.lastName }" required>
			
<!-- ///////////////////////////////////////////// PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="password" class="col-sm-2 col-form-label">Password</label>
		<input type="password" class="form-control" id="password" name="password" required>
		
<!-- ///////////////////////////////////////////// CONFIRM PASSWORD ////////////////////////////////////////////////////////////// -->

		<label for="confirmPassword" class="col-sm-2 col-form-label">Confirm Password</label>
		<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>

<!-- ///////////////////////////////////////////// ROLE ////////////////////////////////////////////////////////////// -->
			
		<input type="hidden" id="role" name="role" value="user">
		
<!-- ///////////////////////////////////////////// ENABLED ////////////////////////////////////////////////////////////// -->
			
		<input type="hidden" id="enabled" name="enabled" value="true">
			
<!-- ///////////////////////////////////////////// SUBMIT ////////////////////////////////////////////////////////////// -->

		<br/><button type="submit" class="btn btn-outline-dark">Get Started!</button>
		
			</form>
		</div>
	</div>
	

</body>
</html>