package com.member.vo;

import java.util.Date;

public class MemberVo {
	 
	  private String id;
	  private String password;
	  private String user_name;
	  private String nick_name;
	  private String access_count = "1";
	  private int level = 1;
	  private long point = 0;
	  private Date insert_date ;
	  private Date drop_out_date;
	  private Date last_update_date;
	  private String email;
	  private String member_status = "P001";
	  private char profile_open_yn;
	  private String phone_num;
	  private String address;
	  private String birth;
	  private char sex;
	  private String fileupload;
	  private String live_nationality;
	  private String city;
	  private String job;
	  private String religion;
	  private String introduction;
	  
	  private Date change_date;
	  private String change_yn;
	  private int member_seq;
	  private int[] memberSeqs;
	  
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public String getAccess_count() {
		return access_count;
	}
	public void setAccess_count(String access_count) {
		this.access_count = access_count;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public long getPoint() {
		return point;
	}
	public void setPoint(long point) {
		this.point = point;
	}
	public Date getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(Date insert_date) {
		this.insert_date = insert_date;
	}
	public Date getDrop_out_date() {
		return drop_out_date;
	}
	public void setDrop_out_date(Date drop_out_date) {
		this.drop_out_date = drop_out_date;
	}
	public Date getLast_update_date() {
		return last_update_date;
	}
	public void setLast_update_date(Date last_update_date) {
		this.last_update_date = last_update_date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMember_status() {
		return member_status;
	}
	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}
	public char getProfile_open_yn() {
		return profile_open_yn;
	}
	public void setProfile_open_yn(char profile_open_yn) {
		this.profile_open_yn = profile_open_yn;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public char getSex() {
		return sex;
	}
	public void setSex(char sex) {
		this.sex = sex;
	}
	public String getFileupload() {
		return fileupload;
	}
	public void setFileupload(String fileupload) {
		this.fileupload = fileupload;
	}
	public String getLive_nationality() {
		return live_nationality;
	}
	public void setLive_nationality(String live_nationality) {
		this.live_nationality = live_nationality;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Date getChange_date() {
		return change_date;
	}
	public void setChange_date(Date change_date) {
		this.change_date = change_date;
	}
	public String getChange_yn() {
		return change_yn;
	}
	public void setChange_yn(String change_yn) {
		this.change_yn = change_yn;
	}

	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public int[] getMemberSeqs(){
        return memberSeqs;
	}
	   
	public void setMemberSeqs(int[] memberSeqs){
	    this.memberSeqs = memberSeqs;
	}
	  	
	  
	  
	  
}


