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
					<div id="Page" style="width: 100%;">
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
						<div style="position: relative; top:100px;width:1100px;margin-left: auto;margin-right: auto;">
                        <div style="position: relative; width:90%; margin-left:auto;margin-right:auto; text-align: center;">
                            <p style="font: normal normal bold 48px/64px Noto Sans KR;">문의사항</p>
                        </div>

                        <div>
							<hr style="height: 5px;width: 95%;border-radius: 10px; background-color: #245AE3;">
						</div>
						<div
						style="width:90%;margin-left:auto;margin-right:auto; margin-top:30px;text-align: left;font: normal normal normal 17px/23px Noto Sans KR;letter-spacing: -0.42px;color: #000000;opacity: 1;">
						바로날인 서비스 이용에 도움을 드립니다. </div>
						
						
		
					
					 <div style="position: relative;margin-top:20px;width: 90%; height: 60px; margin-left:auto;margin-right:auto;border: 1px solid #707070;
                        border-radius: 8px;">
                            <p name="title" type="text" id="get_title" style="position: relative;margin:0px; padding-top:15px;padding-left:20px; padding-right:20px;width: calc( 100%- 40px );height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                        ${title}
                        </p>
                        </div>
						<div style="display: flex; margin-top:20px; width:90%;  margin-left:auto;margin-right:auto;">
                         <div style="margin-right: 20px;width: 300px;height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                            <p name="title" type="text" id="get_title" style="padding-left:20px;width: 260px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                       작성자 : ${user_realname}
                        </p>
                        </div>
                         <div style="width: 200px;height: 60px;border: none">
                            <p name="title" type="text" id="get_title" style="width: 300px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                        ${create_time}
                        </p>
                        </div>
						</div>
                        <%-- <div style="margin-top:20px; width:90%;  margin-left:auto;margin-right:auto;height: 60px;border: 1px solid #707070;
                        border-radius: 8px;">
                           <a href="/customerDown/${post_id}" style="display:none;text-decoration: none;" id="file_download"> <p name="title" type="text" id="get_title" style="padding-left:20px;width: 760px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                       <span style="color:black;">첨부파일 : </span>${filename} </p></a>
                        	 <p  type="text" id="no_file" style="padding-left:20px;width: 760px;height:40px;font: normal normal normal 16px/26px Noto Sans KR;">
                       <span style="color:black;">첨부파일 없음 </span>${filename} </p>
                        <script>
                        	
                        	if(`${filename}` != '' && `${filename}`.length>=1)
                        		{
                        		
                        		document.getElementById("file_download").style.display="block";
                        		document.getElementById("no_file").style.display="none";
                        		}
                        </script>
                      
                        </div> --%>
                        
                         <div style="margin-top:20px; width:90%;  margin-left:auto;margin-right:auto;height: 291px;border: 1px solid #707070;
                        border-radius: 8px;">                        
                            <!-- 에디터 자리 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<div style="padding-left: 20px;padding-right: 20px;">${textbody}</div>
                        </div>
                        
						<div style="display:none;margin-top: 20px; width:90%;margin-left: auto;margin-right: auto;" id="show_comment">
							<p style="margin-left:10px;font: normal normal bold 30px/30px Noto Sans KR;">답변</p>
						
							<div style="width: 100%;margin-left: auto;margin-right: auto;height: 291px;border: 1px solid #707070;
							border-radius: 8px;" >                        
								
								<div style="margin-top:20px;margin-left:15px;">${admin_comment}</div>
							</div>
						</div>    
                        
                     <sec:authorize access="isAuthenticated()">
                    	<sec:authentication property="principal" var="principal" />
                  
                  		<div id="admin_box" style="margin-top:20px; width:90%;  margin-left:auto;margin-right:auto;">
                  
							<c:if test="${principal.role eq 'ROLE_ADMIN'}">
							<textarea id="txtContent" rows="10" cols="100" style="width:100%;height:291px;border-radius: 8px;border: 1px solid #707070;"></textarea>
							</c:if>
							
								<input type="hidden" name="" id="comment" >
								<div style="margin-top: 20px;display:flex;justify-content:center;width:90%;margin-left: auto;margin-right: auto;">
								
								<c:if test="${principal.role eq 'ROLE_ADMIN'}">
								<div id="admin_answer" style="margin-right:20px; padding-top:15px;width:80px;height:40px;border-radius:20px;background-color:#245AE3;color:white;font-size:18px;text-align:center" onclick="onClick()">답변</div>
								</c:if>
								
								<c:if test="${principal.role eq 'ROLE_ADMIN' or principal.username eq user_email}">
									<form method="post" action="/user/updateShowpost" id="updatepost">
										<input type="hidden" name="id" value="${post_id}">
										<div onclick="updatepost()" class="site-btn" style="margin-right:20px;text-align:center;padding-top:15px;height:40px;width:80px;border-radius:20px;background-color:#245AE3;font-size:18px;color:white;">수정</div>
										
									</form>
								</c:if>
								
								<c:if test="${principal.role eq 'ROLE_ADMIN' or principal.username eq user_email}">
									<form method="post" action="/user/deleteShowpost" id="delpost">
										<input type="hidden" name="id" value="${post_id}">
										<div onclick="deletepost()" class="site-btn" style="text-align:center;padding-top:15px;height:40px;width:80px;border-radius:20px;background-color:#245AE3;font-size:18px;color:white;">삭제</div>
										
									</form>
								</c:if>
								
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
						


							
						
						
						
						
						
						
						</div>
						
						<script>
							function updatepost()
							{
								$('#updatepost').submit();
							}
							
						
							function deletepost()
							{
								if(confirm("게시글을 삭제하시겠습니까?"))
								{
									$('#delpost').submit();
									alert("게시글을 삭제하였습니다.");
								}
								
								
							}
							
							</script>
					</sec:authorize>
					
					
									
					<div style="display: block;height:100px;width:100%;"></div>
  	</div>
</div>


<script>
if(`${admin_comment}` != '')
{
	
	document.getElementById('show_comment').style.display="block";
	document.getElementById('txtContent').style.display="none";
	document.getElementById('admin_answer').style.display="none";
	
}

</script>

</body>
</html>