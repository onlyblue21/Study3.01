package com.profile.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.profile.vo.ProfileVo;

@Repository("ProfileDao")
public class ProfileDao {

		@Resource
		private SqlSession sqlSession;
		
		public int memberjoin(ProfileVo profilevo) throws Exception{
			
			return sqlSession.insert("memberjoin", profilevo);
		}
	}

	
