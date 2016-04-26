package com.develop.service;

import java.util.List;

import com.develop.vo.DevelopVo;

public interface DevelopService {
	List<DevelopVo> selectDevelopList(DevelopVo developVo);
	
	DevelopVo selectDevelopByDevelopSeq(DevelopVo developVo);
	
	DevelopVo selectDevelop(DevelopVo developVo);
	
	int updateDevelop(DevelopVo developVo);
	
	int insertDevelop(DevelopVo developVo);
	
	int updateReadCount(DevelopVo developVo);
	
	int deleteDevelop(DevelopVo developVo);
}
