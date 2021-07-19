package com.cos.security1.config.auth;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.cos.security1.model.User;

//시큐리티가 /login을 낚아채서  로그인 진행
//로그인을 진행이 완료가 되면 시큐리티 만의 session을 만들어줌, Security ContextHolder라는 키 값에 저장
//들어갈 수 있는 오브젝트가 정해져 있음 => Authentication 타입 객체
//Authentication 안에 User 정보가 있어야함
//User오브젝트 타입 => UserDetails타입 객체

//Security Session에 정보저장(Authentication 객체로 저장)
//Authentication(User 정보를 Userdetails 객체 형태로 저장)

public class PrincipalDetails implements UserDetails{

	private User user;//콤포지션
	
	public PrincipalDetails(User user) {
		// TODO Auto-generated constructor stub
		this.user = user;
	}
	
	
	//해당 유저의 권한 리턴
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		Collection<GrantedAuthority> collect = new ArrayList<>();
		collect.add(new GrantedAuthority() {
			
			@Override
			public String getAuthority() {
				// TODO Auto-generated method stub
				return user.getRole();//스트링 타입
			}
		});
		
		return null;
	}

	
	
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getUsername();
	}


	public String getRole() {
		// TODO Auto-generated method stub
		return user.getRole();
	}
/*/principal에서 페이지에서 바로 유저정보 꺼내올수 있도록 설정
	public String getEmail() {
		// TODO Auto-generated method stub
		return user.getEmail();
	}*/
	
	public String getPublicKey() {
		// TODO Auto-generated method stub
		return user.getPublicKey();
	}

	
	public String getPrivateKey() {
		// TODO Auto-generated method stub
		return user.getPrivateKey();
	}
	
	public String getRealname()
	{
		return user.getRealname();
	}
	
	public String getSignname()
	{
		return user.getSignname();
	}
	
	
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		//우리 사이트에서 1년 동안 회원이 로그인 안하면 휴먼 계정 전환한다면
		
		//user.getLoginDate()
		//현재시간 - 최근 로그인한 시간 => 1년 초과하면 return false
		return true;
	}

}
