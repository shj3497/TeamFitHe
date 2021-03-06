package com.fithe.common.chaebun.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.common.chaebun.dao.ChaebunDAO;
import com.fithe.community.vo.CommunityVO;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.vo.NoticeVO;
import com.fithe.reply.vo.ReplyVO;
import com.fithe.survey.vo.SurveyVO;

@Service
@Transactional
public class ChaebunServiceImpl implements ChaebunService {

	private ChaebunDAO chaebunDAO;
	private Logger logger = Logger.getLogger(ChaebunServiceImpl.class);
	
	@Autowired(required=false)
	public ChaebunServiceImpl(ChaebunDAO chaebunDAO) {
		this.chaebunDAO=chaebunDAO;
	}
	
	@Override
	public MemberVO getChaebun_m() {
		// TODO Auto-generated method stub
		logger.info("(ChaebunServiceImpl) getChaebun_m() 진입");
		
		MemberVO _mvo = null;
		_mvo = chaebunDAO.getChaebun_m();
		
		return _mvo;
	}

	@Override
	public MemberVO getChaebun_a() {
		// TODO Auto-generated method stub
		logger.info("(ChaebunServiceImpl) getChaebun_a() 진입");
		
		MemberVO _mvo = null;
		_mvo = chaebunDAO.getChaebun_a();

		return _mvo;
	}
	
	@Override
	public NoticeVO getNoticeChaebun() {
		// TODO Auto-generated method stub
		return chaebunDAO.getNoticeChaebun();
	}

	@Override
	public CommunityVO getCommunityChaebun() {
		// TODO Auto-generated method stub
		return chaebunDAO.getCommunityChaebun();
	}

	@Override
	public ReplyVO getReplyChaebun() {
		// TODO Auto-generated method stub
		return chaebunDAO.getReplyChaebun();
	}
	
	@Override
	public SurveyVO getSurveyChaebun() {
		// TODO Auto-generated method stub
		return chaebunDAO.getSurveyChaebun();
	}



	
}
