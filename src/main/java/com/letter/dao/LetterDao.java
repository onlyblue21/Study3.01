package com.letter.dao;

import java.util.ArrayList;

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
}
