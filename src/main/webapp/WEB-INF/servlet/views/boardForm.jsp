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
	<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
	<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/style_board.css">
	<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
	<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<title>Baronarin(Beta)</title>
</head>



<body>
	
<div id="Page" style="width: 100%;">
	<div id = "Controll_Layer">
		<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:100px;
		min-height:80px;">
		<a href="/">
									<img src="/img/google.png" style="height:80px" />
								</a>

								<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
									<li> <a class="btn5" onclick="test()" style="cursor:pointer"> 계약서 / 서명 만들기 </a>
									</li>
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터
										</a> </li>

									<sec:authorize access="isAnonymous()">
										
										<li> <a href="/joinForm" class="btn7"
												style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
										<li> <a href="/loginForm" class="btn6"
												style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
									</sec:authorize>

									<sec:authorize access="isAuthenticated()">
										<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer">마이페이지</a></li>
										<li>
											<form action="/logout" method="POST">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<a class="btn6"><button type="submit" class="btn6_sub"
														style="cursor: pointer; text-decoration:none;">로그아웃</button>
												</a>
											</form>
										</li>
									</sec:authorize>
				</ul>

			</nav>
		</div>
	</div>

	 <div class="tab-pane fade active show" id="game" style="margin:10px;">
	 		<h5 class="title">자료실</h5>
	 			<hr style="width:1280px">
                            <form action="/board" method="get" id="category_select">
                            	<input name="postType" id="post_type">
                            </form>
                            <p class="category">동의서,계약서,거래서 등 다양한 문서 방식을 무료로 다운로드 받으세요.</p>
                            
                            <div class="sub_div">
        	                    <a class="category2" onclick="select_cate(1)">근로</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(2)">구매</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(3)">가맹</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(4)">보험</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(5)">금융</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(6)">렌탈</a><b>|</b> 
	                            <a class="category2" onclick="select_cate(7)">기타</a>
                            </div>
                            
                            <script>
                            	function select_cate(num)
                            	{
                            		
                            		switch(num)
                            		{
                            		case 1:
                            			document.getElementById('post_type').value="1";
                            			break;
                            		case 2:
                            			document.getElementById('post_type').value="2";
                            			break;
                            		case 3:
                            			document.getElementById('post_type').value="3";
                            			break;
                            		case 4:
                            			document.getElementById('post_type').value="4";
                            			break;
                            		case 5:
                            			document.getElementById('post_type').value="5";
                            			break;
                            		case 6:
                            			document.getElementById('post_type').value="6";
                            			break;
                            		case 7:
                            			document.getElementById('post_type').value="7";
                            			
                            		}
                            		$('#category_select').submit();
                            	}
                            
                            </script>
                            
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>*분야*</th>
                                        <th>*문서*</th>
                                        <th>*형식*</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                <c:forEach items="${postlist.content}" var="data">
                               		 <tr>
                                        <td>${data.specificType}</td>
                                        <td style="text-align:center;"> ${data.title}</td>
                                        <td><a href="/boardDown/${data.pdfLink}">PDF</a><b> | </b><a href="/boardDown/${data.hwpLink}">HWP</a></td>
                                    </tr>
                              		
                                </c:forEach>
                              
                                   
                                </tbody>
                                
					
							<sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal" var="principal" />
                  
					<c:if test="${principal.role eq 'ROLE_ADMIN'}">
					<div class="col-lg-12" style="text-align: end; padding:20px 40px;">
                                <a href="/user/boardUpload"><button type="submit" class="site-btn">양식 업로드</button></a>
                            </div>
					</c:if>
					</sec:authorize>
							
                            
                            
                            </table>
                            
                   
                     </div>
                        

                        
                        <input type="hidden" value="1" id="current_num">
                        
                        <div class="product__pagination">
              
              <c:if test="${!postlist.first}">

		<a href="?page=${postlist.number-1}">이전</a>

	</c:if>          
		<c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
			<c:choose>
				<c:when test="${postlist.pageable.pageNumber+1 == i}">
					
					<a class="current-page" href="?page=${i-1}">${i}</a>
					
				</c:when>
				<c:otherwise>
					
					<a class="page-link" href="?page=${i-1}">${i}</a>
					
				</c:otherwise>
			</c:choose>
		</c:forEach>

	
	<c:if test="${!postlist.last}">

		<a href="?page=${postlist.number+1}">다음</a>

	</c:if>

                        	<!--  
                        	<script>
                        	function change_page(num)
                        	{
                        		var cur = document.getElementById("current_num").value;
                        		//console.log(cur);
                        		document.getElementById("current_"+cur).style.display = "none";
                        		document.getElementById("noncurrent_"+cur).style.display = "inline-block";
                        		document.getElementById("current_"+num).style.display = "inline-block";
                        		document.getElementById("noncurrent_"+num).style.display = "none";
                        		
                        		document.getElementById("current_num").value = num;
                        		
                        		
                        		
	                        	$.ajax({
	                        		async:true,
	                        		type: 'get',
	                        		dataType: "json",
	                        		url: '/showBoard/'+num,
	                        		success: function(postlist) {    
	                        			//alert(id);
	                        			//alert(show);
	                        			
	                        			alert(postlist);
	                        			alert(`${secondpost}`);
	                        		},
	                        		error: function(){
	                        			alert("failed");
	                        		}
	                        		
	                        		
	                        	});
                        	}
                        	</script>
                        	-->
                        	<a href="#"><i class="fa fa-angle-double-right"></i></a>
                   		</div>
                   		

	</div>
</body>
</html>