package com.letter.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.letter.vo.LetterVo;

@Repository("LetterDao")
public class LetterDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList<LetterVo> letterList(){
		return (ArrayList)sqlSession.selectList("letterList");
	}
	
/*	public ArrayList letterList(Map<String, String> key){
		return (ArrayList)sqlSession.selectList("letterListSearch", key);
	}
	*/
	public ArrayList<LetterVo> letterList(Map<String, String> key){
		return (ArrayList)sqlSession.selectList("letterListSearch", key);
	}
	public int letterWrite(LetterVo vo){
		return sqlSession.insert("letterWrite", vo);
	}
	
	public LetterVo letterSelect(int letter_seq){
		return sqlSession.selectOne("letterSelect",letter_seq);
	}
}
