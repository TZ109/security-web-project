package com.cos.security1.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;

@Data
@Entity
public class Copyright {
	@Id
	@GeneratedValue
	private Long id; //(번호)
	
	//일련번호
	private String uniquenum;
	
	@Column
	private String papername; //(id_계약서 이름)
	private String orig_papername;//계약서 이름
	private int people_size; //(서명 인원) - 이 데이터로 for문 돌림
	private int sign_count;//사인완료한 인원 수
	
	private String file_path;//파일 저장한 경로
	private String ser_fileName;//서버에 저장된 파일 이름
	private String orig_name;//파일 원래 이름
	private long file_size;//파일 크기
	
	
	private String plain_text; //(평문) - 랜덤 생성
	
	private String people1_num; //(서명 1 IDCODE)
	private String people1_name; //(서명 1 이름) - 이름
	private String people1_sign; //(서명 1 서명 여부) - 처음에는 0 해당 서명자가 싸인하면 1
	private String people1_email; //(서명 1 이메일) - 메일
	private String people1_signname;
	private String people1_time;//서명한 시각
	
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String people1_encrypt; //(서명 1 암호문) - 처음에는 NULL 서명자가 싸인하면 암호문 
	
	@Column
	private String x;
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String y;
	
	//등록한 시간
	@CreationTimestamp
	private Timestamp createDate;
	
	@Column
	private int sign1_xpos;
	
	@Column
	private int sign1_ypos;
	
	
	
	
	@Column
	private String result_hash;


	
	public Copyright()
	{
		
	}


	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getUniquenum() {
		return uniquenum;
	}




	public void setUniquenum(String uniquenum) {
		this.uniquenum = uniquenum;
	}




	public String getPapername() {
		return papername;
	}




	public void setPapername(String papername) {
		this.papername = papername;
	}




	public String getOrig_papername() {
		return orig_papername;
	}




	public void setOrig_papername(String orig_papername) {
		this.orig_papername = orig_papername;
	}




	public int getPeople_size() {
		return people_size;
	}




	public void setPeople_size(int people_size) {
		this.people_size = people_size;
	}




	public int getSign_count() {
		return sign_count;
	}




	public void setSign_count(int sign_count) {
		this.sign_count = sign_count;
	}




	public String getFile_path() {
		return file_path;
	}




	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}




	public String getSer_fileName() {
		return ser_fileName;
	}




	public void setSer_fileName(String ser_fileName) {
		this.ser_fileName = ser_fileName;
	}




	public String getOrig_name() {
		return orig_name;
	}




	public void setOrig_name(String orig_name) {
		this.orig_name = orig_name;
	}




	public long getFile_size() {
		return file_size;
	}




	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}




	public String getPlain_text() {
		return plain_text;
	}




	public void setPlain_text(String plain_text) {
		this.plain_text = plain_text;
	}




	public String getPeople1_num() {
		return people1_num;
	}




	public void setPeople1_num(String people1_num) {
		this.people1_num = people1_num;
	}




	public String getPeople1_name() {
		return people1_name;
	}




	public void setPeople1_name(String people1_name) {
		this.people1_name = people1_name;
	}




	public String getPeople1_sign() {
		return people1_sign;
	}




	public void setPeople1_sign(String people1_sign) {
		this.people1_sign = people1_sign;
	}




	public String getPeople1_email() {
		return people1_email;
	}




	public void setPeople1_email(String people1_email) {
		this.people1_email = people1_email;
	}




	public String getPeople1_signname() {
		return people1_signname;
	}




	public void setPeople1_signname(String people1_signname) {
		this.people1_signname = people1_signname;
	}




	public String getPeople1_time() {
		return people1_time;
	}




	public void setPeople1_time(String people1_time) {
		this.people1_time = people1_time;
	}




	public String getPeople1_encrypt() {
		return people1_encrypt;
	}




	public void setPeople1_encrypt(String people1_encrypt) {
		this.people1_encrypt = people1_encrypt;
	}




	public String getX() {
		return x;
	}




	public void setX(String x) {
		this.x = x;
	}




	public String getY() {
		return y;
	}




	public void setY(String y) {
		this.y = y;
	}




	public Timestamp getCreateDate() {
		return createDate;
	}




	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}




	public int getSign1_xpos() {
		return sign1_xpos;
	}




	public void setSign1_xpos(int sign1_xpos) {
		this.sign1_xpos = sign1_xpos;
	}




	public int getSign1_ypos() {
		return sign1_ypos;
	}




	public void setSign1_ypos(int sign1_ypos) {
		this.sign1_ypos = sign1_ypos;
	}




	public String getResult_hash() {
		return result_hash;
	}




	public void setResult_hash(String result_hash) {
		this.result_hash = result_hash;
	}
	
	
	
	

}
