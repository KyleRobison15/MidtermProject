<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
</head>
<body>

	<div class="container">
	
 		<c:choose>
			<c:when test="${not empty message }">
				<div class="container">
					<div class="alert alert-danger" role="alert">
  						${message }
					</div>
				</div>
			</c:when>
		</c:choose> 
		
		<form action="login.do" method="POST">
		
		
			<div class="form">
			<label for="username" class="col-sm-2 col-form-label">Username </label>
			<input type="text" id="username" name="username"class="form-control"><br/> 
			
			<label for="password" class="col-sm-2 col-form-label">Password </label>
			<input type="password" id="password" name="password" class="form-control"><br/>
			
				<div class="d-grid gap-2 col-12 mx-auto">
					<input type="submit" class="btn btn-outline-dark" value="Log In">
				</div>
			</div>
		</form>
	
			<br/><p>New to BeerBuds? <a href="createAccountPage.do">Create Account</a></p>
			
		
	</div>	

</body>
</html>