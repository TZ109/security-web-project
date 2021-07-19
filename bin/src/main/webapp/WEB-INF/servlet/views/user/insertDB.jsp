<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    

<%@page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
<title>메시지 보내기</title>
</head>
<body width="100%" height="100%">

<%
String x = request.getParameter("x");
String y = request.getParameter("y");

Connection conn=null;
Statement stmt=null;

try 
{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jspdb","root","1234");
	
	if(conn == null)
		throw new Exception("데이터베이스 연결 실패");
	
	stmt=conn.createStatement();
	stmt.executeUpdate("insert into inputXY (x,y) values('"+x+"','"+y+"')");
	
	ResultSet rs = stmt.executeQuery("select * from inputXY");
	
	while(rs.next())
	{
		int xx = rs.getInt("x");
		int yy = rs.getInt("y");
		out.println("<br> x: "+xx+"<br> y: "+yy);
	}
}finally{
	try{
		stmt.close();
	}catch(Exception ignored)
	{
		
	}
}

%>



</body>
</html>