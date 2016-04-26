package com.develop.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.develop.dao.DevelopDao;
import com.develop.service.DevelopService;
import com.develop.vo.DevelopVo;

@Service
@Transactional(rollbackFor = Exception.class)
public class DevelopServiceImpl implements DevelopService{
	@Autowired
	private DevelopDao developDao;
	
	@Override
	public List<DevelopVo> selectDevelopList(DevelopVo developVo){
		return developDao.selectList(developVo);
	}
	
	@Override
	public DevelopVo selectDevelopByDevelopSeq(DevelopVo developVo){
		return developDao.selectOne(developVo);
	}
	
	@Override
	public DevelopVo selectDevelop(DevelopVo developVo){
		return developDao.selectDevelop(developVo);
	}
	
	@Override
	public int updateDevelop(DevelopVo developVo){
		return developDao.update(developVo);
	}
	
	@Override
	public int insertDevelop(DevelopVo developVo){
		return developDao.insert(developVo);
	}
	
	@Override
	public int updateReadCount(DevelopVo developVo){
		return developDao.updateReadCount(developVo);
	}
	
	@Override
	public int deleteDevelop(DevelopVo developVo){
		return developDao.delete(developVo);
	}
}
