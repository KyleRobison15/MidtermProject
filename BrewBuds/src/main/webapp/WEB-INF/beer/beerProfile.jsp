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
<li>Name: ${beer.name}</li>
<li>Description: ${beer.description}</li>
<li>ABV: ${beer.alcoholByVolume}</li>
<li>SRM: ${beer.color}</li>
<li>IBU: ${beer.bitterness} </li>
<li>Brewery: ${beer.brewery.name}</li>
<li>Category: </li>
<li>Image: </li>
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





<a href=""></a>

</body>
</html>