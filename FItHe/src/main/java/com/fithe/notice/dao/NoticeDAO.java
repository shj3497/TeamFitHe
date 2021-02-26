package com.fithe.notice.dao;

import java.util.List;

import com.fithe.common.BoardPagingVO;
import com.fithe.notice.vo.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> noticeList(BoardPagingVO pvo);
	public List<NoticeVO> noticeExposureList(); // 공지글 종류가 일반이 아닌 공지글 인것만 
	public int countNotice(BoardPagingVO pvo); // 삭제가 안된 게시글 세는 함수
	public int noticeInsert(NoticeVO nvo);
	public NoticeVO noticeDetail(NoticeVO nvo); // 상세글 페이지
	public int noticeHit(NoticeVO nvo); // 조회수 함수
	public int noticeUpdate(NoticeVO nvo);
	public int noticeDelete(NoticeVO nvo);
	public NoticeVO noticeFileCheck(NoticeVO nvo);
	public int noticeFileDelete(NoticeVO nvo);
}
