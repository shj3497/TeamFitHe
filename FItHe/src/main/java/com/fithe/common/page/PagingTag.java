package com.fithe.common.page;


import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class PagingTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	/**
	* @param page 현제 페이지 번호
	* @param total 전체 조회된 Row 수
	* @param list_size 페이지에 보여주는 레코드수
	* @param page_size 페이지 네비게이터에 표시되는 페이지 버튼의 갯수
	*/
	
	private int page = 1;		// 현재 페이지 번호
	private int total = 1;		// 전체 조회된 데이터(row)의 수
	private int list_size = 10;	// 한 페이지에 보여주는 row 수
	private int page_size = 10;	// 페이징 번호 개수 ex) previous 1~10페이지 next
	
	
	public int doStartTag() throws JspException{
		try {
			System.out.println("(PagingTag) doStartTag() 진입");
			pageContext.getOut().println(getPaging());
		}catch(IOException e) {
			System.out.println("e >>> : " + e);
		}
		
		return super.doStartTag();
	}
	
	public String getPaging() {
		
		String ret = "";
		
		if(page < 1) {
			page = 1;
		}
		if(total < 1) {
			return "";
		}
		
		// page가 4페이지이고, page_size가 10이면
		// currentFirst는 1이다.
		int currentFirst = ((page-1)/page_size) * page_size +1; // >> current = page :4
		
		// currentlast >>> 한 페이지당 보여줄 버튼이 조정된다.
		int currentlast = ((page-1)/page_size) * page_size + page_size;
		// >> (page -1) + page_size가 아니다.
		// ((page-1)/page_size) >> 정수로 계산해야함 (3/10)>> 0, 0*page_szie + page_size >> page_size
		
		// nextFirst >> '다음'버튼을 눌렀을 때 보여질 버튼 
		int nextFirst = (((page-1)/page_size) + 1) * page_size + 1; // >> 11
		
		int prevLast = (((page-1)/page_size) - 1) * page_size + 1; // ex) page 14, page_size 10 >> 1 
		
		// lastPage : 데이터의 총개수 / list_size
		int lastPage = 1;
		lastPage = total/list_size;
		
		if(total % list_size!=0) {
			lastPage = lastPage+1;
		}
		
		// currentlast가 lastPage(총 페이지수)보다 크면 마지막 페이지로 수정
		currentlast = (currentlast > lastPage)? lastPage:currentlast;
		
//		################### 여기서 class=''으로 css 수정 ################### 		
		ret +="<div class='paginate'>";
		
		// page가 1이상이면 <a href>태그로 경로를 활성화! 시켜주고, 1이상이 아니면
		if(page >1) {
			// #####여기가 페이징에서 처음이라는 버튼을 활성화 시켜주는것 class=''에 css 적용!
			ret += "<a href=\"javascript:goPage('1')\" class = ''>처음</a>";
			System.out.println("(PagingTag) ret >>> : " + ret);
		}else {
			// ##### 여기가 페이징에서 처음이라는 버튼을 비활성화! 시켜주는것 class=''에 css 적용!
			ret += "<a href='#' class=''>처음</a>";
		}
		
		// page가 10이상이면 goPage(숫자)로 마지막  페이지로 이동하는 버튼 활성화
		if(prevLast>0) {
			// ##### 여기가 만약 11페이지이면 이전이라는 버튼을 활성화! 시켜주는것 class=''에 css 적용!
			ret += "<a href=\"javascript:goPage('"+prevLast+"');\">이전</a>";
		}else {
			// ##### 여기가 만약 11페이지이면 이전이라는 버튼을 비활성화! 시켜주는것 class=''에 css 적용!
			ret += "<a href='#' class=''>이전</a>";
		}
		
		for(int j=currentFirst; j<currentFirst + page_size && j<=lastPage; j++) {
			if(j<=currentlast) {
				if(j==page) {
					// ##### 여기가 현재 페이지를 나타내는 태그, class에 css적용!
					// a href='#' 경로 막아논 것!
					ret += "<a href='#' class=''>"+j+"</a>";
				}else {
					// ##### 여기가 현재 페이지가 아닌 다른 페이징 번호를 나타내는 곳 class에 css적용!
					ret += "<a href=\"javascript:goPage('"+j+"');\" class = ''>"+j+"</a>";
				}
			}
		}
		
		if(nextFirst <= lastPage) {
			// ##### 여기가 페이징에서 다음버튼 활성화! 시켜주는것 class=''에 css적용!
			ret += "<a href=\"javascript:goPage('"+nextFirst+"')\" class=''>다음</a>";
		}else {
			// ##### 여기가 페이징에서 다음버튼 비활성화! 시켜주는것 class=''에 css적용!
			ret += "<a href='#' class=''>다음</a>";
		}
		
		if(page < lastPage) {
			ret += "<a href=\"javascript:goPage('"+lastPage+"')\" class=''>마지막</a>";
		}else {
			ret += "<a href='#' class=''>마지막</a>";
		}
		
		ret+="</div>";
		
		
		return ret;
	}
	
	public void setPage(int page) {
		this.page = page;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setList_size(int list_size) {
		this.list_size = list_size;
	}

	public void setPage_size(int page_size) {
		this.page_size = page_size;
	}
}
