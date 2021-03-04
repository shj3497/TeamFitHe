package com.fithe.community.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.common.CalculateUtil;
import com.fithe.common.BoardPagingVO;
import com.fithe.community.dao.CommunityDAO;
import com.fithe.community.vo.CommunityVO;

@Service
@Transactional
public class CommunityServiceImpl implements CommunityService {

	private Logger logger = Logger.getLogger(CommunityServiceImpl.class);
	@Autowired(required = false)
	private CommunityDAO communityDAO;
	
	@Override
	public List<CommunityVO> communityList(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityServiceImpl communityList");
		List<CommunityVO> communityList = communityDAO.communityList(pvo);
		communityList = CalculateUtil.getCommunityTimeGAP(communityList);
		return communityList;
	}
	
	@Override
	public int countCommunity(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		return communityDAO.countCommunity(pvo);
	}
	
	@Override
	public int communityInsert(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityServiceImpl communityInsert");
		return communityDAO.communityInsert(cvo);
	}

	@Override
	public CommunityVO communityDetail(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityServiceImpl communityDetail");
		return communityDAO.communityDetail(cvo);
	}

	@Override
	public int communityHit(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return communityDAO.communityHit(cvo);
	}

	@Override
	public int communityUpdate(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityServiceImpl communityUpdate >>>");
		return communityDAO.communityUpdate(cvo);
	}

	@Override
	public int communityDelete(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityServiceImpl communityDelete >>>");
		return communityDAO.communityDelete(cvo);
	}

	@Override
	public CommunityVO communityFileCheck(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return communityDAO.communityFileCheck(cvo);
	}

	@Override
	public int communityFileDelete(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return communityDAO.communityFileDelete(cvo);
	}

}
