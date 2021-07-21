<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%> 
<%@ include file="nav.jsp"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add a Beer</title>
</head>
<body>

	<div class="container">
		<div class="form">
			<form action="addBeer.do" method="POST">


<!-- ///////////////////////////////////////////// BREWERY ////////////////////////////////////////////////////////////// -->

		<label for="breweryName" class="col-sm-2 col-form-label">Brewery</label>
		<input type="text" class="form-control" id="breweryName" name="breweryName" required>
		
<!-- ///////////////////////////////////////////// NAME ////////////////////////////////////////////////////////////// -->
		
		<label for="name" class="col-sm-2 col-form-label">Name</label>
		<input type="text" class="form-control" id="name" name="name" required>
		
<!-- ///////////////////////////////////////////// SUB CATEGORY ////////////////////////////////////////////////////////////// -->

		<label for="subCatName" class="col-sm-2 col-form-label">Beer Type</label>
				<select class="form-select" name="subCatName" id="subCatName" aria-label="Default select example" required>
					<option selected>Select a Beer Type</option>
					<c:forEach items="${subCategories }" var="subCategory">
						<option value="${subCategory.name }">${subCategory.name }</option>
					</c:forEach>
				</select>
		
<!-- ///////////////////////////////////////////// ABV ////////////////////////////////////////////////////////////// -->

		<label for="alcoholByVolume" class="col-sm-2 col-form-label">Alcohol By Volume</label>
		<input type="text" class="form-control" id="alcoholByVolume" name="alcoholByVolume" required>
		
<!-- ///////////////////////////////////////////// COLOR ////////////////////////////////////////////////////////////// -->

		<label for="color" class="col-sm-2 col-form-label">Color (SRM)</label>
				<select class="form-select" name="color" id="color" aria-label="Default select example" required>
					<option selected>Select a Color</option>
					
					<option value="2">2 - Pale Straw</option>
					<option value="3">3 - Straw</option>
					<option value="4">4 - Pale Gold</option>
					<option value="6">6 - Deep Gold</option>
					<option value="9">9 - Pale Amber</option>
					<option value="12">12 - Medium Amber</option>
					<option value="15">15 - Deep Amber</option>
					<option value="18">18 - Amber-Brown</option>
					<option value="20">20 - Brown</option>
					<option value="24">24 - Ruby Brown</option>
					<option value="30">30 - Deep Brown</option>
					<option value="40">40 - Black</option>

				</select>
		
<!-- ///////////////////////////////////////////// BITTERNESS ////////////////////////////////////////////////////////////// -->

		<label for="bitterness" class="col-sm-2 col-form-label">Bitterness (IBU)</label>
		<input type="text" class="form-control" id="bitterness" name="bitterness" required>
		
<!-- ///////////////////////////////////////////// DESCRIPTION ////////////////////////////////////////////////////////////// -->

		<label for="description" class="col-sm-2 col-form-label">Description</label>
		<input type="text" class="form-control" id="description" name="description" required>
		
<!-- ///////////////////////////////////////////// IMAGE URL ////////////////////////////////////////////////////////////// -->

		<label for="imageURL" class="col-sm-2 col-form-label">ImageURL</label>
		<input type="url" pattern="https://.*" placeholder="https://beerimage.jpeg" class="form-control" id="imageURL" name="imageURL">

		
<!-- ///////////////////////////////////////////// INITIAL BEER RATING FORM ////////////////////////////////////////////////////////////// -->
		
		
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
		<!--  <input type="hidden" name="beerId" value="${beer.id}"/> -->
		<!--  <input type="hidden" name="userId" value="${sessionScope.user.id}"/> -->
		
		
<!-- ///////////////////////////////////////////// SUBMIT FORM ////////////////////////////////////////////////////////////// -->		
		
		<br/><button type="submit" class="btn btn-outline-dark">Add Beer!</button>
		
		
			</form>
		</div>
	</div>

</body>
</html>