package com.cos.security1.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


//문의사항
@Data
@Entity
public class CostomerCenter {
	

	

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id; //(번호)

	
	@Column
	private String title;
	
	@CreationTimestamp
	private Timestamp createDate;
	
	@Column(columnDefinition = "TEXT",length=1000)
	private String textbody;
	
	@Column
	private String username;
	
	@Column
	private String realname;
	
	@Column
	private String hierachyUrl;
	
	
	@Column
	private String secretcheck;
	
	@Column
	private String secretpassword;

	
	@Column
	private String filename;
	
	@Column
	private String server_filename;
	
	@Column(columnDefinition = "TEXT",length=1000)
	private String admincomment;
	
	public CostomerCenter(String title, String textbody, String username, String realname, String hierachyUrl,String secretcheck, String secretpassword, String filename, String server_filename) {

		this.title = title;
		this.textbody = textbody;
		this.username = username;
		this.realname = realname;
		this.hierachyUrl = hierachyUrl;
		this.secretcheck = secretcheck;
		this.secretpassword = secretpassword;
		this.filename = filename;
		this.server_filename = server_filename;
	}
	
	
	public CostomerCenter()
	{
		
	}
	
	
	
	


	public String getAdmincomment() {
		return admincomment;
	}


	public void setAdmincomment(String admincomment) {
		this.admincomment = admincomment;
	}


	public String getRealname() {
		return realname;
	}


	public void setRealname(String realname) {
		this.realname = realname;
	}


	public String getTextbody() {
		return textbody;
	}


	public void setTextbody(String textbody) {
		this.textbody = textbody;
	}


	public String getServer_filename() {
		return server_filename;
	}


	public void setServer_filename(String server_filename) {
		this.server_filename = server_filename;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getHierachyUrl() {
		return hierachyUrl;
	}

	public void setHierachyUrl(String hierachyUrl) {
		this.hierachyUrl = hierachyUrl;
	}



	public String getSecretcheck() {
		return secretcheck;
	}


	public void setSecretcheck(String secretcheck) {
		this.secretcheck = secretcheck;
	}


	public String getSecretpassword() {
		return secretpassword;
	}


	public void setSecretpassword(String secretpassword) {
		this.secretpassword = secretpassword;
	}


	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

}
