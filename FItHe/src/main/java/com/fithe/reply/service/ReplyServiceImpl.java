package com.fithe.reply.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.reply.dao.ReplyDAO;
import com.fithe.reply.vo.ReplyVO;

@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {
Logger logger = Logger.getLogger(ReplyServiceImpl.class);

	@Autowired(required=false)
	private ReplyDAO replyDAO;
	
	@Override
	public List<ReplyVO> replySelectAll(ReplyVO rvo) {
		// TODO Auto-generated method stub
		logger.info("ReplyServiceImpl replySelectAll");
		return replyDAO.replySelectAll(rvo);
	}

	@Override
	public List<ReplyVO> replySelect(ReplyVO rvo) {
		// TODO Auto-generated method stub
		logger.info("ReplyServiceImpl replySelect");
		return replyDAO.replySelect(rvo);
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		// TODO Auto-generated method stub
		logger.info("ReplyServiceImpl replyInsert");
		return replyDAO.replyInsert(rvo);
	}

	@Override
	public int replyDelete(ReplyVO rvo) {
		// TODO Auto-generated method stub
		logger.info("ReplyServiceImpl replyDelete");
		return replyDAO.replyDelete(rvo);
	}

}
