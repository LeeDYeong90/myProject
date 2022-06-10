package member;

import java.sql.Date;

public class MemberDTO {
//	CREATE TABLE member (
//			id VARCHAR(16) PRIMARY KEY,
//			pass VARCHAR(16) NOT NULL,
//			name VARCHAR(20) NOT NULL,
//			date DATETIME NOT NULL,
//			email VARCHAR(50) UNIQUE NOT NULL,
//			mobile VARCHAR(20) NOT NULL,
//			address VARCHAR(50),
//			phone VARCHAR(20));

	private String id;
	private String pass;
	private String name;
	private Date date;
	private String email;
	private String mobile;
	private String address;
	private String phone;
	//db에 들어가는 컬럼명들을 접근제한자 private를 사용하여 멤버변수로 선언
	
	
	public MemberDTO() {
		super();
	} //기본 생성자 생성
	
	//각 멤버변수들에 접근하기 위해 getter/setter를 생성
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	
	@Override
	public String toString() {
		return "memberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", date=" + date + ", email=" + email
				+ ", address=" + address + ", phone=" + phone + ", mobile=" + mobile + "]";
	}
	
	
}
