package com.fithe.survey.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.survey.vo.SurveyVO;

@Repository
public class SurveyDAOImpl implements SurveyDAO {
	Logger logger = Logger.getLogger(SurveyDAOImpl.class);
	
	@Autowired(required=false)
	private SqlSession sqlSession;
	
	// 저장 목록
	@Override
	public List<SurveyVO> surveyList(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveyList");
		return sqlSession.selectList("surveyList", svo);
	}

	// 상세정보
	@Override
	public SurveyVO surveySelect(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveySelct");
		return sqlSession.selectOne("surveySelect", svo);
	}

	// 입력
	@Override
	public int surveyInsert(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveyInsert");
		return sqlSession.insert("surveyInsert", svo);
	}

	
	// 수정
	@Override
	public int surveyUpdate(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveyUpdate");
		return sqlSession.update("surveyUpdate", svo);
	}

	// 삭제
	@Override
	public int surveyDelete(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveyDelete");
		return sqlSession.update("surveyDelete", svo);
	}

	// survey 가장 최근 insert된거 가져오는 부분
	@Override
	public SurveyVO surveyLast(SurveyVO svo) {
		logger.info("SurveyDAOImpl surveyLast");
		return sqlSession.selectOne("surveyLast", svo);
	}
	
		
}
