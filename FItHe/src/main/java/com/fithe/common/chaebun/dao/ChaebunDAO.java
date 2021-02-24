package com.fithe.common.chaebun.dao;

import com.fithe.community.vo.CommunityVO;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.vo.NoticeVO;

public interface ChaebunDAO {

	// 테이블을 조회하여 채번을 구해온다.
	// getChaebun_m >> member
	// getChaebun_b >> board 
	// getChaebun_a >> auth
	public MemberVO getChaebun_m();
	public MemberVO getChaebun_a();
	public NoticeVO getNoticeChaebun();
	public CommunityVO getCommunityChaebun();
}
