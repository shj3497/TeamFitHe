package com.fithe.schedule.service;

import java.util.List;

import com.fithe.schedule.vo.ScheduleVO;

public interface ScheduleService {
	public int scheduleInsert(ScheduleVO svo);
	public List<ScheduleVO> scheduleSelect(String mid);
	// 값이 있는지 확인, 
	public int scheduleCheck(ScheduleVO svo);
	// 값이 이미 있으면 덮어 씌우기 위함
	public int scheduleUpdate(ScheduleVO svo);
}
