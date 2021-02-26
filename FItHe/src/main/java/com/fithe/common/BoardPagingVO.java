package com.fithe.common;

public class BoardPagingVO {
	// 페이징 처리 속성
	// 현재페이지, 시작페이지, 끝페이지, 게시글 총 갯수, 페이지당 글 갯수, 마지막페이지, SQL쿼리에 쓸 start, end
	private int nowPage;
	private int startPage;
	private int endPage;
	private int total;
	private int cntPerPage;
	private int lastPage;
	private int start;
	private int end;
	
	private int cntPage = 5;
	
	// 검색기능 속성
	private String keyfilter;
	private String keyword;
	
	// 정렬기능 속성
	private String order_by;
	private String order_sc;
	
	public BoardPagingVO() {
		
	}
	
	public BoardPagingVO(int total, int nowPage, int cntPerPage) {
		setNowPage(nowPage);
		setCntPerPage(cntPerPage);
		setTotal(total);
		calcLastPage(getTotal(), getCntPerPage());
		calcStartEndPage(getNowPage(), cntPage);
		calcStartEnd(getNowPage(), getCntPerPage());
	}
	// 제일 마지막 페이지 계산
	public void calcLastPage(int total, int cntPerPage) {
		setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
	}
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int cntPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		setStartPage(getEndPage() - cntPage + 1);
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}
	// DB 쿼리에서 사용할 start, end값 계산
	public void calcStartEnd(int nowPage, int cntPerPage) {
		setEnd(nowPage * cntPerPage);
		setStart(getEnd() - cntPerPage + 1);
	}
	
	public BoardPagingVO(int nowPage, int startPage, int endPage, int total, int cntPerPage, int lastPage, int start,
			int end, int cntPage, String keyfilter, String keyword, String order_by, String order_sc) {
		this.nowPage = nowPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.total = total;
		this.cntPerPage = cntPerPage;
		this.lastPage = lastPage;
		this.start = start;
		this.end = end;
		this.cntPage = cntPage;
		this.keyfilter = keyfilter;
		this.keyword = keyword;
		this.order_by = order_by;
		this.order_sc = order_sc;
	}

	public int getNowPage() {
		return nowPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getTotal() {
		return total;
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public int getStart() {
		return start;
	}

	public int getEnd() {
		return end;
	}

	public int getCntPage() {
		return cntPage;
	}

	public String getKeyfilter() {
		return keyfilter;
	}

	public String getKeyword() {
		return keyword;
	}

	public String getOrder_by() {
		return order_by;
	}

	public String getOrder_sc() {
		return order_sc;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

	public void setKeyfilter(String keyfilter) {
		this.keyfilter = keyfilter;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public void setOrder_by(String order_by) {
		this.order_by = order_by;
	}

	public void setOrder_sc(String order_sc) {
		this.order_sc = order_sc;
	}

	@Override
	public String toString() {
		return "CommunityVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total
				+ ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
				+ ", cntPage=" + cntPage + "]";
	}
}
