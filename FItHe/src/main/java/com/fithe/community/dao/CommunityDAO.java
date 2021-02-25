package com.fithe.community.dao;

import java.util.List;

import com.fithe.common.BoardPagingVO;
import com.fithe.community.vo.CommunityVO;

public interface CommunityDAO {
	public List<CommunityVO> communityList(BoardPagingVO pvo);
	public int countCommunity(BoardPagingVO pvo);
	public int communityInsert(CommunityVO cvo);
	public CommunityVO communityDetail(CommunityVO cvo); // 상세글 페이지
	public int communityHit(CommunityVO cvo); // 조회수 함수
	public int communityUpdate(CommunityVO cvo);
	public int communityDelete(CommunityVO cvo);
	public CommunityVO communityFileCheck(CommunityVO cvo);
	public int communityFileDelete(CommunityVO cvo);
}
