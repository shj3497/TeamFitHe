package com.fithe.common.page;

public class Paging {

	/*
	 * 페이징을 위한 설정 작업
	 * */
	
	public static void setPage(PagingVO pvo) {
		
		int page = Util.nvl(pvo.getPage(), 1);
		int pageSize = Util.nvl(pvo.getPageSize(), 10);
		
		if(pvo.getPage() == null) {
			pvo.setPage(String.valueOf(page));
		}
		if(pvo.getPageSize()==null) {
			pvo.setPageSize(String.valueOf(pageSize));
		}
		
		int start_row = (page-1)*pageSize + 1;
		
		int end_row = (page-1)*pageSize + pageSize;
		
		pvo.setStart_row(String.valueOf(start_row));
		pvo.setEnd_row(String.valueOf(end_row));
	}
}
