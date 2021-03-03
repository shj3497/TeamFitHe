package com.fithe.schedule.service;

import java.util.List;

import com.fithe.schedule.vo.ScheduleVO;

public interface ScheduleService {
	public int scheduleInsert(ScheduleVO svo);
	
	public List<ScheduleVO> scheduleSelect(String mid);
}
