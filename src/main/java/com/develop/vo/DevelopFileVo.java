package com.develop.vo;

import java.util.Date;

public class DevelopFileVo {
	
	public int getFile_seq() {
		return file_seq;
	}
	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}
	public Date getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public int getDevelop_seq() {
		return develop_seq;
	}
	public void setDevelop_seq(int develop_seq) {
		this.develop_seq = develop_seq;
	}
	private int file_seq;
	private Date delete_date;
	private String del_yn;
	private int develop_seq;
}
