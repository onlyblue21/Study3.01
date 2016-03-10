package com.letter.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.letter.dao.LetterDao;
import com.letter.vo.LetterVo;

@Service
public class LetterService {
	
	@Autowired
	private LetterDao letterDao;
	
	public List<LetterVo> selectLetterList(){
		return letterDao.selectLetterList();
	}
}
