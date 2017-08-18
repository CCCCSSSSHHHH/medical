<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="medical.MedicalDAO" %>
<%@ page import="medical.Medical" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


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
		if(!userID.equals(medical.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='medical.jsp'"); 
			script.println("</script>");
		}else{
			if(request.getParameter("medicalTitle") == null || request.getParameter("medicalContent") == null
				||request.getParameter("medicalTitle").equals("") ||request.getParameter("medicalContent").equals("")	){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된사항이 있습니다.')");
				script.println("history.back()"); //이전페이지로 돌려보냄.
				script.println("</script>");
			}else{

			MedicalDAO medicalDAO = new MedicalDAO();
			int result = medicalDAO.update(medicalID, request.getParameter("medicalTitle"), request.getParameter("medicalContent"));
			 
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패했습니다.')");
				script.println("history.back()"); //이전페이지로 돌려보냄.
				script.println("</script>");
			}
			else{//성공적으로 글작

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정 완료되었습니다.')");
				script.println("location.href ='medical.jsp'");
				script.println("</script>");
			}
			}
		}
	%>
</body>
</html>