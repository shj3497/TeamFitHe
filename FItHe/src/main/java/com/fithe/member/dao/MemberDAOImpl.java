package com.fithe.member.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{

	// SqlSession VS SqlSessionTemplate
	// SqlSessionTemplate은 SqlSession을 구현하고 코드에서 대체하는 역할을 한다.
	// SqlSessionTemplate는 쓰레드에 안전하고 여러개의 DAO나 Mapper에서 공유 할 수 있다.
	@Autowired(required=false)
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<MemberVO> memberSelectAll(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberSelectAll() 진입");
		
		return sqlSession.selectList("memberSelectAll", mvo);
	}

	@Override
	public MemberVO memberSelect(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberSelect() 진입");
		
		return (MemberVO)sqlSession.selectOne("memberSelect", mvo);
	}

	@Override
	public int memberInsert(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberInsert() 진입");
		
		return (Integer)sqlSession.insert("memberInsert", mvo);
	}

	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberUpdate() 진입");
		
		return (Integer)sqlSession.update("memberUpdate", mvo);
	}

	@Override
	public int memberDelete(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberDelete() 진입");
		
		return (Integer)sqlSession.update("memberDelete", mvo);
	}

	@Override
	public int memberIdCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberIdCheck() 진입");
		
		return (Integer)sqlSession.selectOne("memberIdCheck", mvo);
	}

	
	
	
	@Override
	public MemberVO memberLogin(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) memberLogin() 진입");
		
		return (MemberVO)sqlSession.selectList("memberLogin", mvo);
	}

	// 인증번호를 인증번호 저장 테이블에 insert한다.
	@Override
	public int authInsert(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) authInsert() 진입");
		
		return (Integer)sqlSession.insert("authInsert", mvo);
	}

	// 인증번호테이블에 있는 name과 이메일을 가지고 멤버테이블에있는 것과 비교
	@Override
	public MemberVO authCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("(DAOImpl) authCheck() 진입");
		
		return (MemberVO)sqlSession.selectList("authCheck", mvo);
	}
	
	

}
