<%@  page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet"
 href="css/custom.css">
<title>메디컬 라이브러리</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID") ;
		}
	%>
	<style> .logo{ display: table; margin-left: auto; margin-right: auto;}</style>
	<nav class="navbar navbar-default">
	
	<div class="logo">
	 <a href="main.jsp"><img src="http://sculpstore.co.kr/wp-content/uploads/2015/01/logo.png" ></a>
	</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="medical.jsp">게시판</a></li>
				<%
				if(userID == null){ //로그인이 되어있지 않다면. 
				%>
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
				<% 	
				} else{ //로그인이 되어있는 화면 
			%>
			<li><a href="logoutAction.jsp">로그아웃</a></li>
			<% 		
				}
			%>	
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron"> <!--  메인페이지 소개할때 쓰는 부트스트랩이 제공하는 클래스 -->
			<div class="container">
				<h1>웹사이트 소개</h1>
				<p>엔지니어드가먼츠 옷 사고싶다..</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기 </a></p> <!-- 현재 여기서는 디자인 요소로 버튼을 삽입 -->
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel"> 	<!-- carousel 사진첩같은 개념 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>				
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1.png">
				</div>		
				<div class="item">
					<img src="images/2.png">
				</div>		
				<div class="item">
					<img src="images/3.png">
				</div>			
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>