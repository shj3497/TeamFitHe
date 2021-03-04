package com.fithe.youtube.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fithe.youtube.vo.YoutubeVO;

@Repository
public class YoutubeDAOImpl implements YoutubeDAO {
	
	@Autowired(required=false)
	private SqlSession sqlSession; 
	
	@Override
	public int youtubeInsert(YoutubeVO yvo) {
		// TODO Auto-generated method stub
		return (Integer)sqlSession.insert("youtubeInsert", yvo);
	}

	@Override
	public List<YoutubeVO> youtubeSelect(String yid) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("youtubeSelect", yid);
	}

	@Override
	public int youtubeUpdate(YoutubeVO yvo) {
		// TODO Auto-generated method stub
		return (Integer)sqlSession.update("youtubeUpdate", yvo);
	}
}
