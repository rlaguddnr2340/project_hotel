package kr.co.hotel.guestboard;

import java.util.List;
import java.util.Map;

import kr.co.hotel.guest.GuestVO;

public interface GuestBoardService {
	
	Map index(GuestBoardVO vo); // 목록보기 
	
	int viewCount(int gboard_no); // 조회수 증가
	GuestBoardVO view(int gboard_no); // 상세보기
	boolean insert(GuestBoardVO vo); // 등록(관리자용)
	GuestBoardVO edit(int gboard_no); // 수정폼(관리자용)
	boolean update(GuestBoardVO vo); // 수정처리(관리자용)
	boolean delete(int gboard_no); // 삭제(관리자용)
	boolean replyupdate(GuestBoardVO vo); // 답변달기(관리자용)
	List<GuestBoardVO> adminList(GuestBoardVO vo); // 관리자 문의게시판 정렬조건(관리자용)
	
	//마이페이지 내 문의글 목록보기_빛찬_220829
	Map index_in_mypage(GuestBoardVO vo); // 목록보기 
	
}
