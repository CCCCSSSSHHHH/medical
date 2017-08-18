<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="medical.MedicalDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="medical" class="medical.Medical" scope="page"/>
<jsp:setProperty name ="medical" property="medicalTitle"/> 
<jsp:setProperty name ="medical" property="medicalContent"/>

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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'"); 
			script.println("</script>");
		}else{
			if(medical.getMedicalTitle() == null || medical.getMedicalContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된사항이 있습니다.')");
				script.println("history.back()"); //이전페이지로 돌려보냄.
				script.println("</script>");
			}else{

			MedicalDAO medicalDAO = new MedicalDAO();
			int result = medicalDAO.write(medical.getMedicalTitle(), userID, medical.getMedicalContent());
			 
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()"); //이전페이지로 돌려보냄.
				script.println("</script>");
			}
			else{//성공적으로 글작

				PrintWriter script = response.getWriter();
				script.println("<script>");				
				script.println("location.href ='medical.jsp'");
				script.println("</script>");
			}
			}
		}
	%>
</body>
</html>