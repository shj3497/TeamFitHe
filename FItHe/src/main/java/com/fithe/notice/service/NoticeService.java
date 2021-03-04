package com.fithe.notice.service;

import java.util.List;

import com.fithe.common.BoardPagingVO;
import com.fithe.notice.vo.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> noticeList(BoardPagingVO pvo);
	public List<NoticeVO> noticeExposureList(); // 공지글 종류가 일반이 아닌 공지글 인것만 
	public int countNotice(BoardPagingVO pvo);
	public int noticeInsert(NoticeVO nvo);
	public NoticeVO noticeDetail(NoticeVO nvo);
	public int noticeHit(NoticeVO nvo);
	public int noticeUpdate(NoticeVO nvo);
	public int noticeDelete(NoticeVO nvo);
	public NoticeVO noticeFileCheck(NoticeVO nvo);
	public int noticeFileDelete(NoticeVO nvo);
}
