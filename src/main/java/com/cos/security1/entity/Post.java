package com.cos.security1.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;

//자료실
@Data
@Entity
public class Post {

	@Id
	@GeneratedValue
	private Long id; //(번호)
	
	@Column
	private String postType;
	
	@Column
	private String specificType;
	
	
	
	@CreationTimestamp
	private Timestamp createDate;
	
	@Column
	private String title;
	



	@Column
	private String pdfLink;
	@Column
	private String hwpLink;
	
	
	
	
	
	public Post(String postType, String specificType, String title, String pdfLink, String hwpLink) {
		super();
		this.postType = postType;
		this.specificType = specificType;
		this.title = title;
		this.pdfLink = pdfLink;
		this.hwpLink = hwpLink;
	}
	
	public Post()
	{
		
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public String getSpecificType() {
		return specificType;
	}
	public void setSpecificType(String specificType) {
		this.specificType = specificType;
	}
	public Timestamp getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPdfLink() {
		return pdfLink;
	}
	public void setPdfLink(String pdfLink) {
		this.pdfLink = pdfLink;
	}
	public String getHwpLink() {
		return hwpLink;
	}
	public void setHwpLink(String hwpLink) {
		this.hwpLink = hwpLink;
	}
	
	
}
