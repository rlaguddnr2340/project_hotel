package kr.co.hotel.hostboard;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ResponseObject { // 22.10.04 추가 
	
	// (json형태로 만들기 위해)
	List<HostBoardVO> objList; // 목록
	int totalCount; // 전체 게시물 수  
	
	// 페이징처리
	int startIdx;
	int totalPage;
	int startPage;
	int endPage;
	
	boolean prev; // 이전페이지
	boolean next; // 다음페이지
	
	String stype; // 검색유형 
	String sword; // 검색어
	
	int page; // 현재 페이지
	int pageRow; // 페이지당 게시글 갯수
	
	public ResponseObject () {
		this.page = 1;
		this.pageRow = 10;
		this.stype = "";
		this.sword = "";
	}
	
	public ResponseObject (int page, int pageRow) {
		this.page = page; 
		this.pageRow = pageRow;
	}

}


