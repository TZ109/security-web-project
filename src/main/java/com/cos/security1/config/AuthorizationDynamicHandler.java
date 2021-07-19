package com.cos.security1.config;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import com.cos.security1.config.auth.PrincipalDetails;

@Component
public class AuthorizationDynamicHandler {

	public boolean isAuthorization(HttpServletRequest request, Authentication authentication)
	{
		Object principal = authentication.getPrincipal();
		
		if(principal == null || !(principal instanceof PrincipalDetails))
		{
			return false;
		}
		
		PrincipalDetails userDetail = (PrincipalDetails) principal;
		
		System.out.println("사용자 권한 : "+userDetail.getAuthorities());
		
		Iterator<? extends GrantedAuthority> authorities = userDetail.getAuthorities().iterator();
		
		while(authorities.hasNext()) {
			GrantedAuthority authoritu = authorities.next();
			
			if(!"ROLE_ADMIN".equals(authoritu.getAuthority()))
			{
				return false;
			}
		}
		
		return true;
		
	}
}
