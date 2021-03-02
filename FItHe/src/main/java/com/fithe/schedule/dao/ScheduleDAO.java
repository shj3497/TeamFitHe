package com.fithe.schedule.dao;

import java.util.List;

import com.fithe.schedule.vo.ScheduleVO;

public interface ScheduleDAO {
	
	public int scheduleInsert(ScheduleVO svo);
	
	public List<ScheduleVO> scheduleSelect(String mid);
}
