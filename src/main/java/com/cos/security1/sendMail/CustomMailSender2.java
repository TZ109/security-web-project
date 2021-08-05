package com.cos.security1.sendMail;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import com.cos.security1.entity.Article;
import com.cos.security1.entity.Copyright;

//import org.thymeleaf.context.Context;//쉽지않네
//import org.thymeleaf.spring5.SpringTemplateEngine;

//@Component
@Service
@AllArgsConstructor
public class CustomMailSender2 {
	@Autowired
	 private JavaMailSender mailSender;

	
/*
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private SpringTemplateEngine templateEngine;
	
	public void sendMail() throws MessagingException, IOException {

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
		   
        //메일 제목 설정
        helper.setSubject("스프링 부트 메일 전송");
        //수신자 설정
        helper.setFrom("보낸사람@naver.com");
        helper.setTo("droneprobe@naver.com");
        //템플릿에 전달할 데이터 설정
        Context context = new Context();
        context.setVariable("test_key", "test_value");
        //메일 내용 설정 : 템플릿 프로세스
        String html = templateEngine.process("mail-template",context);
        helper.setText(html, true);
        
        //메일 보내기
        javaMailSender.send(message);
	}*/
	    
	    public void gmailSend(Copyright article,String email, String signedPath) {
	        String user = "teritemp1009@gmail.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
	        String password = "fhzvbzbuwygakqyn";   // 패스워드
	        String content;
	        
	        // SMTP 서버 정보를 설정한다.
	        Properties prop = new Properties();
	        prop.put("mail.smtp.host", "smtp.gmail.com"); 
	        prop.put("mail.smtp.port", 465); 
	        prop.put("mail.smtp.auth", "true"); 
	        prop.put("mail.smtp.ssl.enable", "true"); 
	        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        prop.put("mail.smtp.starttls.enable", "true");
	        prop.put("mail.smtp.ssl.protocols"," TLSv1.2" );
	        
	        //인증을 포함한 메시지
	        //Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() 
	        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(user, password);
	            }
	        });
	       
	        try {
	            MimeMessage message = new MimeMessage(session);
	            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	            
	            
	            message.setFrom(new InternetAddress(user));

	            //수신자메일주소
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); 

	            if(signedPath!=null)
	            {
	            	//MimeBodyPart mbp1 = new MimeBodyPart();
	            	
	            	//System.out.println("메일에 보낼 사인계약서 : "+signedPath +"\n보낸 파일 이름 : "+article.getSer_fileName());
	            	content=build2(article);
	            
	            	messageHelper.setSubject("바로날인 서명완료");
	            	messageHelper.setText(content,true);
	            	/*
	            	FileSystemResource fsr = new FileSystemResource(new File(signedPath));
	            	
	            	try {
						String encordedFilename = URLEncoder.encode(article.getOrig_name(),"UTF-8").replace("+", "%20");
						
						
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	            	
	            	try {
						

						messageHelper.addAttachment(new String(article.getOrig_name().getBytes("UTF-8"), "8859_1"), fsr);
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	            	
	            	messageHelper.addAttachment(article.getOrig_name(), fsr);*/
	            	
	            	//messageHelper.addAttachment(article.getOrig_name(), new File(signedPath));
	            	// Subject
	            	/*
	            	Multipart mp = new MimeMultipart(); 
	            	mp.addBodyPart(mbp1);
	            	message.setContent(mp);
	            	*/
	            	
	            	
	            	//message.setSubject("바로날인 서명완료"); //메일 제목을 입력
	            }
	            else
	            {
	            	// Subject
	            	message.setSubject("바로날인 서명"); //메일 제목을 입력
	            	content = build(article);
	            	message.setText(content, "utf-8", "html");
	            }


	           // MimeBodyPart messageBodyPart = new MimeBodyPart();
	           
	            
	            
	            // Text
	            //message.setText("내용을 입력하세요");    //메일 내용을 입력

	            // send the message
	            Transport.send(message); ////전송
	            System.out.println("message sent successfully...");
	        } catch (AddressException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (MessagingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }


	    private String build(Copyright article)
	    {
	    	//Context context = new Context();
	    	//context.setVariable("text", context);
	    	

	    	String temp= "<!DOCTYPE html>\n"
					+ "<html lang=\"ko\">\n"
					+ "  <head>\n"
					+ "    <meta charset=\"utf-8\">\n"
					+ "    <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">\n"
					+ "  <link href=\"https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap\" rel=\"stylesheet\">\n"
					+ "    <title>서명 확인 메일</title>\n"
					+ "  </head>\n"
					+ "  <body>\n"
					+ "    <div style=\"text-align:center;width:1073px;height:772px;\">\n"
					+ "\n"
					+ "\n"
					+ "    <table style=\"border: 1px solid #444444;border-collapse: collapse;width:1073px;height:772px;text-align:center;\">\n"
					+ "      <tr style=\"height:180px;border: 1px solid #444444;\">\n"
					+ "        <td colspan=\"2\" style=\"border: 1px solid #444444;\">\n"
					+ "        <div class=\"mail-image\">\n"
					+ "          <img style=\"width:49px;height:52px;margin-bottom:10px;\" src=\"https://postfiles.pstatic.net/MjAyMTA1MzBfMTk1/MDAxNjIyMzA5NTk2NzY3.5onXwZcBySinBauScXm-19MtGA5XsUUneN43ZojCCbwg.EU4r4wyg2ScW_Hhjv7G_wiayC93_MJ1Dx5WCnBWiH1Yg.PNG.minkisim/x1.png?type=w580\" alt=\"메일 이미지\">\n"
					+ "        </div>\n"
					+ "        <div class=\"title\" style=\"width:1073px;font: normal normal normal 28px/37px Noto Sans KR;\">\n"
					+ article.getPapername().substring(article.getPapername().indexOf("_")+1) + "          \n"
					+ "        </div>\n"
					+ "      </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"border: 1px solid #444444;height:128px;font: normal normal normal 28px/37px Noto Sans KR;\">\n"
					+ "        <td colspan=\"2\" style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 24px/32px Noto Sans KR;\">\n"
					+ "          서명할 차례입니다.\n"
					+ "          </div>\n"
					+ "        <div style=\"font: normal normal normal 24px/32px Noto Sans KR;\">\n"
					+ "          내용 확인 및 서명을 위해 아래 버튼을 클릭하세요.\n"
					+ "        </div>\n"
					+ "      </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:60px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;\">\n"
					+ "            문서 이름\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ article.getOrig_name() + "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:55px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;\">\n"
					+ "            일련번호\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+article.getCreateDate().toString().replaceAll("[^0-9]","")+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:100px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            서명 요청자\n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ "            갑\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ article.getPeople1_name()+"("+article.getPeople1_email()+")"+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:140px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:10px;\">\n";
	    	
	    			
					
					temp = temp+ " \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n";
					
					
					
					temp = temp+ "\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:100px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;\">\n"
					+ "            서명 유효기한\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ "            2021년 6월 29일 22시 34분 51초\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "    </table>\n"
					+ "    </div>\n"
					+ "    <div style=\"text-align:left;margin-top:40px;margin-left:312px;\">\n"
					+"<form target=\"_blank\" action='http://localhost:8090/user/DocumentcheckPage2' method='post'>"
					+ "		<input type='hidden' name='title' value='"+article.getPapername()+"'>"
					+ "		<input type='hidden' name='create_time' value='"+article.getCreateDate()+"'>\""
					+ "<button><img style=\"width: 451px;height: 88px;opacity: 1;\" src=\"https://postfiles.pstatic.net/MjAyMTA1MzBfMTY5/MDAxNjIyMzA5NTkzMTUz.YPoMHSKHBEJdjIOUn3Yo1znz04iNYUWiuio63rMsyFcg.r-bEcMrY1e1YpUlrLmMWgAH35R2szk_BXgCp9OBjoFwg.PNG.minkisim/%EC%84%9C%EB%AA%85%EB%B2%84%ED%8A%BC.png?type=w580\" alt=\"내용확인 및 서명하기 버튼\" loading=\"lazy\"/>"
					+ "</button></form>"
					+ "    </div>\n"
					+ "\n"
					+ "\n"
					+ "\n"
					+ "  </body>\n"
					+ "</html>";
					
					
					return temp;
	    }

	    //서명 완료된 계약서 다운로드 폼
	    private String build2(Copyright article)
	    {
	    	//Context context = new Context();
	    	//context.setVariable("text", context);
			String temp = "<!DOCTYPE html>\n"
					+ "<html lang=\"ko\">\n"
					+ "  <head>\n"
					+ "    <meta charset=\"utf-8\">\n"
					+ "    <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">\n"
					+ "  <link href=\"https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap\" rel=\"stylesheet\">\n"
					+ "    <title>서명 완료 메일</title>\n"
					+ "  </head>\n"
					+ "  <body>\n"
					+ "    <div style=\"text-align:center;width:1070px;height:645px;\">\n"
					+ "\n"
					+ "\n"
					+ "    <table style=\"border: 1px solid #444444;border-collapse: collapse;width:1070px;height:645px;text-align:center;\">\n"
					+ "      <tr style=\"height:175px;border: 1px solid #444444;\">\n"
					+ "        <td colspan=\"2\" style=\"border: 1px solid #444444;\">\n"
					+ "        <div class=\"mail-image\">\n"
					+ "          <img style=\"width:49px;height:52px;margin-bottom:10px;\"\n"
					+ "          src=\"https://postfiles.pstatic.net/MjAyMTA2MjlfMjk1/MDAxNjI0OTMyNDI3NDg1.ARmiWqay7cmAl5Q5Y_GdMVN6VLB7nXnmqSqlON4PFl4g.eiaT0nq1inno9Pr_kqFMAneTpafwakahcSxh5TzYYeIg.PNG.minkisim/%EC%84%9C%EB%AA%85%EC%99%84%EB%A3%8C.png?type=w580\"\n"
					+ "          alt=\"메일 이미지\">\n"
					+ "        </div>\n"
					+ "        <div class=\"title\" style=\"width:1073px;font: normal normal normal 28px/37px Noto Sans KR;\">\n"
					+ article.getPapername().substring(article.getPapername().indexOf("_")+1) + "          \n"
					+ "        </div>\n"
					+ "      </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"border: 1px solid #444444;height:150px;font: normal normal normal 28px/37px Noto Sans KR;\">\n"
					+ "        <td colspan=\"2\" style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 24px/32px Noto Sans KR;\">\n"
					+ "          서명이 승인되었습니다.\n"
					+ "          </div>\n"
					+ "        <div style=\"font: normal normal normal 24px/32px Noto Sans KR;\">\n"
					+ "          서명 완료된 문서 확인은 아래 버튼을 클릭하세요.\n"
					+ "        </div>\n"
					+ "      </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:60px;border: 1px solid #444444;\">\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;\">\n"
					+ "            문서 이름\n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ article.getOrig_name()+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "      <tr style=\"height:260px;border: 1px solid #444444;\">\n"
					+ "        <td>\n"
					+ "          <div style=\"font: normal normal bold 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            갑\n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:10px;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n"
					+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "        <td style=\"border: 1px solid #444444;text-align:center;\">\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:13px;\">\n"
					+ article.getPeople1_name()+"("+article.getPeople1_email()+")"+ "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;margin-bottom:13px;\">\n";
					
					
					
					temp = temp + "            \n"
					+ "          </div>\n"
					+ "          <div style=\"font: normal normal normal 16px/21px Noto Sans KR;\">\n";
					
					
					
					temp = temp+ "            \n"
					+ "          </div>\n"
					+ "        </td>\n"
					+ "      </tr>\n"
					+ "    </table>\n"
					+ "    </div>\n"
					+ "    <div style=\"text-align:left;margin-top:40px;margin-left:312px;\">\n"
					
					+ "    <form action='http://baronarin.com/user/copyrightcomplete' method=\"post\" >\n"
	
					+ "	<input type=\"hidden\" name=\"serialnum\" value='"+article.getUniquenum()+"'>\n"
					+ "     <button> <img style=\"width:451px;height:88px;\" src=\"https://postfiles.pstatic.net/MjAyMTA2MjlfNzgg/MDAxNjI0OTMyOTgyNDQy.vluQ7qLU8IyOsGaXWWGNhQJq05Oov5uM393LdzcqIskg.DXVqmC7wVJWaoqHvvG9Z5FOFfvmyAPFueG2JfUq5r0Mg.PNG.minkisim/%EA%B7%B8%EB%A3%B9_967.png?type=w580\"\n"
					+ "      alt=\"완료문서 확인하기 버튼\"></button>\n"
					+ "										</form>\n               "
					+ "    </div>\n"
					+ "\n"
					+ "\n"
					+ "\n"
					+ "  </body>\n"
					+ "</html>\n"
					+ "";
			
			return temp;
			
					
	    }
}
	/*
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Async
	public void sendMail(String email) {
		SimpleMailMessage simpleMessage = new SimpleMailMessage();
		simpleMessage.setFrom("보낸사람@naver.com"); // NAVER, DAUM, NATE일 경우 넣어줘야 함
		simpleMessage.setTo(email);
		simpleMessage.setSubject("이메일 인증 테스트");
		simpleMessage.setText("인증번호: 123456");
		javaMailSender.send(simpleMessage);
	}*/

