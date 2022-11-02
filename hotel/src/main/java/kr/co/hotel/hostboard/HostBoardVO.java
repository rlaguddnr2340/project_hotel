package kr.co.hotel.hostboard;

import java.sql.Timestamp;

import kr.co.hotel.host.HostVO;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class HostBoardVO extends HostVO {
	
	private int hboard_no; // 게시물 번호
	private int host_no; // 호스트 번호
	private int hboard_type; // 문의유형
	private String hboard_title; // 제목
	private String hboard_content; // 내용
	private int hboard_viewcount; // 조회수
	private String hboard_writer; // 작성자
	private Timestamp hboard_regdate; // 등록일
	private Timestamp hboard_updatedate; // 수정일
	private int hboard_status; // 답변상태
	private Timestamp hboard_replyupdatedate; //답변날짜
	private String hboard_reply; // 답변내용
	
	private String host_name;// 스칼라서브쿼리로 host_name를 가져옴
	private int diff; // 최신글 확인을 위한 날짜 차이 
	
	private String filename_org;
	private String filename_real;
	
	// 로그인 확인용
	private int admin_no; // 관리자 번호
	private String admin_id; //관리자 로그인 확인용
	
	private int page; // 현재 페이지
	private int pageRow; // 한 페이지당 행(게시물)의 개수
	private int startIdx; // 페이지별 시작 인덱스
	private int totalCount; // 0927 추가
	
	private String sword; // 검색어
	private String stype; // 검색유형
	
	private String stype2; // 검색 조건(답변여부) 220927 추가
	private String stype3; // 검색 유형(답변상태) 220927 추가

	public HostBoardVO () {
		this.page = 1;
		this.pageRow = 10;
	}
	
	public HostBoardVO (int page, int pageRow) {
		this.page = page; 
		this.pageRow = pageRow;
	}
	
	
}
