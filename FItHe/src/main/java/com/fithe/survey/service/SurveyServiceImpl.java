package com.fithe.survey.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.survey.dao.SurveyDAO;
import com.fithe.survey.vo.SurveyVO;

@Service
@Transactional
public class SurveyServiceImpl implements SurveyService {
 
	Logger logger = Logger.getLogger(SurveyServiceImpl.class);
	
	@Autowired(required=false)
	private SurveyDAO surveyDAO;
	
	@Override
	public List<SurveyVO> surveyList(SurveyVO svo) {
		logger.info("SurveyServiceImpl SurveyList");
		return surveyDAO.surveyList(svo);
	}

	@Override
	public SurveyVO surveySelect(SurveyVO svo) {
		logger.info("SurveyServiceImpl SurveySelect");
		return surveyDAO.surveySelect(svo);
	}

	@Override
	public int surveyInsert(SurveyVO svo) {
		logger.info("SurveyServiceImpl SurveyInsert");
		return surveyDAO.surveyInsert(svo);
	}

	@Override
	public int surveyUpdate(SurveyVO svo) {
		logger.info("SurveyServiceImpl surveyUpdate");
		return surveyDAO.surveyUpdate(svo);
	}
	
	@Override
	public int surveyDelete(SurveyVO svo) {
		logger.info("SurveyServiceImpl SurveyDelete");
		return surveyDAO.surveyDelete(svo);
	}

	@Override
	public SurveyVO surveyLast(SurveyVO svo) {
		logger.info("SurveyServiceImpl surveyLast");
		return surveyDAO.surveyLast(svo);
	}

	


}
