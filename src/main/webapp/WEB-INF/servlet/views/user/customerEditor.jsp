<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>a
			<%@ page import="org.springframework.security.core.Authentication" %>



				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="utf-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<!--  <meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />-->
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<script type="text/javascript" src="../libs/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
					<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
					<title>문의사항 작성</title>
				</head>

				<body>
					<div id="Page" style="width: 100%; height:100%">
						<div id="Controll_Layer">
							<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
								<a href="/">
									<img src="/img/google.png" style="height:80px" />
								</a>

								<div>쉽고 빠른 전자계약, 바로날인</div>

								<input type="hidden" value="${isValidUser}" id="is_valid_user">

							</nav>
                        </div>

                        <div style="position: absolute;top:132px;left: 874px;">
                            <p style="width:400px;font: normal normal bold 48px/64px Noto Sans KR;">문의하기</p>
                        </div>

                        <div style="position: absolute;top: 252px;left: 320px;">
                            <hr style="height: 5px;width: 1280px;border-radius: 10px; background-color: #245AE3;">
                        </div>

                        <div style="position: absolute;top:270px;left: 830px;">
                            <p style="width:600px;font: normal normal normal 18px/24px Noto Sans KR;">바로날인 서비스에 도움을 드립니다.</p>
                        </div>

<form action="/user/editUpload" method="post" id="send" enctype="multipart/form-data">
	
	
	<input type="hidden" name="textbody" id="tb" >
	
	

	 <div style="position: absolute;top:390px;left: 414px;">
                            <input onclick="pass()" type="checkbox" style="margin: 0px;zoom:1.2" id="sign_check" name="secret">
                            <label for="secret" style="font: normal normal normal 14px/14px Noto Sans KR">비밀글</label>
                        </div>

                        <div style="position: absolute;top: 430px;left: 414px;width: 1092px;height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                            <input name="title" type="text" id="get_title" placeholder="제목" maxlength="15" style="border:none;position: absolute;top:10px;left:20px;width: 1050px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                        </div>
	
	<input type="password" style="position: absolute;display:none;top:390px;left: 500px;" id="textpass" name="secretpassword" placeholder="비밀번호">
	
	<input type="hidden" name="checkfile" id="isfile" value="yes">
	<script>
	function pass()
	{

		document.getElementById("textpass").style.display="block";
	}
	
	
	</script>

	
	
	<div>
	<input type="file" name="uploadfile" id="inputfile" style="display:none">
	</div>
</form>

                       

                        <div style="position: absolute;top: 500px;left: 414px;width: 1092px;height: 291px;
                        ">
                            <!-- 에디터 자리 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<textarea id="txtContent" rows="10" cols="100" style="width: 100%;height:260px;border-radius: 8px;border: 1px solid #707070;"></textarea>
	<!-- textarea 밑에 script 작성하기 -->
	<script id="smartEditor" type="text/javascript"> 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "txtContent",  //textarea ID 입력
		    sSkinURI: "../libs/smarteditor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
		    fCreator: "createSEditor2",
		    htParams : { 
		    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
		        bUseToolbar : true, 
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : false, 
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : false 
		    }
		});
		
		
		
	</script>
                        </div>
                        
						 <a onclick="upload_file()">   
                        <div style="position: absolute;top: 820px;left: 450px;width: 82px;height: 33px;border: 1px solid #707070;
                        border-radius: 8px;">
                        <p style="position: absolute;top:7px;left:10px;width:70px;margin:0px;font: normal normal medium 14px/3px Noto Sans KR;color: #8D8D8D;">파일 선택</p>

                        </div>
                        </a>

						<a onclick="save()">
                        <div style="position: absolute;top: 863px;left: 839px;width: 141px;height: 46px;background: #245AE3 0% 0% no-repeat padding-box;
                        border-radius: 8px;">
                        <p style="text-align: center;font: normal normal medium 14px/20px Noto Sans KR;letter-spacing: 0px;color: #FFFFFF;">문의 등록하기</p>
                        </div>
                        </a>
                        
                        
                        <a href="/customerCenter">
                        <div style="position: absolute;top: 863px;left: 1000px;width: 141px;height: 46px;background: #E5E5E5 0% 0% no-repeat padding-box;
                        border-radius: 8px;">
                        <p style="text-align: center;font: normal normal medium 14px/20px Noto Sans KR;letter-spacing: 0px;color: #FFFFFF;">목록 보기</p>
                        </div>

                    </div>
                    
                    
                    <script>
                    function upload_file()
                    {
                    	document.getElementById('inputfile').click();
                    }
                    
                    

function save(){
	var title = document.getElementById("get_title").value;
	var filecheck = document.getElementById('inputfile').value;
	
	if(!title)
	{
		alert('제목을 입력하십시오.');
		return false;
	}
	
	if(!filecheck)
	{
			$('#isfile').val("no");
		}
	
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
    		//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
    		
	console.log(document.getElementById("txtContent").value);
    		// 값을 불러올 땐 document.get으로 받아오기
    		
    $('#tb').val(document.getElementById("txtContent").value);
    $('#send').submit();
}

</script>
                </body>                   
</html>