package com.fithe.survey.dao;

import java.util.List;

import com.fithe.survey.vo.SurveyVO;

public interface SurveyDAO {

	// 전체 목록
	public List<SurveyVO> surveyList(SurveyVO svo);
	// 세부사항
	public SurveyVO surveySelect(SurveyVO svo);
	// 등록
	public int surveyInsert(SurveyVO svo);
	// 수정
	public int surveyUpdate(SurveyVO svo);
	// 삭제
	public int surveyDelete(SurveyVO svo);
	
	// survey 가장 최근 insert된거 가져오는 부분
	public SurveyVO surveyLast(SurveyVO svo);
	
}
