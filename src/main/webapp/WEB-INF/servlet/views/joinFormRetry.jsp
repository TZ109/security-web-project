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
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/css/webHome.css">
	 <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" type="text/css" href="/css/style_login2.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css?ver=1">
    <link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
    <link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
     <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
<title>회원가입테스트</title>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>



</head>
<body>
 
<div id="Page" style="width: 100%;">
     <div id = "Controll_Layer">
		<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
		<a href="/">
			<img src = "img/google.png" style="height:80px"/>
		</a>
		
		<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
			
			<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실 </a> </li> 
			<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터 </a> </li>
			
				<sec:authorize access="isAnonymous()">
					<li> <a  href="/joinForm" class="btn7" style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
					<li> <a href="/loginForm" class="btn6" style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
				</sec:authorize>
			
				<sec:authorize access="isAuthenticated()">
					<li style="margin-left:14px; margin-right:6px;"><sec:authentication property="principal.realname"/>님</li>
					<li><form action="/logout" method="POST">
				        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				        <a class="btn6"><button type="submit" class="btn6_sub" style="cursor: pointer; text-decoration:none;">로그아웃</button>
					</a></form></li>
				</sec:authorize>
			
	

			
			


			
		</ul>
		</nav>
     </div>
   </div>






<img src="/img/bi)바로날인beta_KR.png" style="position: absolute;top: 186px;left: 830px;width: 260px;height: 111px;"/>




	
	
	
	<div style="position: absolute;top: 356px;left: 761px">
<!--  <form method="post" action="/dupname" id="checkId">-->
	<input type="text"  name="checkname" placeholder="아이디" id="checkName" onchange="check_id()" style="width: 398.00px;height: 60.00px;" class="sign_up_input"><br/>
<!--  </form>-->
	
	
	<p style="display:none; color: red;" id="idPoss">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사용 가능한 아이디입니다.
	</p>
	
	<p style="display:none; color: red;" id="idImposs">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;해당 아이디는 이미 사용 중 입니다.
	</p>
	
	<p style="display:none; color: red;" id="idNeqEmail">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이메일을 아이디로 입력하십시오.
	</p>
	
	<p style="display:none; color: red;" id="idEmpty">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아이디에는 공백이 들어갈 수 없습니다.
	</p>
	
	</div>
	<script>
	function check_id()
	{
		var memberId = $("#checkName").val();

		if(memberId.search(/\s/) != -1) { 
			document.getElementById('idPoss').style.display= "none";
 			document.getElementById('idImposs').style.display= "none";
 			document.getElementById('idNeqEmail').style.display= "none";
 			document.getElementById('idEmpty').style.display= "block";    
	    } else {             
	        if(memberId.trim().length != 0) {
	            $.ajax({
	                async : true, 
	                type : 'POST', 
	                data: memberId,
	                url: "/idCheck",
	                dataType: "json",
	                contentType: "application/json; charset=UTF-8",
	                success: function(count) {    
	                	if(count == -1) {
	                           
	                        document.getElementById('idPoss').style.display= "none";
	            			document.getElementById('idImposs').style.display= "none";
	            			document.getElementById('idNeqEmail').style.display= "block";
	            			document.getElementById('idEmpty').style.display= "none";
	            			$('#result2').val("Fail");
	                    } 
	                	
	                	else if(count == 1) {
	                           
	                        document.getElementById('idPoss').style.display= "none";
	            			document.getElementById('idImposs').style.display= "block";
	            			document.getElementById('idNeqEmail').style.display= "none";
	            			document.getElementById('idEmpty').style.display= "none";
	            			$('#result2').val("Fail");
	                        //window.location.reload();//재접속
	                    }
	                	else if(count == 0){
	                        
	                        document.getElementById('idPoss').style.display = "block";
	            			document.getElementById('idImposs').style.display= "none";
	            			document.getElementById('idNeqEmail').style.display= "none";
	            			document.getElementById('idEmpty').style.display= "none";
	            			$('#result2').val("Success");
	                    }            
	                },
	                error: function(error)//
	                {
	                	document.getElementById('idPoss').style.display= "none";
	        			document.getElementById('idImposs').style.display = "block";
	        			document.getElementById('idNeqEmail').style.display= "none";
	        			document.getElementById('idEmpty').style.display= "none";
	        			$('#result2').val("Fail");
	                }        
	            });
	        } else//
	        {
	        	document.getElementById('idPoss').style.display= "none";
	 			document.getElementById('idImposs').style.display= "none";
	 			document.getElementById('idNeqEmail').style.display= "none";
	 			document.getElementById('idEmpty').style.display= "block"; 
	 			$('#result2').val("Fail");
	        }        
	    }
		
		//$('#checkId').submit();
		
	}
	
	//function sign_upload()
	{
		//var a= document.getElementById('inputfile');
		//a.click();
	}
	
	
	window.onload = function()
	{
		
		var result = $('#result').val();
		
		//var success = $('#result2').val();
		/*
		if(success==1)
		{
			$('#checkName').val(result);
			$('#idName').val(result);
			document.getElementById('idPoss').style.display = "block";
			document.getElementById('idImposs').style.display= "none";
			document.getElementById('idNeqEmail').style.display= "none";
		}
		
		else if(success==-1)
		{
			$('#checkName').val(result);
			document.getElementById('idPoss').style.display= "none";
			document.getElementById('idImposs').style.display = "block";
			document.getElementById('idNeqEmail').style.display= "none";
		}
		
		else if(success==-2)
		{
			$('#checkName').val(result);
			document.getElementById('idPoss').style.display= "none";
			document.getElementById('idImposs').style.display= "none";
			document.getElementById('idNeqEmail').style.display= "block";
		}
		
		else*/
		{
			$('#checkName').val(result);
			//$('#idName').val(result);
			//document.getElementById('idPoss').style.display= "none";
			//document.getElementById('idImposs').style.display= "none";
			//document.getElementById('idNeqEmail').style.display= "none";
		}
		
	
	}
	
	</script>


