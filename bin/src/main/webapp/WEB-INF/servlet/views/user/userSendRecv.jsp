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
	
<title>모두싸인 : RSA테스트</title>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<!--  
<script type="text/javascript" src="%=request.getContextPath()%>/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="%=request.getContextPath()%>/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="%=request.getContextPath()%>/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="%=request.getContextPath()%>/js/rsa/rng.js"></script>
        <script type="text/javascript" src="%=request.getContextPath()%>/js/login.js"></script>
-->


<script type="text/javascript" src="../js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../js/RSA/rsa.js"></script>
<script type="text/javascript" src="../js/RSA/prng4.js"></script>
<script type="text/javascript" src="../js/RSA/rng.js"></script>

<!--  
<script src="js/jsbn.js"></script>
<script src="js/rsa.js"></script>
<script src="js/prng4.js"></script>
<script src="js/rng.js"></script>
-->

</head>
<body width="100%" height="100%">


<a href="/" id="topimg">
	<div class="wrap">
      <img class="img-concert" src="/img/google.png" style="width:30%;"/>
    </div>
  </a>
  
<script type="text/javascript" src="qrcode.js"> alert("알림"); </script>

<hr/>



<sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.email" var="email" />
                  
                    <div id="user_id">안녕하세요. ${email}</div>
</sec:authorize>


<br/>
<!-- 
<script>
//$("input[name=y]").click(
		
function change(item){//지금은 안쓰는 함수
	var yEnc = $('#entext').val();
	
	var rsa = new RSAKey();
	rsa.setPublic(${publicKeyModulus}.val(), ${publicKeyExponent}.val());
	
	yEnc = rsa.encrypt(yEnc);
	alert('왜 안뜸?');
	item.val('왜안뜸?');
}

</script>

-->
    <form action="/mail" method="post">
        <input name="address" placeholder="이메일 주소"> <br>
        <input name="title" placeholder="제목"> <br>
        <textarea name="message" placeholder="메일 내용을 입력해주세요." cols="60" rows="20"></textarea>
        <button>발송</button>
    </form>



<form method="post" action="/user/insertDB" id="formId">
전송할 메시지 : <input type="text" id="entext1" name="x"><br/>
		<input type="hidden" id="entext2" name="y" value="">
받는 사람    : <input type="text" name="z">
     	<input type="hidden" id="rsaModulus" value="${Modulus}" />
		<input type="hidden" id="rsaExponent" value="${Exponent}"/>
<input type="button" id="button" value="저장">


<script>
	button.onclick = () =>
	{
		var yEnc = $("#entext1").val();
		var expo = document.getElementById("rsaExponent").value;
		var modul = document.getElementById("rsaModulus").value;
		if(!yEnc){
			alert("암호문을 입력하세요");
			return false;
		}
			
		var rsa = new RSAKey();
		//rsa.setPrivate(${privateKey}.val());
		rsa.setPublic(modul,expo);
		yEnc = rsa.encrypt(yEnc);

		alert("클릭되었습니다.");
		$('input[name=y]').val(yEnc);
		
		$('#formId').submit();//form양식대로 제출
		
	}
	</script>
</form>


<br/>
<div class="showkey">
유저 PublicKeyModulus  : ${Modulus}<br/>
유저 PublicKeyExponent : ${Exponent}<br/>
</div>

<!-- 
<form method="post" action="/user/insertDB" id="formId">
그냥 값: <input type="text" id="text1" name="x"><br/>
암호화시킨 문자열: <input type="hidden" id="entext2" name="entext2" value="">
보낼 이: <input type="text" name="z">
<input type="button" id="button" value="저장">

<script>
	button.onclick = () =>
	{
		
		
		var yEnc = $("#entext1").val();
		
		if(!yEnc){
			alert("암호문을 입력하세요");
			return false;
		}
			
		var rsa = new RSAKey();
		rsa.setPublic($("#rsaPublicKeyModulus").val(), $("rsaPublicKeyExponent").val());
		
		yEnc = rsa.encrypt(yEnc);

		alert("클릭되었습니다.");
		$("entext2").val(yEnc); 
		$('#formId').submit();//form양식대로 제출
		
	}
	</script>

</form>
-->

</body>
</html>