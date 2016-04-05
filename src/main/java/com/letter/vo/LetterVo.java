package com.letter.vo;

import java.util.Date;

public class LetterVo {
	private String letter_seq;
	private String recipient_seq;
	private String sender_seq;
	private String content;
	private String insert_date;
	private String check_yn;
	private String check_date;
	private String del_yn;
	
	public LetterVo() {
		super();
		System.out.println("Create Vo");
	}

	public String getLetter_seq() {
		return letter_seq;
	}

	public void setLetter_seq(String letter_seq) {
		this.letter_seq = letter_seq;
	}

	public String getRecipient_seq() {
		return recipient_seq;
	}

	public void setRecipient_seq(String recipient_seq) {
		this.recipient_seq = recipient_seq;
	}

	public String getSender_seq() {
		return sender_seq;
	}

	public void setSender_seq(String sender_seq) {
		this.sender_seq = sender_seq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getInsert_date() {
		return insert_date;
	}

	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}

	public String getCheck_yn() {
		return check_yn;
	}

	public void setCheck_yn(String check_yn) {
		this.check_yn = check_yn;
	}

	public String getCheck_date() {
		return check_date;
	}

	public void setCheck_date(String check_date) {
		this.check_date = check_date;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	@Override
	public String toString() {
		return " {letter_seq:" + letter_seq + ", recipient_seq:" + recipient_seq + ", sender_seq:" + sender_seq
				+ ", content:" + content + ", insert_date:" + insert_date + ", check_yn:" + check_yn + ", check_date:"
				+ check_date + ", del_yn:" + del_yn + "}";
	}

	
}
