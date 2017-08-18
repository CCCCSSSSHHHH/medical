<%@  page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import= "medical.Medical" %>
<%@ page import= "medical.MedicalDAO" %>
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
		int medicalID=0;
		if(request.getParameter("medicalID")!=null){
			medicalID=Integer.parseInt(request.getParameter("medicalID"));
		}
		if(medicalID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='medical.jsp'"); 
			script.println("</script>");
		}
		Medical medical = new MedicalDAO().getMedical(medicalID);
	%>
	<style> .logo{ display: table; margin-left: auto; margin-right: auto;}</style>
	
	
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
						<th colspan="3" style="background-color:#eeeeee;text-align:center;">게시판 글보기</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= medical.getMedicalTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>						
					</tr>
					
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= medical.getUserID() %></td>						
					</tr>
					
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= medical.getMedicalDate().substring(0,11)/*+medical.getMedicalDate().substring(11,13)+"시"+medical.getMedicalDate().substring(14,16)+"분"*/%></td>						
					</tr>
					
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height:200px; text-align:left"><%= medical.getMedicalContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>						
					</tr>
					
					<tr> <!-- 조회수 해야할 부분 --> 
						<td>조회수</td>
						<td colspan="2"><%= medical.getMedicalhit() %></td>						
					</tr>
				</tbody>
			</table> 
			<a href="medical.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(medical.getUserID())){ //현재사용자와 글 작성자가 동일하다면
			%>
				<a href="update.jsp?medicalID=<%= medicalID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"href="deleteAction.jsp?medicalID=<%= medicalID %>" class="btn btn-primary">삭제</a>
			<% 
				}
			%>
			<input type="submit"  class="btn btn-primary pull-right" value="글쓰기">
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>