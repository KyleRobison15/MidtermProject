<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
</head>
<body>

	<div class="container">
		<form action="login.do" method="POST">
			<label for="username">Username</label><input type="text" id="username" name="username"/> 
			<label for="password">Password</label><input type="password" id="password" name="password" /> 
			<input type="submit" value="Log In">
		</form>
	
		<p>New to BeerBuds? <a href="createAccountPage.do">Create Account</a></p>
	
	</div>	

</body>
</html>