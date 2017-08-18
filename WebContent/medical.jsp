<%@  page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@page import = "medical.MedicalDAO" %>
<%@page import = "medical.Medical" %>
<%@page import = "java.util.ArrayList" %>
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
		int pageNumber = 1; //기본페이
		if(request. getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<style> logo{ display: table; margin-left: auto; margin-right: auto;}</style>
	<nav class="navbar navbar-default">
	
	<div class="logo">
	 <a href="main.jsp"><img src="http://sculpstore.co.kr/wp-content/uploads/2015/01/logo.png" ></a>
	</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		
			<ul class="nav navbar-nav navbar-right">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="medical.jsp">게시판</a></li>
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
			<table class = "table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead> 
					<tr>
						<th style="background-color:#eeeeee;text-align:center;">번호</th>
						<th style="background-color:#eeeeee;text-align:center;">제목</th>
						<th style="background-color:#eeeeee;text-align:center;">작성자</th>
						<th style="background-color:#eeeeee;text-align:center;">작성일</th>
						<th style="background-color:#eeeeee;text-align:center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						
						MedicalDAO medicalDAO =new MedicalDAO();
						ArrayList<Medical> list = medicalDAO.getList(pageNumber);
						int medicalhit;
						for(int i = 0; i < list.size() ; i++){
						medicalhit = list.get(i).getMedicalhit();
					%>
					<tr>
						<td><%= list.get(i).getMedicalID() %></td>
						<td><a href="view.jsp?medicalID=<%= list.get(i).getMedicalID()%>"><%= list.get(i).getMedicalTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a></td>					
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getMedicalDate().substring(0,11)/*+list.get(i).getMedicalDate().substring(11,13)+"시"+list.get(i).getMedicalDate().substring(14,16)+"분*/ %></td>
						<td><%= list.get(i).getMedicalhit()  %></td> <!-- 조회수 해야할 부분 -->
					</tr> 
					<% 
						medicalhit ++;
						}
					%>
					
				</tbody>
			</table> 
			
			<%
				if(pageNumber != 1){
			%>
				<a href ="medical.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<% 		
				} if(medicalDAO.nextPage(pageNumber +1)){ 				
			%>
				<a href ="medical.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
			
				}
			%>
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>