package com.profile.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.profile.dao.ProfileDao;
import com.profile.service.ProfileService;
import com.profile.vo.ProfileVo;

@Service("ProfileService")
public class ProfileServiceImpl implements ProfileService{
	
	@Resource
	private ProfileDao profiledao;
	
	@Override
	public int memberjoin(ProfileVo profilevo) throws Exception{
		
		return profiledao.memberjoin(profilevo);
	}
	
}
