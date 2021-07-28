<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/nav.css">
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="home.do"> <img
				src="img/navbarLogo.jpg" alt="" width="70" height="70">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">

				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="home.do">Home</a></li>

					<c:choose>
						<c:when test="${empty sessionScope.user }">
							<li class="nav-item"><a class="nav-link active"
								href="loginPage.do"> Login </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="createAccountPage.do"> Create Account </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="about.do"> About </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="" data-bs-toggle="modal" data-bs-target="#authors" id="viewAuthors"> Authors </a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link active"
								href="showProfileAdd.do"> My Profile </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="ShowFavoritesAlt.do?userId=${user.id}"> Favorites </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="ShowAll.do"> Reviews </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="account.do"> My Account </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="about.do"> About </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="" data-bs-toggle="modal" data-bs-target="#authors" id="viewAuthors"> Authors </a></li>
							<li class="nav-item"><a class="nav-link active"
								href="logout.do"> Logout </a></li>

						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<form class="d-flex" action="findBeers.do" method="GET">
				<input class="form-control me-2" type="search"
					placeholder="Search Beers and Breweries" size="40" name="keyword"
					aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
			<c:choose>
				<c:when test="${!empty sessionScope.user}">
					<div class="d-flex" id="profileImage">
						<c:choose>
							<c:when test="${!empty sessionScope.user.imageURL}">
								<a href="showProfileAdd.do"> <img
									src="${sessionScope.user.imageURL}" class="rounded-circle"
									height="60" width="60">
								</a>
							</c:when>
							<c:otherwise>
								<a href="showProfileAdd.do"> <img width="60" height="60"
									alt="${sessionScope.user.username}"
									src="img/defaultProfileImage.png" class="rounded-circle">
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
			</c:choose>
		</div>
	</nav>
</body>
</html>