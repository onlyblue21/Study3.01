package com.develop.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.develop.vo.DevelopVo;

@Repository("DevelopDao")
public class DevelopDao {
	@Resource
	private SqlSession sqlSession;
	
	public List<DevelopVo> selectList(DevelopVo developVo){
		return sqlSession.selectList("Develop.selectDevelopList", developVo);
	}

	public DevelopVo selectOne(DevelopVo developVo){
		return sqlSession.selectOne("Develop.selectDevelopByDevelopSeq", developVo);
	}
	
	public DevelopVo selectDevelop(DevelopVo developVo){
		return sqlSession.selectOne("Develop.selectDevelop", developVo);
	}
	
	public int update(DevelopVo developVo){
		return sqlSession.update("Develop.updateDevelop", developVo);
	}
	
	public int insert(DevelopVo developVo){
		return sqlSession.insert("Develop.insertDevelop", developVo);
	}
	
	public int updateReadCount(DevelopVo developVo){
		return sqlSession.update("Develop.updateDevelopReadCount", developVo);
	}
	
	public int delete(DevelopVo developVo){
		return sqlSession.update("Develop.deleteDevelop", developVo);
	}
}
