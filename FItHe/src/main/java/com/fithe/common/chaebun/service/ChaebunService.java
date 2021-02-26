package com.fithe.common.chaebun.service;

import com.fithe.community.vo.CommunityVO;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.vo.NoticeVO;

public interface ChaebunService {

	public MemberVO getChaebun_m();
	public MemberVO getChaebun_a();
	public NoticeVO getNoticeChaebun();
	public CommunityVO getCommunityChaebun();
}
