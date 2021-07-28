<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="css/sitestyles.css">
<link rel="stylesheet" href="css/authors.css">
</head>
<body>

<!-- This file is solely for applying bootstrap and Site-Wide CSS styling to the other jsp files -->
<!-- Any site-wide styling should be applied in sitestyles.css -->
<!-- Do not add anything else to this file -->
				<div class="modal fade" id="authors" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="exampleModalLabel">Authors</h4>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body" align="center">
								<div class="row">
									<div class="col-7">
										<h5>Kyle Robison: </h5>
									</div>
									<div class="col-1">
										<a id="lBadge" class="" href="https://www.linkedin.com/in/kyle-robison/" target="_blank"><i class="bi bi-linkedin"></i></a>
									</div>
									<div class="col-1">
										<a id="gBadge" class="badge badge-light" href="https://github.com/KyleRobison15" target="_blank"><i class="bi bi-github"></i></a>
									</div>
								</div>
								
								<div class="row">
									<div class="col-7">
										<h5>Chris Riddle: </h5>
									</div>
									<div class="col-1">
										<a id="lBadge" class="" href="#" target="_blank"><i class="bi bi-linkedin"></i></a>
									</div>
									<div class="col-1">
										<a id="gBadge" class="badge badge-light" href="#" target="_blank"><i class="bi bi-github"></i></a>
									</div>
								</div>
								
								<div class="row">
									<div class="col-7">
										<h5>Matthew Lee: </h5>
									</div>
									<div class="col-1">
										<a id="lBadge" class="" href="http://linkedin.com/in/matthew-j-lee-572432a5" target="_blank"><i class="bi bi-linkedin"></i></a>
									</div>
									<div class="col-1">
										<a id="gBadge" class="badge badge-light" href="https://github.com/matthewlee686" target="_blank"><i class="bi bi-github"></i></a>
									</div>
								</div>
								
								<div class="row">
									<div class="col-7">
										<h5>Tom Stagnaro: </h5>
									</div>
									<div class="col-1">
										<a id="lBadge" class="" href="#" target="_blank"><i class="bi bi-linkedin"></i></a>
									</div>
									<div class="col-1">
										<a id="gBadge" class="badge badge-light" href="#" target="_blank"><i class="bi bi-github"></i></a>
									</div>
								</div>
								
								
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>