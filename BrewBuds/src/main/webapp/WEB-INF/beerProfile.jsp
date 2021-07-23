<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>



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
					class="beer-img" alt="stockBeer"/>
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
						<c:when test="${average < 3.9 && average > 2.5}"><td><span class="badge badge-warning">${average}</span></td></c:when>
						<c:when test="${average < 2.5}"><td><span class="badge badge-danger">${average}</span></td></c:when>
						</c:choose>
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
					<th scope="row">Brewery</th>
					<td><a class="link-dark"  href="BreweryInfo.do?id=${beer.brewery.id }">${beer.brewery.name}</a></td>
				</tr>
				<tr>
					<th>Category</th>
					<td>${beer.subCategory.name}</td>
				</tr>
			</tbody>
		</table>


		<%-- <ul>
>>>>>>> d0f8d5eb153662f426500c013730fc41ccf3296f
<li>Rating:  ${average}</li>
<li>Name: ${beer.name}</li>
<li>Description: ${beer.description}</li>
<li>ABV: ${beer.alcoholByVolume}</li>
<li>SRM: ${beer.color}</li>
<li>IBU: ${beer.bitterness} </li>
<li>Brewery: <a href="BreweryInfo.do?id=${beer.brewery.id }">${beer.brewery.name}</a></li>
<li>Category: ${beer.subCategory.name}</li>

<c:choose>
    <c:when test="${not empty beer.imageURL}">
        <li>Image: <img src="${beer.imageURL}" width="128" height="128" class="beer-img" alt="stockBeer"/> </li> 
</c:when>

<c:otherwise>
    <li>Image: <img src="img/stockBeer.jpeg" width="128" height="128" class="beer-img" alt="stockBeer"/> </li>
    </c:otherwise>
</c:choose>
</ul> --%>


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

						<input class="form-check-input" type="radio" name="rating"
							id="rating1" value="1"> <label for="rating1">1</label> <input
							class="form-check-input" type="radio" name="rating" id="rating2"
							value="2"> <label for="rating2">2</label> <input
							class="form-check-input" type="radio" name="rating" id="rating3"
							value="3"> <label for="rating3">3</label> <input
							class="form-check-input" type="radio" name="rating" id="rating4"
							value="4"> <label for="rating4">4</label> <input
							class="form-check-input" type="radio" name="rating" id="rating5"
							value="5" checked> <label for="rating5">5</label> <label
							class="form-check-label" for="ticked"> Rating </label> Comment: <input
							type="text" name="comment" /> <input type="hidden" name="beerId"
							value="${beer.id}" /> <input type="hidden" name="userId"
							value="${sessionScope.user.id}" /> <input type="submit"
							value="rate" />

					</form>
				</c:when>
				<c:otherwise>
					<hr>
					<h6>Your review:</h6>
					<form action="editRating.do" method="POST">
						<c:choose>
							<c:when test="${userReview.rating == 1}">
								<input class="form-check-input" type="radio" name="rating"
									id="rating1" value="1" checked   readonly>
								<label for="rating1">1</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="radio" name="rating"
									id="rating1" value="1"   readonly>
								<label for="rating1">1</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${userReview.rating == 2}">
								<input class="form-check-input" type="radio" name="rating"
									id="rating2" value="2" checked   readonly>
								<label for="rating2">2</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="radio" name="rating"
									id="rating2" value="2"   readonly>
								<label for="rating2">2</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${userReview.rating == 3}">
								<input class="form-check-input" type="radio" name="rating"
									id="rating3" value="3" checked   readonly>
								<label for="rating3">3</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="radio" name="rating"
									id="rating3" value="3"   readonly>
								<label for="rating3">3</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${userReview.rating == 4}">
								<input class="form-check-input" type="radio" name="rating"
									id="rating4" value="4" checked   readonly>
								<label for="rating4">4</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="radio" name="rating"
									id="rating4" value="4"   readonly>
								<label for="rating4">4</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${userReview.rating == 5}">
								<input class="form-check-input" type="radio" name="rating"
									id="rating5" value="5" checked   readonly>
								<label for="rating5">5</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="radio" name="rating"
									id="rating5" value="5" readonly>
								<label for="rating5">5</label>
							</c:otherwise>
						</c:choose>
						<label class="form-check-label" for="ticked"> Rating </label>

						Comment: <input type="text" name="comment"
							value="${userReview.comment }" readonly/> 
							<input type="hidden"
							name="beerId" value="${beer.id}" /> 
							<input type="hidden"
							name="userId" value="${sessionScope.user.id}" /> 
							<input
							type="submit" value="edit" />

					</form>
					<%-- <form action="deleteRating.do" method="POST">
						<input type="hidden" name="beerId" value="${beer.id}" /> <input
							type="hidden" name="userId" value="${sessionScope.user.id}" /> <input
							type="submit" value="delete" />
					</form> --%>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<br />
			<p>
				New to BeerBuds? <a href="createAccountPage.do">Create Account</a>
			</p>
		</c:otherwise>
	</c:choose>

	<hr>
	<h1>Reviews:</h1>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">User</th>
				<th scope="col">Rating</th>
				<th scope="col">Comment</th>
				<th scope="col">Posted On</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${beer.ratings}" var="rating">
				<tr>
					<td>${rating.user.username}</td>
						<c:choose>
						<c:when test="${rating.rating > 3.9 }"><td><span class="badge badge-success">${rating.rating}</span></td></c:when>
						<c:when test="${rating.rating < 3.9 && rating.rating > 2.5}"><td><span class="badge badge-warning">${rating.rating}</span></td></c:when>
						<c:when test="${rating.rating < 2.5}"><td><span class="badge badge-danger">${rating.rating}</span></td></c:when>
						</c:choose>
					<td>${rating.comment}</td>
					<td>${rating.ratingDate.getMonth()} ${rating.ratingDate.getDayOfMonth()}, 
								${rating.ratingDate.getYear() }  </td>
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

	<c:choose>
		<c:when test="${!empty sessionScope.user }">
			<form action="AddFavoriteBeerProfilePage.do?id=${beer.id}"
				method="post">
				<input type="submit" value="Add to Favorites" />
			</form>
		</c:when>
	</c:choose>




<a href=""></a>
</div>
</body>
</html>