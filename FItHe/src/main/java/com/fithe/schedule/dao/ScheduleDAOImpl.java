package com.fithe.schedule.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.schedule.vo.ScheduleVO;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO {
	
	@Autowired(required=false)
	private SqlSession sqlSession; 
	
	@Override
	public int scheduleInsert(ScheduleVO svo) {
		// TODO Auto-generated method stub
		return (Integer)sqlSession.insert("scheduleInsert", svo);
	}

	@Override
	public List<ScheduleVO> scheduleSelect(String mid) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("scheduleSelect", mid);
	}

}
