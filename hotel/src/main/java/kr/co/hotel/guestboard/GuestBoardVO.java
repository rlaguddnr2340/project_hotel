package kr.co.hotel.guestboard;

import java.sql.Timestamp;

import org.json.simple.JSONObject;

import kr.co.hotel.guest.GuestVO;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class GuestBoardVO extends GuestVO {
	private int gboard_no; // 게시물 번호
	private int guest_no; // 게스트 번호
	private int gboard_type; // 문의유형
	private String gboard_title; // 제목
	private String gboard_content; // 내용
	private int gboard_viewcount; // 조회수
	private String gboard_writer; //작성자
	private Timestamp gboard_regdate; // 등록일
	private Timestamp gboard_updatedate; // 수정일
	private int gboard_status; // 답변상태
	private Timestamp gboard_replyupdatedate; // 답변날짜
	private String gboard_reply; // 답변내용
	
	private String guest_name; // 스칼라서브쿼리로 guest_name를 가져옴
	private int diff; // 최신글 new 날짜차이 (서브쿼리)
	
	private String filename_org;
	private String filename_real;
	
	// 확인용
	private int admin_no; // 관리자 번호
	private String admin_id; //관리자 로그인 확인용
	
	
	private int page; // 현재 페이지
	private int pageRow; // 한 페이지당 행(게시물)의 개수
	private int startIdx; // 페이지별 시작 인덱스
	private int totalCount; // 0912 추가
	
	private String sword; // 검색어
	private String stype; // 검색유형 
	
	private String stype2; // 검색유형 (문의유형)
	private String stype3; // 검색유형 220830 추가 (답변상태)
	

	public GuestBoardVO () {
		this.page = 1;
		this.pageRow = 10;
	}
	
	public GuestBoardVO (int page, int pageRow) {
		this.page = page; 
		this.pageRow = pageRow;
	}


	
	
}
