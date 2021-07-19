package com.cos.security1.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.Id;//No identifier specified for entity문제 import가 잘못됨 

import lombok.Data;

import java.sql.Timestamp;




@Data
@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//기본 varchar(255)
	private int id;
	private String realname;
	private String username;//username이 이메일
	private String password;
	//private String email;
	private String role;//ROLE_USER, ROLE_ADMIN
	//private Timestamp loginDate;//로그인 할 때 마다 갱신
	private String signname;//유저 사인 이미지이름
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String publicKey;
	

	

	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String privateKey;
	
	
	private String provider;//google login
	private String providerId;//google-sub
	
	@CreationTimestamp
	private Timestamp createDate;

	
	
	
	public Timestamp getCreateDate() {
		return createDate;
	}

	public String getSignname() {
		return signname;
	}

	public void setSignname(String signname) {
		this.signname = signname;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
/*
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}*/

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
/*


*/


	public String getPrivateKey() {
		return privateKey;
	}

	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}

	public String getPublicKey() {
		return publicKey;
	}

	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}

	
}
