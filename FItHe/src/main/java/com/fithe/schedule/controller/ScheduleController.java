package com.fithe.schedule.controller;

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

import com.fithe.member.controller.MemberController;
import com.fithe.schedule.service.ScheduleService;
import com.fithe.schedule.vo.ScheduleVO;

@Controller
public class ScheduleController {
	
	private Logger logger = Logger.getLogger(ScheduleController.class);
	
	private ScheduleService scheduleService;
	
	@Autowired(required=false)
	public ScheduleController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	@RequestMapping(value="calendar", method={RequestMethod.GET, RequestMethod.POST})
	public String Scheduleform(Model model, ScheduleVO svo, HttpServletRequest request) {
		logger.info("ScheduleController Scheduleform함수진입");
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		logger.info("로그인된 아이디 : " + mid);
		List<ScheduleVO> list = scheduleService.scheduleSelect(mid);
		logger.info("list.size() : " + list.size());
		model.addAttribute("list", list);
		return "/schedule/scheduleform";
	}
	
	@RequestMapping(value="schedulePopup", method=RequestMethod.GET)
	public String popup(@ModelAttribute ScheduleVO svo, Model model) {
		model.addAttribute("svo", svo);
		return "/schedule/schedulePopup";
	}
	
	//스케줄 입력
	//ajax 통신으로 ResponseBody 어노티에션 사용 
	@ResponseBody
	@RequestMapping(value="scheduleinsert", method=RequestMethod.POST)
	public String scheduleInsert(HttpServletRequest request, ScheduleVO svo) {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("mid");
		int valueCheck = 0;
		
		logger.info("Controller scheduleInsert 함수 진입");
		String sdate = request.getParameter("sdate");
		String situp = request.getParameter("situp");
		String bend = request.getParameter("bend");
		String jump = request.getParameter("jump");
		String around = request.getParameter("around");
		String race = request.getParameter("race");
		logger.info(sdate);
		logger.info(situp);
		logger.info(bend);
		logger.info(jump);
		logger.info(around);
		logger.info(race);
		logger.info(mid);
		
		svo.setMid(mid); //아이디별로 캘린더에보여지는게 달라야하므로 설정
		if(situp == "" || situp == null || bend == "" || bend == null 
				|| jump == "" || jump == null || around == "" || around == null 
				|| race == "" || race == null || sdate == "" || sdate == null) {
			return "B";
		}
		
		// insert 하기전에 이미 값이 있는 확인
		valueCheck = scheduleService.scheduleCheck(svo);
		System.out.println("valueCheck >>> : " + valueCheck);

		int nCnt = 0;
		// 기존에 값이 없을 때 insert
		if (valueCheck == 0) {
			 nCnt = scheduleService.scheduleInsert(svo);
			 logger.info("nCnt >>> : " + nCnt);
			
			if(nCnt == 1) {
				return "G";
			} else {
				return "B";
			}	
		} else { // 값이 있으면 기존 값을 update로 덮어주기
			nCnt = scheduleService.scheduleUpdate(svo);
			logger.info("nCnt >>> : " + nCnt);
			
			if(nCnt == 1) {
				return "G";
			} else {
				return "B";
			}
		}
		
			
	}
}
