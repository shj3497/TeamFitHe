package com.fithe.reply.service;

import java.util.List;

import com.fithe.reply.vo.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> replySelectAll(ReplyVO rvo);
	public List<ReplyVO> replySelect(ReplyVO rvo);
	public int replyInsert(ReplyVO rvo);
	public int replyDelete(ReplyVO rvo);
	
}
