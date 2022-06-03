<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
	<style>
	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
body {
  font-family: "Noto Sans KR", sans-serif;
}
	</style>
</head>

<body style="margin:0;height: 300px;">
<h1 style="padding:20px 20px;margin:0; height:55px; background: #245AE3 0% 0% no-repeat padding-box; text-align: left; font: normal normal medium 47px/55px Roboto; letter-spacing: -1.18px; color: #FFFFFF;">NOTICE</h1>

<div style="width:627px; margin-top:30px;">
<p style="margin-left:20px; font-size:21px;color : #191919;">계약서 작성시 참여인원이 전부 회원가입이 되어있어야 </p>
<p style="margin-left:20px; font-size:21px;color : #191919;">계약서작성이 가능합니다. </p>
<p style="margin-left:20px; font-size:21px;color: #191919;">
서명참여자의 이름과 이메일이 회원가입된 내용과 일치해야합니다.</p>
</div>



</body>
</html>