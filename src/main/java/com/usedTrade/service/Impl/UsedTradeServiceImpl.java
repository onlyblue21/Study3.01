package com.usedTrade.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.usedTrade.dao.UsedTradeDAO;
import com.usedTrade.service.UsedTradeService;
import com.usedTrade.vo.UsedTradeVo;

@Service("usedTradeService")
public class UsedTradeServiceImpl implements UsedTradeService {
	@Resource
	UsedTradeDAO usedTradeDAO;

	@Override
	public int writeUsedTrade(UsedTradeVo usedTradeVO) {
		return usedTradeDAO.writeUsedTrade(usedTradeVO);
	}
}
