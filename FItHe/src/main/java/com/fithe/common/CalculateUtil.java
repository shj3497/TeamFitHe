package com.fithe.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.fithe.community.vo.CommunityVO;
import com.fithe.notice.vo.NoticeVO;

public abstract class CalculateUtil { 
	
	public static List<NoticeVO> getNoticeTimeGAP(List<NoticeVO> list){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss", Locale.KOREA);
		Date sysdate = new Date(); // 현재 날짜
		
		for (int i = 0; i < list.size(); i++) {
			
			try {
				// db에서 받아온 날짜 형태 맞춰주기
				Date dbDate = sdf.parse(list.get(i).getNinsertdate()); // 게시글에 입력된 작성일자 및 시간
				sysdate = sdf.parse(sdf.format(sysdate));
				
				long dateDif = sysdate.getTime() - dbDate.getTime();
				long day = dateDif / (24*60*60*1000); // 일
				long hour = dateDif / (60*60*1000); // 시간
				long minute = dateDif / (60*1000); // 분
				
				// if else 많이 쓰게 되어서 코드 수를 단축을 위해 상항 연산자 사용
				String result = (day==0? 
									(hour==0?
										(minute==0? "방금":String.valueOf(minute) + "분 전") 
													  :String.valueOf(hour) + "시간 전")
												 : list.get(i).getNinsertdate().substring(0, 10)); // yyyy-mm-dd
				
				list.get(i).setNinsertdate(result);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("CalculateUtil getNoticeTimeGAP 에서 에러 발생 >>> : " + e);
			}
			
		}
		
		return list;
	}
	
	public static List<CommunityVO> getCommunityTimeGAP(List<CommunityVO> list){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss", Locale.KOREA);
		Date sysdate = new Date(); // 현재 날짜
		
		for (int i = 0; i < list.size(); i++) {
			
			try {
				Date dbDate = sdf.parse(list.get(i).getCinsertdate());
				sysdate = sdf.parse(sdf.format(sysdate));
				
				long dateDif = sysdate.getTime() - dbDate.getTime();
				long day = dateDif / (24*60*60*1000); // 일
				long hour = dateDif / (60*60*1000); // 시간
				long minute = dateDif / (60*1000); // 분
				
				// if else 많이 쓰는게 더러워 보여서 상항 연산자 사용
				String result = (day==0? 
									(hour==0?
										(minute==0? "방금":String.valueOf(minute) + "분 전") 
													  :String.valueOf(hour) + "시간 전")
												 : list.get(i).getCinsertdate().substring(0, 10));
				
				list.get(i).setCinsertdate(result);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("CalculateUtil getCommunityTimeGAP 에서 에러 발생 >>> : " + e);
			}
			
		}
		
		return list;
	}

}
