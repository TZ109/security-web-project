<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>

<form type="get" action="" id="default_action">
</form>

<input id="complete" value="${sign_complete}">
<input id="null" value="${sign_null}">
<script>

	var com = document.getElementById("complete").value; 
	var nu = document.getElementById("null").value;
	if(com=="complete")
		alert('서명이 완료된 계약서입니다.');
	
	if(nu=="null")
		alert("취소된 계약서입니다.");
	
	$('#default_action').submit();
</script>
</body>
</html>