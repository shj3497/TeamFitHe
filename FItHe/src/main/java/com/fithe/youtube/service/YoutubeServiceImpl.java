package com.fithe.youtube.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.youtube.dao.YoutubeDAO;
import com.fithe.youtube.vo.YoutubeVO;

@Service
@Transactional
public class YoutubeServiceImpl implements YoutubeService {
	private Logger logger = Logger.getLogger(YoutubeServiceImpl.class);
	
	private YoutubeDAO youtubeDAO;
	
	@Autowired(required=false)
	public YoutubeServiceImpl(YoutubeDAO youtubeDAO) {
		this.youtubeDAO = youtubeDAO;
	}
	
	@Override
	public int youtubeInsert(YoutubeVO yvo) {
		// TODO Auto-generated method stub
		logger.info("YoutubeServiceImpl youtubeInsert함수");
		return youtubeDAO.youtubeInsert(yvo);
	}

	@Override
	public List<YoutubeVO> youtubeSelect(String yid) {
		// TODO Auto-generated method stub
		logger.info("YoutubeServiceImpl youtubeSelect함수");
		return youtubeDAO.youtubeSelect(yid);
	}

	@Override
	public int youtubeUpdate(YoutubeVO yvo) {
		// TODO Auto-generated method stub
		logger.info("YoutubeServiceImpl youtubeUpdate함수");
		return youtubeDAO.youtubeUpdate(yvo);
	}

}
