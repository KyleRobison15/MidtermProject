<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="home.do">Navbar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="home.do">Home</a></li>

					<c:choose>
						<c:when test="${empty sessionScope.user }">
							<li class="nav-item"><a class="nav-link active" href="loginPage.do"> Login </a></li>
							<li class="nav-item"><a class="nav-link active" href="createAccountPage.do"> Create Account </a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link active" href="showProfileAdd.do"> Add Beers </a></li>
							<li class="nav-item"><a class="nav-link active" href="showProfileFind.do"> Find Beers </a></li>
							<li class="nav-item"><a class="nav-link active" href="account.do"> My Account </a></li>
							<li class="nav-item"><a class="nav-link active" href="logout.do"> Logout </a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>

</body>
</html>