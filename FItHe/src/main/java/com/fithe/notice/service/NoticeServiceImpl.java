package com.fithe.notice.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.common.CalculateUtil;
import com.fithe.common.BoardPagingVO;
import com.fithe.notice.dao.NoticeDAO;
import com.fithe.notice.dao.NoticeDAOImpl;
import com.fithe.notice.vo.NoticeVO;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {
	
	Logger logger = Logger.getLogger(NoticeDAOImpl.class);
	@Autowired(required = false)
	private NoticeDAO noticeDAO;
	
	@Override
	public List<NoticeVO> noticeList(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeServiceImpl noticeList >>>");
		List<NoticeVO> noticeList = noticeDAO.noticeList(pvo);
		// ninsertdate 작성일자 변환 (..시간, ..분 전)
		noticeList = CalculateUtil.getNoticeTimeGAP(noticeList);
		return noticeList;
	}
	
	@Override
	public List<NoticeVO> noticeExposureList() {
		// TODO Auto-generated method stub
		List<NoticeVO> noticeExposureList = noticeDAO.noticeExposureList();
		noticeExposureList = CalculateUtil.getNoticeTimeGAP(noticeExposureList);
		return noticeExposureList;
	}
	
	@Override
	public int countNotice(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		return noticeDAO.countNotice(pvo);
	}
	@Override
	public int noticeInsert(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeServiceImpl noticeInsert >>>");
		return noticeDAO.noticeInsert(nvo);
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeServiceImpl noticeDetail >>>");
		return noticeDAO.noticeDetail(nvo);
	}

	@Override
	public int noticeHit(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return noticeDAO.noticeHit(nvo);
	}

	@Override
	public int noticeUpdate(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeServiceImpl noticeUpdate >>>");
		return noticeDAO.noticeUpdate(nvo);
	}

	@Override
	public int noticeDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeServiceImpl noticeDelete >>>");
		return noticeDAO.noticeDelete(nvo);
	}

	@Override
	public NoticeVO noticeFileCheck(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return noticeDAO.noticeFileCheck(nvo);
	}

	@Override
	public int noticeFileDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return noticeDAO.noticeFileDelete(nvo);
	}

}
