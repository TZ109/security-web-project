<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
			<%@ page import="org.springframework.security.core.Authentication" %>
				<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

<!DOCTYPE html>
				<html>

				<head>
					<meta charset="utf-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<!--  <meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />-->
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<script type="text/javascript" src="../libs/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
					<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
					<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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

                        <div style="position: absolute;top:132px;left: 874px;width: 1280px;">
                            <p style="font: normal normal bold 48px/64px Noto Sans KR;">문의사항</p>
                        </div>

                        <div style="position: absolute;top: 252px;left: 320px;">
                            <hr style="height: 5px;width: 1280px;border-radius: 10px; background-color: #245AE3;">
                        </div>

                        <div style="position: absolute;top:270px;left: 830px;width: 1280px;">
                            <p style="font: normal normal normal 18px/24px Noto Sans KR;">바로날인 서비스에 도움을 드립니다.</p>
                        </div>
						
						
					<div id="controller_background_gray">	
					
					 <div style="position: absolute;top: 430px;left: 414px;width: 1092px;height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                            <p name="title" type="text" id="get_title" style="position: absolute;margin:0px;top:20px;left:20px;width: 1050px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                        ${title}
                        </p>
                        </div>
                         <div style="position: absolute;top: 500px;left: 414px;width: 300px;height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                            <p name="title" type="text" id="get_title" style="position: absolute;margin:0px;top:20px;left:20px;width: 300px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                       작성자 : ${user_realname}
                        </p>
                        </div>
                         <div style="position: absolute;top: 500px;left: 734px;width: 200px;height: 60px;border: none">
                            <p name="title" type="text" id="get_title" style="position: absolute;margin:0px;top:20px;left:20px;width: 300px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                        ${create_time}
                        </p>
                        </div>
                        
                        <div style="position: absolute;top: 570px;left: 414px;width:800px;'height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                           <a href="/customerDown/${post_id}"> <p name="title" type="text" id="get_title" style="position: absolute;margin:0px;top:20px;left:20px;width: 800px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                       <span style="color:black">첨부파일 : </span>${filename} </p></a>
                        
                      
                        </div>
                        
                         <div style="position: absolute;top: 650px;left: 414px;width: 1092px;height: 291px;border: 1px solid #707070;
                        border-radius: 8px;">                        
                            <!-- 에디터 자리 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<div style="position:absolute;top:10px;left:15px;">${textbody}</div>
                        </div>
                        
                        
                        
                        
                     <sec:authorize access="isAuthenticated()">
                    	<sec:authentication property="principal" var="principal" />
                  
						<c:if test="${principal.role eq 'ROLE_ADMIN'}">
						
						<div id="admin_box">
							<textarea id="txtContent" rows="10" cols="100" style="width: 1092px;height:291px;border-radius: 8px;border: 1px solid #707070;position:absolute;top:1000px;left:414px"></textarea>
							
							
								<input type="hidden" name="" id="comment" >
								<button style="position:absolute;top:1300px;left:414px;" onclick="onClick()">답변</button>
							
							
							<script>
							
							function onClick()
							{
								var text = document.getElementById('txtContent').value;
								var id=`${post_id}`;
								var dataform = {"text":text, "id":id};
								//var text =  $("#comment").val();
								//alert("text : "+text+"\nid : "+id);
								console.log(dataform.id);
								
								
								$.ajax({
									async: true,
									type : 'GET', 
						            data: dataform,//{'text':text, 'id':id},
						            url: "/user/customerComment",
						            dataType: "json",
						            contentType: "application/json; charset=UTF-8",
						            success: (result)=>{
						            	
						            	if(result==1)
						            		alert('답변 업로드 성공');
						            	
						            	else
						            		alert('답변 업로드 실패');
						            },
						            error : () => {
						            	alert('error');
						            }
								})
								
							}
							</script>
						</div>
						</c:if>
					</sec:authorize>
					
					<div style="display:none;position: absolute;top:960px;left:414px;" id="show_comment">
						<p style="font: normal normal bold 30px/64px Noto Sans KR;">답변</p>
					
						<div style="position: absolute;top:90px;width: 1092px;height: 291px;border: 1px solid #707070;
                        border-radius: 8px;" >                        
                            
							<div style="position: absolute;top:20px;left:15px;">${admin_comment}</div>
                        </div>
					</div>
					
					<script>
					
						if(`${admin_comment}` != '')
						{
							
							document.getElementById('show_comment').style.display="block";
							document.getElementById('admin_box').style.display="none";
							
							}
					
					</script>
					
                        <div style="position: absolute;top: 1350px;left: 320px;">
                            <hr style="height: 1px;width: 1280px;border-radius: 10px; background-color: #245AE3;">
                            <br/>
                        </div>
                       

  </div>
</div>
</body>
</html>