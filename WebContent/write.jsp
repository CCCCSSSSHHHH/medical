<%@  page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.css">
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
		<div class="row">
		<form method="post" action="writeAction.jsp">
		<table class = "table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead> 
					<tr>
						<th colspan="2" style="background-color:#eeeeee;text-align:center;">게시판 글쓰기 양식</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="medicalTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td> <textarea class="form-control" placeholder="글 내용" name="medicalContent" maxlength="2048" style="height: 350px;"></textarea> </td>
					</tr>
				</tbody>
			</table> 
			<input type="submit"  class="btn btn-primary pull-right" value="글쓰기">
		</form>
			
			
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>