<div style="position: absolute; display: flex; justify-content: space-between; align-items: center;top: 448px;left: 761px">
	<input type="text"  name="checkname" placeholder="이름" id="realName1" class="sign_up_input"  style="width: 398.00px;height: 60.00px;">
	<!--  <input type="button" id="sign_up_load" value="사인 업로드" onclick="sign_upload()" style="height:50px" class="btn">--><br/>
	</div>

		<input type="hidden" id="result" value="${checkName}">
		<input type="hidden" id="result2" value="${checkSuccess}">


<form method="post" action="/join" id="formId" enctype="multipart/form-data">
		<input type="hidden" name="realname" id="realName2">
		<input type="hidden"  name="username"  id="idName" >
		<!--  <input style="display:none;" multiple="multiple" type="file" name="uploadFile" id="inputfile" class="button">-->
		
		 <div style="position: absolute;top: 540px;left: 761px">
		<input type="password" name="password"  placeholder="비밀번호" id="pass1" class="sign_up_input"  style="width: 398.00px;height: 60.00px;">
		</div>
		<div style="position: absolute;top: 632px;left: 761px">
		<input type="password" name="checkpw" placeholder="비밀번호 확인" id="pass2" class="sign_up_input"  style="width: 398.00px;height: 60.00px;">
		</div>
		<!--  <input type="hidden" name="email"  id="emailValue">-->


</form>

<div style="position: absolute;top: 784px;left: 810px">
        <input type="checkbox" style='zoom:2.0;' id="sign_check">
        <font style="font: normal normal normal 14px/26px Noto Sans KR;padding-bottom:2px;padding-left:8px">개인정보 수집 및 이용약관에 동의합니다.</font>
      </div>

<input type="button" id="button" value="저장"  onclick="submit_form()" class="btn2" style="position: absolute;top: 840px;left: 880px;width:172px;height:54px;">

<script>
	function submit_form()
	{
		$('#realName2').val($('#realName1').val());//사용자 이름 
		$('#idName').val($('#checkName').val());//사용자 이메일
		var real = $('#realName2').val();
		
		var user1 = $('#checkName').val();
		//var result = document.getElementById("checkResult").value;	
	
		var p1 = $('#pass1').val();
		var p2 = $('#pass2').val();
		
		var email1 = $('#idName').val();
		
		//var a= document.getElementById('inputfile').value;
		var b= document.getElementById('sign_check').checked;
		
		
		var success = $('#result2').val();
		
		
		if(user1 == '') {
			alert("아이디를 입력하십시오.");		
			return false;
		}
		
		if(user1 == -1) {
			alert("해당 아이디는 사용할 수 없습니다.");		
			return false;
		}
		
		if(success!="Success")
		{
			alert("아이디를 다시 설정하십시오.");
			return false;
		}
		
		
		if(real == ''){
			alert("이름을 입력하십시오.");
			return false;
		}
		
		//if(!a)
		{
			//alert("서명을 업로드하십시오.");		
			//return false;
		}

		
		if(p1 == '') {
			alert("비밀번호를 입력하십시오.");		
			return false;
		}
		else if (p1 != p2) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		if(email1 == '') {
			alert("이메일을 입력하십시오.");		
			return false;
		}
		
		if(!b)
			{
			alert('개인정보 수집란에 동의하십시오.');
			return false;
			}
		
		$('#formId').submit();//form양식대로 제출
	}
	
</script>

<br/>




</body>
</html>
