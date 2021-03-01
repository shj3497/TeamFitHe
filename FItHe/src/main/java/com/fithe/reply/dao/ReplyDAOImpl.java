package com.fithe.reply.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.reply.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
Logger logger = Logger.getLogger(ReplyDAOImpl.class);

	@Autowired(required=false)
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ReplyVO> replySelectAll(ReplyVO rvo) {
		logger.info("ReplyDAOImpl replySelectAll");
		return sqlSession.selectList("replySelectAll", rvo);
		
	}

	@Override
	public List<ReplyVO> replySelect(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("replySelect", rvo);
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return (Integer)sqlSession.insert("replyInsert", rvo);
	}

	@Override
	public int replyDelete(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return (Integer)sqlSession.update("replyDelete", rvo);
	}

}
