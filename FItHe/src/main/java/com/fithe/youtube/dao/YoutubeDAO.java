package com.fithe.youtube.dao;

import java.util.List;

import com.fithe.youtube.vo.YoutubeVO;

public interface YoutubeDAO {
	public int youtubeInsert(YoutubeVO yvo);
	
	public List<YoutubeVO> youtubeSelect(String yid);
	
	public int youtubeUpdate(YoutubeVO yvo);
}
