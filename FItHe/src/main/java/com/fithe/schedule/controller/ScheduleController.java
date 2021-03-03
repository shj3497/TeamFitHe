package com.fithe.schedule.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String popup() {
		return "/schedule/schedulePopup";
	}
	
	//스케줄 입력
	//ajax 통신으로 ResponseBody 어노티에션 사용 
	@ResponseBody
	@RequestMapping(value="scheduleinsert", method=RequestMethod.POST)
	public String scheduleInsert(HttpServletRequest request, ScheduleVO svo) {
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		logger.info("Controller scheduleInsert 함수 진입");
		String sdate = request.getParameter("sdate");
		String smemo1 = request.getParameter("smemo1");
		String smemo2 = request.getParameter("smemo2");
		String smemo3 = request.getParameter("smemo3");
		String smemo4 = request.getParameter("smemo4");
		String smemo5 = request.getParameter("smemo5");
		logger.info(sdate);
		logger.info(smemo1);
		logger.info(smemo2);
		logger.info(smemo3);
		logger.info(smemo4);
		logger.info(smemo5);
		logger.info(mid);
		
		svo.setMid(mid); //아이디별로 캘린더에보여지는게 달라야하므로 설정
		if(smemo1 == "" || smemo1 == null || smemo2 == "" || smemo2 == null 
				|| smemo3 == "" || smemo3 == null || smemo4 == "" || smemo4 == null 
				|| smemo5 == "" || smemo5 == null || sdate == "" || sdate == null) {
			return "B";
		}
		int nCnt = scheduleService.scheduleInsert(svo);
		logger.info(nCnt);
		if(nCnt == 1) {
			return "G";
		}else {
			return "B";
		}		
	}
}
