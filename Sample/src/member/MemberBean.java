package member;

import java.sql.Timestamp;

public class MemberBean {

	
	// private int id int auto_increment, // 자동이라 안해도 될거 같은디?
	private String userid;
	private String userpasswd;
	private String  name;
	private String gender;
	private int  phone;
	private String address;
	private String address2;
	private int session; // 비밀번호 틀린 횟수
	private String exfire; // 계정 만료 여부
	
	
	
	
	
	public String getExfire() {
		return exfire;
	}
	public void setExfire(String exfire) {
		this.exfire = exfire;
	}
	public int getSession() {
		return session;
	}
	public void setSession(int session) {
		this.session = session;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	private String email;
	private Timestamp reg_date ;
	

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpasswd() {
		return userpasswd;
	}
	public void setUserpasswd(String userpasswd) {
		this.userpasswd = userpasswd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
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
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	

}
