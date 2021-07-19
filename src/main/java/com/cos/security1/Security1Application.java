package com.cos.security1;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import com.cos.security1.file.FileUploadProperties;


//@EnableConfigurationProperties(StorageProperties.class)
@EnableConfigurationProperties(
        {FileUploadProperties.class}
)

@SpringBootApplication
public class Security1Application extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Security1Application.class, args);
		System.out.print("test1 \n"+ org.springframework.core.SpringVersion.getVersion());
		
		
		/*
		 Mail mail = new Mail();
	        mail.setMailFrom("from@gmail.com");
	        mail.setMailTo("terizeto1009gmail.com");
	        mail.setMailSubject("This is Email test.");
	        mail.setMailContent("Learn how to send email using Spring.");
	 
	        AbstractApplicationContext context = new AnnotationConfigApplicationContext(MailConfig.class);
	        MailService mailService = (MailService) context.getBean("mailService");
	        mailService.sendEmail(mail);
	        context.close();
		 */

	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder)
	{ return builder.sources(Security1Application.class);
	}
	/*
	@Bean
	CommandLineRunner init(StorageService storageService)
	{
		return (args) -> {
			storageService.deleteAll();
			storageService.init();
		};
	}
	*/

}
