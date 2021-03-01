package com.fithe.common.chaebun.service;

import com.fithe.community.vo.CommunityVO;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.vo.NoticeVO;
import com.fithe.reply.vo.ReplyVO;
import com.fithe.survey.vo.SurveyVO;

public interface ChaebunService {

	public MemberVO getChaebun_m();
	public MemberVO getChaebun_a();
	public NoticeVO getNoticeChaebun();
	public CommunityVO getCommunityChaebun();
	public ReplyVO getReplyChaebun();
	public SurveyVO getSurveyChaebun();
}
