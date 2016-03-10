package com.letter.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.letter.vo.LetterVo;

@Repository
public class LetterDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<LetterVo> selectLetterList(){
		return sqlSession.selectList("letter.selectLetterList");
	}
}
