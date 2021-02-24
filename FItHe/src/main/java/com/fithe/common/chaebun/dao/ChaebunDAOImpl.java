package com.fithe.common.chaebun.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.community.vo.CommunityVO;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.vo.NoticeVO;

@Repository
public class ChaebunDAOImpl implements ChaebunDAO {

	@Autowired(required=false)
	private SqlSession sqlSession;
	
	@Override
	public MemberVO getChaebun_m() {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) getChaebun_m() 진입");
		
		return sqlSession.selectOne("getChaebun_m");
	}

	@Override
	public MemberVO getChaebun_a() {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) getChaebun_a() 진입");
		
		return sqlSession.selectOne("getChaebun_a");
	}
	
	@Override
	public NoticeVO getNoticeChaebun() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getNoticeChabun");
	}

	@Override
	public CommunityVO getCommunityChaebun() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getCommunityChabun");
	}
}
