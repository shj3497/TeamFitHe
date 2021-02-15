package com.fithe.member.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.member.dao.MemberDAO;
import com.fithe.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	private MemberDAO memberDAO;
	private Logger logger = Logger.getLogger(MemberServiceImpl.class);
	
	@Autowired(required=false)
	public MemberServiceImpl(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	
	
	@Override
	public List<MemberVO> memberSelectAll(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberSelectAll() 진입");
		
		List<MemberVO> list = memberDAO.memberSelectAll(mvo);
		
		return list;
	}

	@Override
	public MemberVO memberSelect(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberSelect() 진입");
		
		MemberVO _mvo = null;
		_mvo = memberDAO.memberSelect(mvo);
		
		return _mvo;
	}

	@Override
	public int memberInsert(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberInsert() 진입");
		
		int nCnt = memberDAO.memberInsert(mvo);
		
		return nCnt;
	}

	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberUpdate() 진입");
		
		int nCnt = memberDAO.memberUpdate(mvo);
		
		return nCnt;
	}

	@Override
	public int memberDelete(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberDelete() 진입");
		
		int nCnt = memberDAO.memberDelete(mvo);
		
		return nCnt;
	}

	@Override
	public int memberIdCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberIdCheck() 진입");
		
		int nCnt = memberDAO.memberIdCheck(mvo);
		
		return nCnt;
	}


	@Override
	public MemberVO memberLogin(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) memberLogin() 진입");
		
		MemberVO _mvo = null;
		_mvo = memberDAO.memberLogin(mvo);
		
		return _mvo;
	}


	@Override
	public int authInsert(MemberVO mvo) {
		// TODO Auto-generated method stub
		logger.info("(ServiceImpl) authInsert() 진입");
		
		int nCnt = memberDAO.authInsert(mvo);
		
		return nCnt;
	}

}
