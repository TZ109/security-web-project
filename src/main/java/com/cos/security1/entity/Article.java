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
public class Article {


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
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String people1_encrypt; //(서명 1 암호문) - 처음에는 NULL 서명자가 싸인하면 암호문 
	
	private String people2_num; // (서명 2 IDCODE)
	private String people2_name; //(서명 2 이름)
	private String people2_sign; //(서명 2 서명 여부)
	private String people2_email; //(서명 2 이메일)
	private String people2_signname;
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String people2_encrypt; //(서명 2 암호문)
	
	private String people3_num; // (서명 3 IDCODE)
	private String people3_name; //(서명 3 이름)
	private String people3_sign; //(서명 3 서명 여부)
	private String people3_email; //(서명 3 이메일)
	private String people3_signname;
	
	@Column(columnDefinition = "TEXT",length=1000)//text 길이는 1000
	private String people3_encrypt; //(서명 3 암호문)


	
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
	private int sign2_xpos;
	
	@Column
	private int sign2_ypos;
	
	@Column
	private int sign3_xpos;
	
	@Column
	private int sign3_ypos;
	
	
	
	
	public String getOrig_papername() {
		return orig_papername;
	}

	public void setOrig_papername(String orig_papername) {
		this.orig_papername = orig_papername;
	}

	public int getSign_count() {
		return sign_count;
	}

	public void setSign_count(int sign_count) {
		this.sign_count = sign_count;
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

	public int getSign2_xpos() {
		return sign2_xpos;
	}

	public void setSign2_xpos(int sign2_xpos) {
		this.sign2_xpos = sign2_xpos;
	}

	public int getSign2_ypos() {
		return sign2_ypos;
	}

	public void setSign2_ypos(int sign2_ypos) {
		this.sign2_ypos = sign2_ypos;
	}

	public int getSign3_xpos() {
		return sign3_xpos;
	}

	public void setSign3_xpos(int sign3_xpos) {
		this.sign3_xpos = sign3_xpos;
	}

	public int getSign3_ypos() {
		return sign3_ypos;
	}

	public void setSign3_ypos(int sign3_ypos) {
		this.sign3_ypos = sign3_ypos;
	}

	public String getPeople1_signname() {
		return people1_signname;
	}

	public void setPeople1_signname(String people1_signname) {
		this.people1_signname = people1_signname;
	}

	public String getPeople2_signname() {
		return people2_signname;
	}

	public void setPeople2_signname(String people2_signname) {
		this.people2_signname = people2_signname;
	}

	public String getPeople3_signname() {
		return people3_signname;
	}

	public void setPeople3_signname(String people3_signname) {
		this.people3_signname = people3_signname;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
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

	public int getPeople_size() {
		return people_size;
	}

	public void setPeople_size(int people_size) {
		this.people_size = people_size;
	}

	public String getPeople1_name() {
		return people1_name;
	}

	public void setPeople1_name(String people1_name) {
		this.people1_name = people1_name;
	}

	public String getPeople1_email() {
		return people1_email;
	}

	public void setPeople1_email(String people1_email) {
		this.people1_email = people1_email;
	}

	public String getPeople2_name() {
		return people2_name;
	}

	public void setPeople2_name(String people2_name) {
		this.people2_name = people2_name;
	}

	public String getPeople2_email() {
		return people2_email;
	}

	public void setPeople2_email(String people2_email) {
		this.people2_email = people2_email;
	}


	public String getUniquenum() {
		return uniquenum;
	}

	public void setUniquenum(String uniquenum) {
		this.uniquenum = uniquenum;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPapername() {
		return papername;
	}

	public void setPapername(String papername) {
		this.papername = papername;
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


	public String getPeople1_sign() {
		return people1_sign;
	}

	public void setPeople1_sign(String people1_sign) {
		this.people1_sign = people1_sign;
	}


	public String getPeople1_encrypt() {
		return people1_encrypt;
	}

	public void setPeople1_encrypt(String people1_encrypt) {
		this.people1_encrypt = people1_encrypt;
	}

	public String getPeople2_num() {
		return people2_num;
	}

	public void setPeople2_num(String people2_num) {
		this.people2_num = people2_num;
	}


	public String getPeople2_sign() {
		return people2_sign;
	}

	public void setPeople2_sign(String people2_sign) {
		this.people2_sign = people2_sign;
	}



	public String getPeople2_encrypt() {
		return people2_encrypt;
	}

	public void setPeople2_encrypt(String people2_encrypt) {
		this.people2_encrypt = people2_encrypt;
	}

	public String getPeople3_num() {
		return people3_num;
	}

	public void setPeople3_num(String people3_num) {
		this.people3_num = people3_num;
	}

	public String getPeople3_name() {
		return people3_name;
	}

	public void setPeople3_name(String people3_name) {
		this.people3_name = people3_name;
	}

	public String getPeople3_sign() {
		return people3_sign;
	}

	public void setPeople3_sign(String people3_sign) {
		this.people3_sign = people3_sign;
	}

	public String getPeople3_email() {
		return people3_email;
	}

	public void setPeople3_email(String people3_email) {
		this.people3_email = people3_email;
	}

	public String getPeople3_encrypt() {
		return people3_encrypt;
	}

	public void setPeople3_encrypt(String people3_encrypt) {
		this.people3_encrypt = people3_encrypt;
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

	public Article(Long id, String x, String y) {
		super();
		this.id = id;
		this.x = x;
		this.y = y;
	}
	
	public Article() {
	}

	
}
