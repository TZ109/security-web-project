<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Mail-서명요청</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
  </head>
  <body>
     <img src="https://www.baronarin.com/images/mailimage/barologo.png" style="position: absolute;top:15px;left:315px;width:150px;height:50px"/>
     <img src="https://www.baronarin.com/images/mailimage/baroslogan.svg" style="position: absolute;top:27px;left:1391px;width:209px;height: 27px"/>
       <div> <p style="position: absolute;top: 366px;left: 825px;width: 331px;height: 47px;font-size: 31px;font-style: normal;font-variant: normal;font-weight: medium;line-height: 47px;text-align: left;letter-spacing: -0.8px;color: #245AE3;opacity: 1;"><font face="Noto Sans KR">서명이 완료되었습니다.</font></p></div>
     <div><a href="/"> <p style="position: absolute;top: 490px;left: 725px;width: 470px;height: 72px;font-size: 22px;font-style: normal;font-variant: normal;font-weight: medium;line-height: 36px;text-align: center;letter-spacing: -0.6px;color: #343434;opacity: 1"><font face="Noto Sans KR">메인 페이지로 가려면 아래 버튼을 클릭하세요.</font></p></a></div>
     <img style="position: absolute;top: 584px;left: 637px;width: 688px;height: 0px;border: 1px solid #A7A7A7;opacity: 1;" src="https://www.baronarin.com/images/mailimage/선.svg" alt="">
     <img style="position: absolute;top: 602px;left: 770px;width: 380px;height: 83px;opacity: 1;" src="https://www.baronarin.com/images/mailimage/메인페이지.png" alt="">
  </body>
</html>
