<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 



<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

<img src="<spring:url value = '/image/sign.png'/>" name="imagename"><br/>
<a target="_blank" href="<spring:url value = '/pdfview/testview'/>">pdf띄우기</a>


<form action="/pdfview/testview" method="get">
	<input type="file" name="imagename" value="testview.pdf" onchange="FiletoImg(this.files)">
	<button>파일받기</button>
</form>

<script type="text/javascript">
alert('test');

		
		
			$.ajax({
				url: "/pdfdown/testview.pdf",
				//data: JSON.stringify(jsonData),
				dataType: 'json',
				method: "GET",
				async : true, 
				contentType: "application/json; charset=UTF-8",
					// dataType: "application/vnd.ms-excel",
				//beforeSend : function(xhr){
				//xhr.setRequestHeader("Authorization", window.localStorage['accessToken']);
					// xhr.setRequestHeader("Content-type","application/octet-stream");
					// xhr.setRequestHeader("Accept","application/octet-stream");
				//},
				
				success: function(file){//data, status, xhr) {
				//var filename = xhr.getResponseHeader("X-Filename");
				//var _blob = new Blob([data], {type : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'});
				//var link = document.createElement('a');
				//link.href = window.URL.createObjectURL(_blob);
						// link.download = 'text.xlsx';
				//link.download = filename;
				//link.click();
				alert("성공");
				FiletoImg(file);
				},
				
				
				error: function() {
					alert('실패');
					}
				
				
				});
	
						// onchange="FiletoImg(this.files)" window.onload=
						//문서를 이미지로 불러오고, img의 src가 img_source에 저장되고 fisrt canvas에 저장됨
				//function click_inputfile(target){
				//var inputfile = document.getElementById("inputfile").click();
					//	}

				function FiletoImg(files){
				
				
				alert("파일등록됨");
				//var  files =fso.OpenTextFile($('#imgName').val(), 1, true);
				
			
				
				
				
				
				max_index = files.length;
				for(var i = 0; i<files.length; i++){
					imgs[i] = files[i]; //imgs에 file로 저장
					img_source[i] = new Image();
					save_src(imgs[i],i);
				}

				var file = files[0];
				if (!file.type.match(/image.*/) && !file.type.match(/application.pdf/)) {
					alert("not image of pdf file!");
								}
				else if(file.type.match(/image.*/)){
						document.getElementById("input").style.background="#e8eaef";
						document.getElementById("input").disabled ='disabled';
						document.getElementById("init").style.display = "block";
										show_init();
										document.getElementById("black_information_div").style.display = "block";
					var reader = new FileReader();
					reader.onload = function(e) {
						var img = new Image();
						img.onload = function(){
							var ctx0 = document.getElementById("first").getContext("2d");
							ctx0.drawImage(img, 0, 0, ctx0.canvas.width,ctx0.canvas.height);
						}
					img.src = e.target.result;
					}
					reader.readAsDataURL(file);
				}
            }

            //FiletoImg에 필요함
            function save_src(image, i){
				var reader = new FileReader();
				reader.readAsDataURL(image);
				reader.onload = function(e){
					if(image.type.match(/image.*/)){
                        //if file is jpg
						console.log("file is jpg");
						img_source[i].src = e.target.result;
					}
					//if file is jpg end
					else if(image.type.match(/application.pdf/)){
                        //if file is pdf
                        var canvas = document.getElementById('first');
                        var ctx = canvas.getContext('2d');

                        ctx.font = '60px';
                        ctx.textAlign = 'center';
                        ctx.fillText("로딩중입니다 잠시만 기다려 주세요", ctx.canvas.width/2, 20);

						console.log("file is pdf");

						document.getElementById("input").disabled ='disabled';
						document.getElementById("init").style.display = "block";

                        pdf_url = e.target.result;
                        get_pdf_pages_num();
                    }
				}
            }

            async function get_pdf_pages_num(){
				// Loaded via <script> tag, create shortcut to access PDF.js exports.
				var pdfjsLib = window['pdfjs-dist/build/pdf'];

				// The workerSrc property shall be specified.
				pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';

				// Asynchronous download of PDF
				var loadingTask = pdfjsLib.getDocument(pdf_url);
			    loadingTask.promise.then(async function(pdf){
			        console.log('PDF numpages loaded');
                    max_index = pdf.numPages;
                    console.log(max_index);
                    console.log("show_pdf start");
                    var flag = 0;
                    for(cur = 0; cur<max_index; cur++){
			            //show_pdf();
                        if(flag == 1){
                            cur = 0;
                            break;
                        }
                        img_source[cur] = new Image();
                        var loadingTask = pdfjsLib.getDocument(pdf_url);
                        loadingTask.promise.then(async function(pdf) {
                            console.log(pdf);
                            console.log("cur is");
                            console.log(cur);
                            console.log('PDF loaded');
                            // Fetch the first page
                            var pageNumber = cur+1;
                            console.log("pageNumber is");
                            console.log(pageNumber);

                            pdf.getPage(pageNumber).then(async function(page) {
                                console.log('Page loaded');
                                var scale = 1;
                                var viewport = page.getViewport({scale: scale});

                                scale = 1122/viewport.height;
                                viewport = page.getViewport({scale: scale});
                                console.log(viewport);

                                // Prepare canvas using PDF page dimensions
                                document.getElementById("download_div").style.visibility = "visible";
                                var canvas = document.getElementById('download_test');
                                var context = canvas.getContext('2d');

                                // Render PDF page into canvas context
                                var renderContext = {
                                  canvasContext: context,
                                  viewport: viewport
                                };
                                var renderTask = page.render(renderContext);
                                renderTask.promise.then(async function(){
                                    window.scroll(0,0);
                                    console.log('Page rendered');
                                    html2canvas($("#download_div")[0],{width:document.getElementById("download_test").width, scale:1}).then(async function(canvas){
                                        var myImage = canvas.toDataURL("image/jpeg", 1.0);
                                        console.log("page number is");
                                        console.log(pageNumber);
                                        console.log("page is");
                                        console.log(page);
                                        console.log("my Image is");
                                        console.log(myImage);
                                        saveloadURI(myImage);

                                        if(cur >= max_index - 1){
                                            flag = 1;
                                            cur = 0;
                                            console.log("cur is end");
                                            show_init();
                                            document.getElementById("black_information_div").style.display = "block";
                                            var canvas = document.getElementById('first');
                                            var ctx = canvas.getContext('2d');
                                            ctx.clearRect(0,0,ctx.canvas.width,ctx.canvas.height);
                                       // var file = img_source[0];
                                            var img = new Image();
                                            img.src = img_source[0].src;
                                            console.log(img);
                                            img.onload = function(){
                                                var ctx0 = document.getElementById("first").getContext("2d");
                                                ctx0.drawImage(img, 0, 0, ctx0.canvas.width,ctx0.canvas.height);
                                            }
                                        }

                                    });
                                });
                            });
                        }, function (reason) {
                            // PDF loading error
                            console.error(reason);
                        });
                        await timer(1000);
                    }
                });
            };

						FiletoImg(file_test);
        </script>
        
        
        
</body>
</html>