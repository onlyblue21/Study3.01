package com.develop.vo;

import java.util.Date;

public class DevelopFileVo {
	private int fileSeq;
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public Date getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public int getDevelopSeq() {
		return developSeq;
	}
	public void setDevelopSeq(int developSeq) {
		this.developSeq = developSeq;
	}
	private Date deleteDate;
	private String delYn;
	private int developSeq;
}
