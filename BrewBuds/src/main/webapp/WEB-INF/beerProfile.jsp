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

<ul>
<li>Rating:  ${average}</li>
<li>Name: ${beer.name}</li>
<li>Description: ${beer.description}</li>
<li>ABV: ${beer.alcoholByVolume}</li>
<li>SRM: ${beer.color}</li>
<li>IBU: ${beer.bitterness} </li>
<li>Brewery: ${beer.brewery.name}</li>
<li>Category: ${beer.subCategory.name}</li>

<c:choose>
    <c:when test="${not empty beer.imageURL}">
        <li>Image: <img src="${beer.imageURL}" width="128" height="128" class="beer-img" alt="stockBeer"/> </li> 
</c:when>

<c:otherwise>
    <li>Image: <img src="img/stockBeer.jpeg" width="128" height="128" class="beer-img" alt="stockBeer"/> </li>
    </c:otherwise>
</c:choose>
</ul>


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


<c:choose>
<c:when test="${!empty sessionScope.user }">
	<c:choose>
	<c:when test="true">
		<form action="submitRating.do" method="POST">
		
		<input class="form-check-input" type="radio" name="rating" id="rating1" value="1">
		<label for="rating1">1</label>
		<input class="form-check-input" type="radio" name="rating" id="rating2" value="2"> 
		<label for="rating2">2</label>
		<input class="form-check-input" type="radio" name="rating" id="rating3" value="3"> 
		<label for="rating3">3</label>
		<input class="form-check-input" type="radio" name="rating" id="rating4" value="4"> 
		<label for="rating4">4</label>
		<input class="form-check-input" type="radio" name="rating" id="rating5" value="5" checked> 
		<label for="rating5">5</label>
		<label class="form-check-label" for="ticked"> Rating </label>
		
		Comment:
		<input type="text" name="comment"/>
		<input type="hidden" name="beerId" value="${beer.id}"/>
		<input type="hidden" name="userId" value="${sessionScope.user.id}"/>
		
		<input type="submit" value="rate"/>
		
		</form>
	</c:when>
	<c:otherwise>
		You have already left a review.
	</c:otherwise>
	</c:choose>
</c:when>
<c:otherwise>
	<br/><p>New to BeerBuds? <a href="createAccountPage.do">Create Account</a></p>
</c:otherwise>
</c:choose>



<c:forEach items="${beer.ratings}" var="rating">

<ul>
<li>User: ${rating.user.username}</li>
<li>Rating: ${rating.rating}</li>
<li>Comment: ${rating.comment}</li>
</ul>

</c:forEach>


<form action="AddFavorite.do?beerId=${beer.id}" method="post">
<input type="submit" value="Add to Favorites"/>
</form>


<a href=""></a>

</body>
</html>