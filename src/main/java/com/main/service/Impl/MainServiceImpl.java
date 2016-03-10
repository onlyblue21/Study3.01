package com.main.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.main.dao.MainDao;
import com.main.service.MainService;
import com.main.vo.MainVo;

@Service("MainService")
public class MainServiceImpl implements MainService{
	
	@Resource
	private MainDao maindao;
	
	@Override
	public boolean Login(MainVo mainvo) throws Exception {
		return maindao.Login(mainvo);
	}
	
	
}
