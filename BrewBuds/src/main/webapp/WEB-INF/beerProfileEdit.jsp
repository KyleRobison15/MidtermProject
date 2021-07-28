<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>
<%-- <%@ include file="footer.jsp"%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Beer Profile</title>
</head>
<body>

	<div class="container">
		<h1 class="display-3">${beer.name}</h1>

		<c:choose>
			<c:when test="${!empty message }">
				<div class="container">
					<div class="alert alert-primary" role="alert">${message }</div>
				</div>
			</c:when>
		</c:choose>

		<c:choose>
			<c:when test="${not empty beer.imageURL}">
				<img src="${beer.imageURL}" width="128" height="128"
					class="beer-img" alt="stockBeer" />
			</c:when>

			<c:otherwise>
				<img src="img/stockBeer.jpeg" width="128" height="128"
					class="beer-img" alt="stockBeer" />
			</c:otherwise>
		</c:choose>


		<table class="table">
			<tbody>
				<tr>
					<th scope="row">Rating</th>
					<c:choose>
						<c:when test="${average > 3.9 }"><td><span class="badge badge-success">${average}</span></td></c:when>
						<c:when test="${average <= 3.9 && average >= 2.5}"><td><span class="badge badge-warning">${average}</span></td></c:when>
						<c:when test="${average < 2.5}"><td><span class="badge badge-danger">${average}</span></td></c:when>
						</c:choose>
				</tr>
				<tr>
					<th scope="row">User</th>
					<td><a class="link-dark" href="showNonUserProfile.do?id=${beer.user.id }">${beer.user.username}</a></td>
				</tr>
				<tr>
					<th scope="row">Brewery</th>
					<td><a class="link-dark"
						href="BreweryInfo.do?id=${beer.brewery.id }">${beer.brewery.name}</a></td>
				</tr>
				<tr>
					<th scope="row">Description</th>
					<td>${beer.description}</td>
				</tr>
				<tr>
					<th scope="row">ABV</th>
					<td>${beer.alcoholByVolume}</td>
				</tr>
				<tr>
					<th scope="row">Color</th>
					<td>${beer.color}</td>
				</tr>
				<tr>
					<th scope="row">Bitterness (IBU)</th>
					<td>${beer.bitterness}</td>
				</tr>
				<tr>
					<th>Category</th>
					<td>${beer.subCategory.name}</td>
				</tr>
			</tbody>
		</table>

	</div>

	<!-- id                | int(11)       | NO   | PRI | NULL    | auto_increment |
