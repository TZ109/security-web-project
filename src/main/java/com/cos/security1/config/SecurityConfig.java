package com.cos.security1.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.WebSecurityConfigurer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.cos.security1.config.auth.PrincipalDetailsService;

//import com.cos.security1.config.oauth.PrincipalOauth2UserService;


@Configuration //메모리에 떠야함
@EnableWebSecurity// 활성화, 스프링 시큐리티 필터가 스프링 필터체인에 등록됨
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	//@Autowired
	//private PrincipalOauth2UserService principalOauth2UserService;

	
	@Bean//해당 메소드의 리턴되는 오브젝트를 IOC로 등록
	public BCryptPasswordEncoder encodePwd()
	{
		return new BCryptPasswordEncoder();
	}
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{
		
		
		http.headers().frameOptions().sameOrigin();
		http.csrf().disable();
		
		http.authorizeRequests()
			.antMatchers("/user/**").authenticated()// /로 들어오는 건 놔두고 user로 들어오면 인증이 필요하다 요구
			.antMatchers("/manager/**").access("hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')")//권한 요구
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
			.anyRequest().permitAll()//나머지 주소는 권한 허용
			
			
			.and()
			.formLogin()
			.loginPage("/loginForm")//인증이 요구되는 주소일 때, 로그인 창으로 이동
			
			
			.loginProcessingUrl("/login")// /login 주소가 호출시 시큐리티가 낚아채서 대신 로그인 진행
			.defaultSuccessUrl("/")//메인 페이지로 이동
			.successHandler(new UserLoginSuccessHandler())
			
			.and()
			.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/");
			
			/*
			.and()
			.oauth2Login()
			.loginPage("/loginForm")//구글 로그인 이후 후처리 필요, 구글로 부터 코드받음,
			//엑세스토큰을 코드로 부터 받음 - > 사용자 프로필 정보 가져옴,
			//그 정보를 토대로 회원가입 자동진행 or 해당 정보가 모자랄 경우
			
			//TIP) 구글 로그인 완료시 엑세스토큰 + 사용자 프로필정보를 획득
			.userInfoEndpoint()
			.userService(principalOauth2UserService);
			*/
			
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception 
	{
		 web.ignoring().antMatchers("/css", "/js");
	}
}
