package com.letter.service;

import java.util.ArrayList;

import com.letter.vo.LetterVo;;

public interface LetterService {

	public ArrayList<LetterVo> letterList() throws Exception;
	public ArrayList<LetterVo> letterList(String type, String value) throws Exception;
	
	public int letterWrite(LetterVo vo) throws Exception;
	public LetterVo letterSelect(int seq) throws Exception;
}
