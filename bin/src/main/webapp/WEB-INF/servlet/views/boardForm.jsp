<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
	<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/style_board.css">
	<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
	<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
	<title>Baronarin(Beta)</title>
</head>



<body>
	
<div id="Page" style="width: 100%;">
	<div id = "Controll_Layer">
		<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:100px;
		min-height:80px;">
		<a href="/">
			<img src = "img/google.png" style="height:80px"/>
		</a>
		
		<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
			<li> <a class="btn4" onclick="test()" style="cursor:pointer"> 도장 / 계약서 만들기 </a> </li>
			<li> <a href="/boardForm" class="btn4" style="cursor: pointer; text-decoration:none"> 자료실 </a> </li> 
			<li> <a onclick="alert('서비스 준비중입니다!')" class="btn4" style="cursor: pointer"> 고객센터 </a> </li>
			
				<sec:authorize access="isAnonymous()">
					<li> <a target="_blank" href="/joinForm" class="btn3" style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
					<li> <a href="/loginForm" class="btn2" style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
				</sec:authorize>
			
				<sec:authorize access="isAuthenticated()">
					<li style="margin-left:14px; margin-right:6px;"><sec:authentication property="principal.realname"/>님</li>
					<li><form action="/logout" method="POST">
				        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				        <a class="btn2"><button type="submit" class="btn2_sub" style="cursor: pointer; text-decoration:none;">로그아웃</button>
					</a></form></li>
				</sec:authorize>
			
				</div>

			</div>
		</div>
	</div>

	 <div class="tab-pane fade active show" id="game" style="margin:10px;">
	 		<h5 class="title">자료실</h5>
	 			<hr>
                            
                            <p class="category">동의서,계약서,거래서 등 다양한 문서 방식을 무료로 다운로드 받으세요.</p>
                            
                            <div class="sub_div">
        	                    <a class="category2" href="#">근로</a><b>|</b> 
	                            <a class="category2" href="#">구매</a><b>|</b> 
	                            <a class="category2" href="#">가맹</a><b>|</b> 
	                            <a class="category2" href="#">보험</a><b>|</b> 
	                            <a class="category2" href="#">금융</a><b>|</b> 
	                            <a class="category2" href="#">렌탈</a><b>|</b> 
	                            <a class="category2" href="#">기타</a>
                            </div>
                            
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>*분야*</th>
                                        <th>*문서*</th>
                                        <th>*형식*</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>인사/노무</td>
                                        <td style="text-align:center;">표준근로계약서</td>
                                        <td><a href="#">PDF</a><b> | </b><a href="#">HWP</a></td>
                                    </tr>
                                    <tr>
                                        <td>유통/구매</td>
                                        <td style="text-align:center;">개인정보제공동의서</td>
                                        <td><a href="#">PDF</a><b> | </b><a href="#">HWP</a></td>
                                    </tr>
                                    <tr>
                                        <td>광고/홍보/마케팅</td>
                                        <td style="text-align:center;">납품계약서</td>
                                        <td><a href="#">PDF</a><b> | </b><a href="#">HWP</a></td>
                                    </tr>
                                    <tr>
                                        <td>정보/보안</td>
                                        <td style="text-align:center;">검수확인서</td>
                                        <td><a href="#">PDF</a><b> | </b><a href="#">HWP</a></td>
                                    </tr>
                                    <tr>
                                        <td>인사/노무</td>
                                        <td style="text-align:center;">표준근로계약서</td>
                                        <td><a href="#">PDF</a><b> | </b><a href="#">HWP</a></td>
                                    </tr>
                                </tbody>
                            <div class="col-lg-12" style="text-align: end; padding:20px 40px;">
                                <a href="#"><button type="submit" class="site-btn">양식 업로드</button></a>
                            </div>
                            </table>
                     </div>
                        
                        <div class="product__pagination">
                        	<a href="#" class="current-page">1</a>
                        	<a href="#">2</a>
                        	<a href="#">3</a>
                        	<a href="#">4</a>
                        	<a href="#">5</a>
                        	<a href="#"><i class="fa fa-angle-double-right"></i></a>
                   		</div>
                   		

	</div>
</body>
</html>