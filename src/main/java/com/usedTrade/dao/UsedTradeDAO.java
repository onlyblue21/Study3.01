package com.usedTrade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.usedTrade.vo.UsedTradeVo;

@Repository("UsedTradeDAO")
public class UsedTradeDAO {
	@Resource
	private SqlSession sqlSession;

	public List<UsedTradeVo> listUsedTrade(int page, int rowsPerPage){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("page", page);
		param.put("rowsPerPage", rowsPerPage);
		//return sqlSession.selectList("listUsedTrade", param);
		return null;
	}
	
	public int writeUsedTrade(UsedTradeVo usedTradeVO) {
		return sqlSession.insert("writeUsedTrade", usedTradeVO);	
	}
}
