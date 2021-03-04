package com.fithe.youtube.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fithe.youtube.service.YoutubeService;
import com.fithe.youtube.vo.YoutubeVO;

@Controller
public class YoutubeController {
	
	private Logger logger = Logger.getLogger(YoutubeController.class); 
	
	private YoutubeService youtubeService;
	
	@Autowired(required=false)
	public YoutubeController(YoutubeService youtubeService) {
		this.youtubeService = youtubeService;
	}
	
	@RequestMapping(value="youtubeList", method= {RequestMethod.POST, RequestMethod.GET})
	public String youtubeadminform(HttpServletRequest request, Model model) {
		logger.info("YoutubeController youtubeform함수");
		String yid = request.getParameter("yid");
		logger.info("yid : " + yid);
		
		if(yid == null) {
			yid = "1";
		}
		
		List<YoutubeVO> listy = youtubeService.youtubeSelect(yid);
		logger.info("listy.size() : " + listy.size());
		model.addAttribute("listy", listy);
		return "/admin/youtubeList";
	}
	
	@RequestMapping(value="youtube", method= {RequestMethod.POST, RequestMethod.GET})
	public String youtubeform(HttpServletRequest request, Model model) {
		logger.info("YoutubeController youtubeform함수");
		String yid = request.getParameter("yid");
		logger.info("yid : " + yid);
		
		if(yid == null) {
			yid = "1";
		}
		
		List<YoutubeVO> listy = youtubeService.youtubeSelect(yid);
		logger.info("listy.size() : " + listy.size());
		model.addAttribute("listy", listy);
		return "/youtube/youtubememberform";
	}
	
	@RequestMapping(value="youtubeinsertform", method=RequestMethod.GET)
	public String youtubeInsertform() {
		logger.info("YoutubeController youtubeInsertform함수");
		return "/youtube/youtubeinsert";
	}
	
	@ResponseBody
	@RequestMapping(value="youtubeinsert", method=RequestMethod.POST)
	public String youtubeInsert(HttpServletRequest request, YoutubeVO yvo) {
		logger.info("YoutubeController youtubeInsert함수");
		String yid = request.getParameter("yid");
		String ynum = request.getParameter("ynum");
		String ylink = request.getParameter("ylink");
		logger.info("yid : " + yid);
		logger.info("ynum : " + ynum);
		logger.info("ylink : " + ylink);
		//빈칸방지
		if(yid == null || yid == "" || ynum == null || ynum == "" || ylink == null || ylink == "") {
			return "BAD";
		}
		int nCnt = youtubeService.youtubeInsert(yvo);
		logger.info("nCnt : " + nCnt);
		if(nCnt == 1) {
			return "GOOD";
		}else {
			return "BAD";
		}	
	}
	
	@RequestMapping(value="youtubeupdateform", method=RequestMethod.GET)
	public String youtubeUpdateform() {
		logger.info("YoutubeController youtubeUpdateform함수");
		return "/youtube/youtubeupdate";
	}
	
	@ResponseBody
	@RequestMapping(value="youtubeupdate", method=RequestMethod.POST)
	public String youtubeUpdate(HttpServletRequest request, YoutubeVO yvo) {
		logger.info("YoutubeController youtubeUpdate함수");
		int nCnt = youtubeService.youtubeUpdate(yvo);
		logger.info("nCnt : " + nCnt);
		if(nCnt == 1) {
			return "GOOD";
		}else {
			return "BAD";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="youtubeselect", method=RequestMethod.POST)
	public String youtubeSelect(HttpServletRequest request ,Model model, YoutubeVO yvo) {
		logger.info("YoutubeController youtubeSelect함수");
		String yid = request.getParameter("yid");
		logger.info("yid : " + yid);
		List<YoutubeVO> listy = youtubeService.youtubeSelect(yid);
		logger.info("size : " + listy.size());
		if(listy.size() > 0) {
			model.addAttribute("listy", listy);
			return "G";
		}
		return "B";
	}
	
}
