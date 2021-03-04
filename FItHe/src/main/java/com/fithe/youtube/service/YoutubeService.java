package com.fithe.youtube.service;

import java.util.List;

import com.fithe.youtube.vo.YoutubeVO;

public interface YoutubeService {
	public int youtubeInsert(YoutubeVO yvo);
	
	public List<YoutubeVO> youtubeSelect(String yid);
	
	public int youtubeUpdate(YoutubeVO yvo);

}
