package com.usedTrade.vo;

import java.util.Date;

public class UsedTradeFileVo {
	/**
	 * file_seq int(9) delete_date del_yn used_trade_seq int
	 */
	private int file_seq;
	private int used_trade_seq;
	private String del_yn;
	private Date delete_date;

	public int getFile_seq() {
		return file_seq;
	}

	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}

	public int getUsed_trade_seq() {
		return used_trade_seq;
	}

	public void setUsed_trade_seq(int used_trade_seq) {
		this.used_trade_seq = used_trade_seq;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public Date getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}

}
