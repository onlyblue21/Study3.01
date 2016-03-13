package com.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.member.vo.MemberVo;

@Repository("MemberDao")
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int memberjoin(MemberVo membervo) throws Exception{
		
		return sqlSession.insert("memberjoin", membervo);
	}
	
	public boolean Login(MemberVo membervo) throws Exception{
		int x = sqlSession.selectOne("Login", membervo);
		System.out.println("x=" + x);
		return x < 1 ? false : true;
	}
	
}