| name              | varchar(100)  | NO   |     | NULL    |                |
| description       | text          | YES  |     | NULL    |                |
| alcohol_by_volume | double        | YES  |     | NULL    |                |
| color_srm         | int(11)       | YES  |     | NULL    |                |
| bitterness_ibu    | int(11)       | YES  |     | NULL    |                |
| brewery_id        | int(11)       | NO   | MUL | NULL    |                |
| user_id           | int(11)       | NO   | MUL | NULL    |                |
| sub_category_id   | int(11)       | NO   | MUL | NULL    |                |
| beer_image_url    | va -->

	<div class="container">
		<c:choose>
			<c:when test="${!empty sessionScope.user }">
				<c:choose>
					<c:when test="${!alreadyRated }">
						<form action="submitRating.do" method="POST">
						<div class="row g-3">
							<div class="col">
							<label class="form-check-label" for="ticked"> Rating </label>
							
							<div class="form-check form-check-inline">
								<label class="form-check-label" for="rating1">1</label> 
								<input class="form-check-input" type="radio" name="rating" id="rating1" value="1"> 
							</div>
							
							<div class="form-check form-check-inline">
								<label class="form-check-label" for="rating2">2</label>
								<input class="form-check-input" type="radio" name="rating" id="rating2" value="2">  
							</div>	
								
							<div class="form-check form-check-inline">
								<label class="form-check-label" for="rating3">3</label> 
								<input class="form-check-input" type="radio" name="rating" id="rating3" value="3"> 
							</div>
							
							<div class="form-check form-check-inline">
								<label class="form-check-label" for="rating4">4</label> 
								<input class="form-check-input" type="radio" name="rating" id="rating4" value="4"> 
							</div>
							
							<div class="form-check form-check-inline">
								<label class="form-check-label" for="rating5">5</label>  
								<input class="form-check-input" type="radio" name="rating" id="rating5" value="5" checked>
							</div> 
							 
							</div>
							
							<div class="col">
								<input type="text" name="comment" placeholder="comment"/> 
								<input type="hidden" name="beerId" value="${beer.id}" /> 
								<input type="hidden" name="userId" value="${sessionScope.user.id}" /> 
								<input type="submit" value="rate" />
							</div>
							
						</div>
						</form>
					</c:when>
					<c:otherwise>
						<hr>
						<h4>Your Review</h4>
						<form action="submitRating.do" method="POST" id="submitRating">
							<label class="form-check-label" for="ticked"><strong>Rating</strong></label>
							<c:choose>
								<c:when test="${userReview.rating == 1}">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating1" value="1" checked >
									<label class="form-check-label" for="rating1">1</label>
								</div>	
									
								</c:when>
								<c:otherwise>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating1" value="1" >
									<label class="form-check-label" for="rating1">1</label>
								</div>	
									
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${userReview.rating == 2}">
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating2" value="2" checked >
									<label class="form-check-label" for="rating2">2</label>
								</div>	
									
								</c:when>
								<c:otherwise>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating2" value="2" >
									<label class="form-check-label" for="rating2">2</label>
								</div>	
									
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${userReview.rating == 3}">
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating3" value="3" checked >
									<label class="form-check-label" for="rating3">3</label>
								</div>	
									
								</c:when>
								<c:otherwise>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating3" value="3" >
									<label class="form-check-label" for="rating3">3</label>
								</div>	
									
								</c:otherwise>
							</c:choose>
							<c:choose>
							
								<c:when test="${userReview.rating == 4}">
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating4" value="4" checked >
									<label class="form-check-label" for="rating4">4</label>
								</div>	
									
								</c:when>
								<c:otherwise>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating4" value="4" >
									<label class="form-check-label" for="rating4">4</label>
								</div>	
									
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${userReview.rating == 5}">
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating5" value="5" checked >
									<label class="form-check-label" for="rating5">5</label>
								</div>	
									
								</c:when>
								<c:otherwise>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rating" id="rating5" value="5">
									<label class="form-check-label" for="rating5">5</label>
								</div>	
									
								</c:otherwise>
							</c:choose>
							
							
							<input type="text" name="comment" size="70" value="${userReview.comment }" /> 
							<input type="hidden" name="beerId" value="${beer.id}" /> 
							<input type="hidden" name="userId" value="${sessionScope.user.id}" /> 
							<input class="btn btn-outline-dark" form="submitRating" type="submit" value="Update" />
							
						</form>
							
							<form action="deleteRating.do" method="POST">
								<input type="hidden" name="beerId" value="${beer.id}" /> 
								<input type="hidden" name="userId" value="${sessionScope.user.id}" /> 
								<input class="btn btn-outline-danger" type="submit" value="Delete" />
							</form>
							
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<br />
				<p>
					New to brewBuds? <a href="createAccountPage.do">Create Account</a>
				</p>
			</c:otherwise>
		</c:choose>


		<hr>
		
		<c:choose>
			<c:when test="${!empty sessionScope.user }">
				<form action="AddFavoriteBeerProfilePage.do?id=${beer.id}"
					method="post">
					<input class="btn btn-outline-dark btn-lg" type="submit"
						value="Add to Favorites" />
				</form>
			</c:when>
		</c:choose><br>
		
		
		<h1 class="display-6">Reviews</h1>

		<table class="table">
			<thead>
				<tr>
					<th scope="col">User</th>
					<th scope="col">Rating</th>
					<th scope="col">Comment</th>
					<th scope="col">Date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${beer.ratings}" var="rating">
					<tr>
						<td>${rating.user.username}</td>
						<c:choose>
						<c:when test="${rating.rating > 3.9 }"><td><span class="badge badge-success">${rating.rating}</span></td></c:when>
						<c:when test="${rating.rating <= 3.9 && rating.rating >= 2.5}"><td><span class="badge badge-warning">${rating.rating}</span></td></c:when>
						<c:when test="${rating.rating < 2.5}"><td><span class="badge badge-danger">${rating.rating}</span></td></c:when>
						</c:choose>
						<td>${rating.comment}</td>
						<td>${rating.ratingDate}</td>
					</tr>
					<%-- <hr>
<ul>
<li>User: ${rating.user.username}</li>
<li>Rating: ${rating.rating}</li>
<li>Comment: ${rating.comment}</li>
<li> Date Added: ${rating.ratingDate} </li>
</ul> --%>

				</c:forEach>
			</tbody>
		</table>		
	</div>
</body>
</html>