package com.fithe.common.chaebun.dao;

import com.fithe.member.vo.MemberVO;

public interface ChaebunDAO {

	// 테이블을 조회하여 채번을 구해온다.
	// getChaebun_m >> member
	// getChaebun_b >> board 
	public MemberVO getChaebun_m();
}
