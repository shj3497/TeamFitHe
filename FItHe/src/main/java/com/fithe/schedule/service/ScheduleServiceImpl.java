package com.fithe.schedule.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fithe.member.service.MemberServiceImpl;
import com.fithe.schedule.dao.ScheduleDAO;
import com.fithe.schedule.vo.ScheduleVO;

@Service
@Transactional
public class ScheduleServiceImpl implements ScheduleService {
	
	private Logger logger = Logger.getLogger(MemberServiceImpl.class);
	private ScheduleDAO scheduleDAO;
	
	@Autowired(required=false)
	public ScheduleServiceImpl(ScheduleDAO scheduleDAO) {
		this.scheduleDAO = scheduleDAO;
	}
	
	@Override
	public int scheduleInsert(ScheduleVO svo) {
		// TODO Auto-generated method stub
		logger.info("ScheduleServiceImpl scheduleInsert함수");
		return scheduleDAO.scheduleInsert(svo);
	}

	@Override
	public List<ScheduleVO> scheduleSelect(String mid) {
		// TODO Auto-generated method stub
		logger.info("ScheduleServiceImpl scheduleSelect함수");
		return scheduleDAO.scheduleSelect(mid);
	}

	@Override
	public int scheduleCheck(ScheduleVO svo) {
		// TODO Auto-generated method stub
		logger.info("ScheduleServiceImpl scheduleCheck함수");
		return scheduleDAO.scheduleCheck(svo);
	}

	@Override
	public int scheduleUpdate(ScheduleVO svo) {
		// TODO Auto-generated method stub
		logger.info("ScheduleServiceImpl scheduleUpdate함수");
		return scheduleDAO.scheduleUpdate(svo);
	}

}
