package com.fithe.common.chaebun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.common.chaebun.dao.ChaebunDAO;
import com.fithe.member.vo.MemberVO;

@Service
@Transactional
public class ChaebunServiceImpl implements ChaebunService {

	private ChaebunDAO chaebunDAO;
	
	@Autowired(required=false)
	public ChaebunServiceImpl(ChaebunDAO chaebunDAO) {
		this.chaebunDAO=chaebunDAO;
	}
	
	@Override
	public MemberVO getChaebun_m() {
		// TODO Auto-generated method stub
		System.out.println("(ChaebunServiceImpl) getChaebun_m() 진입");
		
		MemberVO _mvo = null;
		_mvo = chaebunDAO.getChaebun_m();
		
		return _mvo;
	}

}
