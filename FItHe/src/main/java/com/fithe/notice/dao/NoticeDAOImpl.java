package com.fithe.notice.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.common.BoardPagingVO;
import com.fithe.notice.vo.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	Logger logger = Logger.getLogger(NoticeDAOImpl.class);
	
	@Autowired(required = false)
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<NoticeVO> noticeList(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeDAOImpl noticeList >>> : ");
		return sqlSession.selectList("noticeList", pvo);
	}
	
	@Override
	public List<NoticeVO> noticeExposureList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("noticeExposureList");
	}
	
	@Override
	public int countNotice(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("countNotice");
	}
	
	@Override
	public int noticeInsert(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeDAOImpl noticeInsert >>> : ");
		return sqlSession.insert("noticeInsert", nvo);
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeDAOImpl noticeDetail >>> : ");
		return sqlSession.selectOne("noticeDetail", nvo);
	}

	@Override
	public int noticeHit(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return sqlSession.update("noticeHit", nvo);
	}

	@Override
	public int noticeUpdate(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeDAOImpl noticeUpdate >>> : ");
		return sqlSession.selectOne("noticeUpdate", nvo);
	}

	@Override
	public int noticeDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		logger.info("NoticeDAOImpl noticeDelete >>> : ");
		return sqlSession.selectOne("noticeDelete", nvo);
	}

	@Override
	public NoticeVO noticeFileCheck(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("noticeFileCheck", nvo);
	}

	@Override
	public int noticeFileDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("noticeFileDelete", nvo);
	}

}
