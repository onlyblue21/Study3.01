package com.member.vo;

import java.util.Date;

public class MemberVo {

	private int member_seq;
	private String id;
	private String pw;
	private String nick_name;
	private int user_level;
	private int user_exp;
	private int access_count;
	private int member_point;
	private Date isrt_time;
	private Date drop_out_time;
	private Date last_updt_time;
	private String email;
	private String sts;
	
	
	public Date getDrop_out_time() {
		return drop_out_time;
	}

	public void setDrop_out_time(Date drop_out_time) {
		this.drop_out_time = drop_out_time;
	}

	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}

	public int getUser_level() {
		return user_level;
	}

	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}

	public int getUser_exp() {
		return user_exp;
	}

	public void setUser_exp(int user_exp) {
		this.user_exp = user_exp;
	}

	public int getAccess_count() {
		return access_count;
	}

	public void setAccess_count(int access_count) {
		this.access_count = access_count;
	}

	public int getMember_point() {
		return member_point;
	}

	public void setMember_point(int member_point) {
		this.member_point = member_point;
	}

	public Date getIsrt_time() {
		return isrt_time;
	}

	public void setIsrt_time(Date isrt_time) {
		this.isrt_time = isrt_time;
	}

	public Date getLast_updt_time() {
		return last_updt_time;
	}

	public void setLast_updt_time(Date last_updt_time) {
		this.last_updt_time = last_updt_time;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSts() {
		return sts;
	}

	public void setSts(String sts) {
		this.sts = sts;
	}

	@Override
	public String toString() {
		return "MemberVo [member_seq=" + member_seq + ", id=" + id + ", pw=" + pw + ", nick_name=" + nick_name
				+ ", user_level=" + user_level + ", user_exp=" + user_exp + ", access_count=" + access_count
				+ ", member_point=" + member_point + ", isrt_time=" + isrt_time + ", last_updt_time=" + last_updt_time
				+ ", email=" + email + ", sts=" + sts + "]";
	}

}
