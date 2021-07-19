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
<meta charset="UTF-8">
<title>모두싸인 : RSA테스트</title>
</head>
<body>
유저

<script type="text/javascript" src="qrcode.js"> alert("알림"); </script>

</body>

<a href="/user/sendRecv">메시지 보내기</a>

<sec:authorize access="isAuthenticated()">
    <form action="/logout" method="POST">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit">LOGOUT</button>
    </form>
</sec:authorize>


</html>