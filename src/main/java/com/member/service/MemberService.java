package com.member.service;

import java.util.ArrayList;

import com.member.vo.MemberVo;

public interface MemberService {
	
	//회원 가입
	public int memberjoin(MemberVo membervo) throws Exception;
	
	//로그인
	public boolean Login(MemberVo membervo) throws Exception;
	
	//회원 프로필사진
	public int memberphoto(MemberVo membervo) throws Exception;
	
	//
	public ArrayList<MemberVo> ajaxseelct(String type, String value) throws Exception;
	
	//멤버정보
	public ArrayList<MemberVo> memberInfo(MemberVo membervo) throws Exception;
	
	//중복아이디 체크
	public boolean checkId(String userId) throws Exception;
	
	//회원탈퇴 처리
	public void memberUpdate(String userId) throws Exception;
	
	//탈퇴회원 체크
	public boolean memberLeave(MemberVo membervo) throws Exception;
	
}
