package com.fithe.survey.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fithe.common.chaebun.ChaebunUtil;
import com.fithe.common.chaebun.service.ChaebunService;
import com.fithe.survey.service.SurveyService;
import com.fithe.survey.vo.SurveyVO;

@Controller
public class SurveyController {

	Logger logger = Logger.getLogger(SurveyController.class);
	
	// 의존성 주입
	@Autowired(required=false)
	private SurveyService surveyService;
	@Autowired(required=false)
	private ChaebunService chabunService;
	
	// 입력 폼
	@RequestMapping(value="surveyForm")
	public String surveyForm() {
		logger.info("SurveyController surveyForm");
		
		return "survey/surveyForm";
		
	}

	
	// 입력 동작
	@RequestMapping(value="sInsert")
	public String sInsert(SurveyVO svo, Model model, HttpServletRequest req) {
		logger.info("SurveyController sInsert");
		
		
		
		// 채번
		String snum = ChaebunUtil.getSurveyChaebun("Y", chabunService.getSurveyChaebun().getSnum());
		
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		
		// 로그인 안되어있을때
		if (mid.equals("null")) {
			model.addAttribute("loginerror", "error");
			
			return "survey/error";
		}
		
		svo.setMid(mid);
		
		svo.setSnum(snum);
		int nCnt = surveyService.surveyInsert(svo);
		
		
		
		System.out.println(svo.getMid());
		System.out.println(svo.getSnum());
		
		if(nCnt > 0) {return "survey/surveyInsert" ;}
		return "survey/surveyForm";
		
		}
	
	// 체력 입력 from
			@RequestMapping(value="sUpdateForm")
			public String sUpdateForm(SurveyVO svo, Model model, HttpServletRequest req ) {
				
				logger.info("SurveyController sUpdateForm");	
			
				HttpSession session = req.getSession();
				String mid = String.valueOf(session.getAttribute("mid"));
				svo.setMid(mid);
				
				SurveyVO su = surveyService.surveyLast(svo);
				
				System.out.println(su.getMid());
				System.out.println(su.getSnum());				
				
					model.addAttribute("su", su); 
					
					return "survey/sUpdateForm";
					
			
				
				//return "survey/surveyForm";
			}
		
		// 체력 입력 실행되는 부분 
		@RequestMapping(value="surveyUpdate")
		public String surveyUpdate(SurveyVO svo, Model model) {
			logger.info("SurveyController surveyUpdate");	
			
			
			int nCnt = surveyService.surveyUpdate(svo);
			
			if (nCnt > 0) { return "survey/surveyUpdate";}
			return "survey/sUpdateForm";
		}
	
	
	// 목록 조회
	@RequestMapping(value="surveyList")
	public String boardSelectAll(SurveyVO svo, Model model, HttpServletRequest req ) {
		logger.info("SurveyController surveyList");	
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		svo.setMid(mid);
		
		
		List<SurveyVO> listAll = surveyService.surveyList(svo);
		
		
		if (listAll.size() > 0) { 
			model.addAttribute("listAll", listAll);
			return "survey/surveyList";
		}
		
		return "survey/surveyForm";
	}
	
	// 상세 조회
	@RequestMapping(value="surveySelect")
	public String boardSelect(SurveyVO svo, Model model) {	
		logger.info("SurveyController surveySelect");	
		
		SurveyVO listS = surveyService.surveySelect(svo);
		

			model.addAttribute("listS", listS);
			return "survey/surveySelect";
		//}		
		//return "survey/surveyList";
	}
	
	
	// 삭제
		@RequestMapping(value="surveyDelete")
		public String surveyDelete(SurveyVO svo, Model model) {
			logger.info("SurveyController surveyDelete");	
			
			int nCnt = surveyService.surveyDelete(svo);
			
			if (nCnt > 0) { return "survey/surveyDelete";}
			return "survey/surveySelect";
		}
	
}
