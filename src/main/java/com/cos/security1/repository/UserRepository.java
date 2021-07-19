package com.cos.security1.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cos.security1.model.User;




//CRUD함수를 JpaRepository가 들고 있다
//@Repository 어노테이션 없어도 IOC가 됨, 상속했기 떄문
public interface UserRepository extends JpaRepository<User, Integer>{

	//findBy 규칙-> Username문법
	//select * from user where username = 1? 파라미터에 들어온 내용을 넣어줌
	public User findByUsername(String username);
	
	//public User findByEmail(String email);
}
