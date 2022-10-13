package kr.co.hotel.hostboard;

import java.util.List;
import java.util.Map;

public interface HostBoardService {
	
	Map index(HostBoardVO vo); // 목록보기 
	int viewCount(int hboard_no); // 조회수 증가
	HostBoardVO view(int hboard_no); // 상세보기
	boolean insert(HostBoardVO vo); // 등록
	HostBoardVO edit(int hboard_no); // 수정폼
	boolean update(HostBoardVO vo); // 수정처리
	boolean delete(int hboard_no); // 삭제
	boolean replyupdate(HostBoardVO vo); // 답변달기(관리자용)
	List<HostBoardVO> selectList(HostBoardVO vo); // 관리자페이지 문의게시판 정렬조건(관리자용)
	
	//이하 빛찬(호스트 마이페이지의 내가 남긴 문의글)--------------------
	public Map index_in_mypage(HostBoardVO vo);
	
}
