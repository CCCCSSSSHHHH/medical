<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name ="user" property="userID"/> 
<jsp:setProperty name ="user" property="userPassword"/>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메디컬 라이브러리</title>
</head>
<body>
	<%
	//이미 로그인이 된사람은 또 로그인하지 못하도록 해줌 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href='main.jsp"); 
		script.println("</script>");
	}
	
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(),user.getUserPassword());//로그인페이지에서 각각 로그인된 아이디 비밀번호 입력값을 넣로그인함수실
	
	if(result == 1){
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href ='main.jsp'");
		script.println("</script>");
	}
	else if (result == 0){//비밀번호틀릴
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); //이전페이지[로그인페이지]로 돌려보냄.
		script.println("</script>");
	}
	else if (result == -1){//아이디 없음 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지않는 아이디입니다.')");
		script.println("history.back()"); //이전페이지[로그인페이지]로 돌려보냄.
		script.println("</script>");
	}
	else if (result == -2){//오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다..')");
		script.println("history.back()"); //이전페이지[로그인페이지]로 돌려보냄.
		script.println("</script>");
	}
	%>
</body>
</html>