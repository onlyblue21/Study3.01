package com.member.dao;

import java.util.ArrayList;
import java.util.Map;

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
	
	public int memberphoto(MemberVo membervo) throws Exception{
		return sqlSession.insert("memberphoto",membervo);
	}
	
	public ArrayList<MemberVo> ajaxseelct(Map<String, String> key){
		return (ArrayList)sqlSession.selectList("ajaxselect", key);
	}
	
	public ArrayList<MemberVo> memberInfo(MemberVo membervo){
		return (ArrayList)sqlSession.selectList("memberInfo", membervo);
	}
	
	public boolean checkId(String userId)throws Exception{
		int checkId =  sqlSession.selectOne("checkId",userId);
		return checkId < 1 ? false : true;
	}
	
	public boolean memberLeave(MemberVo membervo) throws Exception{
		int memberLeave = sqlSession.selectOne("memberLeave", membervo);
		return memberLeave < 1 ? false : true;
	}
	
	public void memberUpdate(String userID) throws Exception{
		sqlSession.update("memberUpdate", userID);
	}
	
	
	
}
