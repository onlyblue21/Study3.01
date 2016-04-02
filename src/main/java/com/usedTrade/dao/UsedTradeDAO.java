package com.usedTrade.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.usedTrade.vo.UsedTradeVo;

@Repository("UsedTradeDAO")
public class UsedTradeDAO {
	@Resource
	private SqlSession sqlSession;

	public int writeUsedTrade(UsedTradeVo usedTradeVO) {
		return sqlSession.insert("writeUsedTrade", usedTradeVO);	
	}
}
