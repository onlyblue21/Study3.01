package com.main.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.main.vo.MainVo;

@Repository("MainDao")
public class MainDao {

	@Resource
	private SqlSession sqlSession;
	
	
	public boolean Login(MainVo mainvo) throws Exception{
		int x = sqlSession.selectOne("Login", mainvo);
		System.out.println("x=" + x);
		return x < 1 ? false : true;
	}
	
	
}
