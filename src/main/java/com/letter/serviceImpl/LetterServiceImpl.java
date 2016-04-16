package com.letter.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.letter.dao.LetterDao;
import com.letter.service.LetterService;
import com.letter.vo.LetterVo;

@Service("LetterService")
public class LetterServiceImpl implements LetterService {
	
	@Resource
	private LetterDao letterDao;
	
	@Override
	public ArrayList<LetterVo> letterList() throws Exception {
		return letterDao.letterList();
	}
/*	@Override
	public ArrayList<LetterVo> letterList(String type, String value) throws Exception {
		Map<String, String> key = new HashMap<String, String>();
		key.put("type", type);
		key.put("value", value);
		return letterDao.letterList(key);
	}*/
	public ArrayList<LetterVo> letterList(String type, String value) throws Exception {
		Map<String, String> key = new HashMap<String, String>();
		key.put("type", type);
		key.put("value", value);
		return letterDao.letterList(key);
	}	
	@Override
	public int letterWrite(LetterVo vo) throws Exception {
		return letterDao.letterWrite(vo);
	}

	@Override
	public LetterVo letterSelect(int seq) throws Exception {
		return letterDao.letterSelect(seq);
	}


	
}
