package com.fithe.community.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.common.BoardPagingVO;
import com.fithe.community.vo.CommunityVO;

@Repository
public class CommunityDAOImpl implements CommunityDAO {
	
	private Logger logger = Logger.getLogger(CommunityDAOImpl.class);
	
	@Autowired(required = false)
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<CommunityVO> communityList(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityDAOImpl communityInsert");
		return sqlSession.selectList("communityList", pvo);
	}
	
	@Override
	public int countCommunity(BoardPagingVO pvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("countCommunity", pvo);
	}
	
	@Override
	public int communityInsert(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityDAOImpl communityInsert");
		return sqlSession.insert("communityInsert", cvo);
	}

	@Override
	public CommunityVO communityDetail(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityDAOImpl communityDetail");
		return sqlSession.selectOne("communityDetail", cvo);
	}

	@Override
	public int communityHit(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return sqlSession.update("communityHit", cvo);
	}

	@Override
	public int communityUpdate(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityDAOImpl communityUpdate");
		return sqlSession.selectOne("communityUpdate", cvo);
	}

	@Override
	public int communityDelete(CommunityVO cvo) {
		// TODO Auto-generated method stub
		logger.info("CommunityDAOImpl communityDelete");
		return sqlSession.selectOne("communityDelete", cvo);
	}

	@Override
	public CommunityVO communityFileCheck(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("communityFileCheck", cvo);
	}

	@Override
	public int communityFileDelete(CommunityVO cvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("communityFileDelete", cvo);
	}
	

}
