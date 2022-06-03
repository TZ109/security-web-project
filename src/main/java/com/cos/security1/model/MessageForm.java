package com.cos.security1.model;

import javax.persistence.Column;

import com.cos.security1.entity.Article;
import com.cos.security1.entity.Copyright;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

//계약서 생성에서 가져올 데이터들

//getter setter가 있어야 스프링이 자동으로 연결해줌
public class MessageForm {
	
	@Override
	public String toString() {
		return "MessageForm [title=" + title + ", name1=" + name1 + ", email1=" + email1 + ", name2=" + name2
				+ ", email2=" + email2 + ", name3=" + name3 + ", email3=" + email3 + ", signNum=" + signNum + "]";
	}


	private String title;
	
	private String name1;
	private String email1;
	
	private String name2;
	private String email2;
	
	private String name3;
	private String email3;
	
	//private long z;
	
	private int signNum;

	private String per1[];
	private String per2[];
	private String per3[];
	

	
	

	public String[] getPer1() {
		return per1;
	}

	public void setPer1(String[] per1) {
		this.per1 = per1;
	}

	public String[] getPer2() {
		return per2;
	}

	public void setPer2(String[] per2) {
		this.per2 = per2;
	}

	public String[] getPer3() {
		return per3;
	}

	public void setPer3(String[] per3) {
		this.per3 = per3;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getName3() {
		return name3;
	}

	public void setName3(String name3) {
		this.name3 = name3;
	}

	public String getEmail3() {
		return email3;
	}

	public void setEmail3(String email3) {
		this.email3 = email3;
	}

	public int getSignNum() {
		return signNum;
	}

	public void setSignNum(int signNum) {
		this.signNum = signNum;
	}

	
	public Article toEntity() {
		// TODO Auto-generated method stub
		Article newArticle = new Article();
		
		newArticle.setPapername(title);
		newArticle.setOrig_papername(title);
		newArticle.setPeople1_name(name1);
		newArticle.setPeople1_email(email1);
		
		newArticle.setPeople2_name(name2);
		newArticle.setPeople2_email(email2);
		
		newArticle.setPeople3_name(name3);
		newArticle.setPeople3_email(email3);
		
		newArticle.setPeople_size(signNum);
		
		return newArticle;
		
		
	}
	
	public Copyright toCopyright() {
		Copyright copyright = new Copyright();
		
		copyright.setPapername(title);
		copyright.setOrig_papername(title);
		//copyright.setPeople1_name(name1);
		//copyright.setPeople1_email(email1);

		
		copyright.setPeople_size(1);
		
		return copyright;
	}
	
	
}
