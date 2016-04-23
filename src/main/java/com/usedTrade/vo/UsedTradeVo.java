package com.usedTrade.vo;

import java.util.Date;
import java.util.List;

import com.member.vo.MemberVo;

public class UsedTradeVo {
	private int used_trade_seq;
	private int member_seq;// ㄷ시
	private String title;
	private String content;
	private int read_count;
	private String trade_status;
	private String used_trade_type;
	private String location_code;
	private int money;
	private String del_yn;
	private Date reg_date;
	private Date delete_date;
	
	// 조회용 속성
	private String reg_name;

	public int getUsed_trade_seq() {
		return used_trade_seq;
	}

	public void setUsed_trade_seq(int used_trade_seq) {
		this.used_trade_seq = used_trade_seq;
	}

	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRead_count() {
		return read_count;
	}

	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}

	public String getTrade_status() {
		return trade_status;
	}

	public void setTrade_status(String trade_status) {
		this.trade_status = trade_status;
	}

	public String getUsed_trade_type() {
		return used_trade_type;
	}

	public void setUsed_trade_type(String used_trade_type) {
		this.used_trade_type = used_trade_type;
	}

	public String getLocation_code() {
		return location_code;
	}

	public void setLocation_code(String location_code) {
		this.location_code = location_code;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}

	public String getReg_name() {
		return reg_name;
	}

	public void setReg_name(String reg_name) {
		this.reg_name = reg_name;
	}

}
