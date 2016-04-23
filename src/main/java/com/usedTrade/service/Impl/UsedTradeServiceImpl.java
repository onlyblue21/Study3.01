package com.usedTrade.service.Impl;

import java.util.List;

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

	@Override
	public List<UsedTradeVo> listUsedTrade(int page, int rowsPerPage) throws Exception {
		// TODO Auto-generated method stub
		page = (page - 1) * rowsPerPage;
		return usedTradeDAO.listUsedTrade(page, rowsPerPage);
	}
}
