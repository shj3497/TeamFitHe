package com.fithe.reply.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fithe.common.chaebun.ChaebunUtil;
import com.fithe.common.chaebun.service.ChaebunService;
import com.fithe.reply.service.ReplyService;
import com.fithe.reply.vo.ReplyVO;

@Controller
public class ReplyController {
	Logger logger = Logger.getLogger(ReplyController.class);

	@Autowired(required=false)
	private ReplyService replyService;
	@Autowired(required=false)
	private ChaebunService chaebunService;
	
	@RequestMapping(value="replyForm", method=RequestMethod.GET)
	public String replyForm() {
		//public String replyForm(Model model) 
		//위치 확인용 (--lyj^^)
				
		return "reply/replyForm";
	}
	
	// 댓글 등록
	@ResponseBody
	@RequestMapping(value="replyInsert", produces = "application/text; charset=utf8", method = {RequestMethod.GET, RequestMethod.POST})
	public String replyInsert(@ModelAttribute ReplyVO rvo, HttpServletRequest req) {
		logger.info("ReplyController replyInsert() >>> ");
				
		//String rnum=null;
		// 채번
		String rnum = ChaebunUtil.getReplyChaebun("Y",chaebunService.getReplyChaebun().getRnum());
		logger.info("getReplyChabun rnum >>> : " + rnum);
		
		rvo.setRnum(rnum);
		
		System.out.println("cnum :" + rvo.getCnum());
		
		// 임시로...
		//rvo.setCnum("B0001");

		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		System.out.println("mid :" + mid);
		rvo.setMid(mid);
		
		
		int nCnt = replyService.replyInsert(rvo);
		logger.info("ReplyController replyInsert nCnt >>> : " + nCnt);
		
		if(1 == nCnt) {
			return "GOOD";
		}else {
			return "BAD";
		}	
	}
	
	// 댓글 조회
	@RequestMapping( value="replySelect", produces = "application/text; charset=utf8", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String replySelect(@ModelAttribute ReplyVO rvo) {
		logger.info("ReplyController replySelect >>> : ");
		logger.info("ReplyController replySelect rvo.getRnum() >>> : " + rvo.getRnum());
	
		List<ReplyVO> list = replyService.replySelect(rvo);
		logger.info("RboardController rboardSelect _rbvo >>> : " + list);
		
		String listStr =     list.get(0).getRnum()
						+","+list.get(0).getMid()
						+","+list.get(0).getRcontent()
						+","+list.get(0).getRinsertdate();

		
		
		return listStr;	
	}

	// 댓글 전체 조회
	@RequestMapping( value="replyList", produces = "application/text; charset=utf8", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String replyList(@ModelAttribute ReplyVO rvo) {
	
		logger.info("ReplyController replyList rvo.getCnum() >>> : " + rvo.getCnum());
		//logger.info("ReplyController replyList rvo.getMid() >>> : " + rvo.getMid());
		
		List<ReplyVO> list  = replyService.replySelectAll(rvo);
		logger.info("ReplyController replyList list >>> : " + list);
		
		String ss = "";
		String listStr = "";
		
		for (int i=0; i < list.size(); i++) {
			ReplyVO _rvo = list.get(i);
			String s0 = _rvo.getCnum();
			String s1 = _rvo.getRnum();
			String s2 = _rvo.getMid();
			String s3 = _rvo.getRcontent();
			String s4 = _rvo.getRinsertdate();
			ss = s0+","+s1+","+s2+","+s3+","+s4;
			listStr += ss+" & ";
		}
		System.out.println("listStr >>> : " + listStr);
			
		return listStr;
	}

	// 댓글 삭제
	@RequestMapping( value="replyDelete", produces = "application/text; charset=utf8", method=RequestMethod.POST)
	@ResponseBody
	public String replyDelete(@ModelAttribute ReplyVO rvo) {
		logger.info("ReplyController replyDelete >>> : ");
		logger.info("ReplyController replyDelete rvo.getRnum() >>> : " + rvo.getRnum());
	
		int nCnt  = replyService.replyDelete(rvo);
		logger.info("ReplyController replyService nCnt >>> : " + nCnt);
		
		if (1 == nCnt) {
			return "GOOD";
		}else {
			return "BAD";
		}
	}
	
}
