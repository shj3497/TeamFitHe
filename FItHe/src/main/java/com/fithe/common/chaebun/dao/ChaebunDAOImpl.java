package com.fithe.common.chaebun.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.member.vo.MemberVO;

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

}
