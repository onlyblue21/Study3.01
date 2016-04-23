package com.usedTrade.service;

import java.util.List;

import com.usedTrade.vo.UsedTradeVo;

public interface UsedTradeService {
	/**
	 * 중고 거래 등록
	 * @param usedTradeVO
	 * @return
	 * @throws Exception
	 */
	public int writeUsedTrade(UsedTradeVo usedTradeVO) throws Exception;

	/**
	 * 중고 거래 목록
	 * @param page			// 페이지
	 * @param rowsPerPage	// 페이지 당 row 수
	 * @return
	 * @throws Exception
	 */
	public List<UsedTradeVo> listUsedTrade(int page, int rowsPerPage) throws Exception;

	/**
	 * 중고 거래 1개 select
	 * @param used_trade_seq
	 * @return
	 */
	public UsedTradeVo selectUsedTrade(int used_trade_seq) throws Exception;
}
