package kr.co.hotel.hostboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HostBoardServiceImpl implements HostBoardService {

	@Autowired
	HostBoardMapper mapper;

	// 목록
	@Override
	public Map index(HostBoardVO vo) {

		int totalCount = mapper.count(vo); // 총 게시물수
		int totalPage = totalCount / vo.getPageRow(); // 총 페이지수

		if (totalCount % vo.getPageRow() > 0)
			totalPage++;

		/*
		 * 총 게시물 수 12개 총 페이지는 12 / 한 페이지에 표시되는 행(게시물개수) 수 10개 1페이지(10행), 2행 12 % 10 > 0
		 */

		// 페이지별 시작 인덱스 mySQL 에서는 시작이 0부터니까
		int startIdx = (vo.getPage() - 1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<HostBoardVO> list = mapper.list(vo);

		// 페이징처리
		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;

		if (endPage > totalPage)
			endPage = totalPage;

		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;

		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startIdx", startIdx);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("list", list);
		return map;
	}

	// 등록
	@Override
	public boolean insert(HostBoardVO vo) {
		return mapper.insert(vo) > 0 ? true : false;
	}

	// 상세보기
	@Override
	public HostBoardVO view(int hboard_no) {
		return mapper.view(hboard_no);
	}

	// 수정폼
	@Override
	public HostBoardVO edit(int hboard_no) {
		return mapper.view(hboard_no);
	}

	// 수정처리
	@Override
	public boolean update(HostBoardVO vo) {
		return mapper.update(vo) > 0 ? true : false;
	}

	// 삭제
	@Override
	public boolean delete(int hboard_no) {
		return mapper.delete(hboard_no) > 0 ? true : false;
	}

	// 조회수 처리
	@Override
	public int viewCount(int hboard_no) {
		return mapper.updateViewcount(hboard_no);
	}

	// 답글업데이트(관리자용)
	@Override
	public boolean replyupdate(HostBoardVO vo) {
		return mapper.replyupdate(vo) > 0 ? true : false;
	}
	
	// 관리자 페이지 목록 정렬 조건(관리자용) 22.09.27 추가
	@Override
	public List<HostBoardVO> selectList(HostBoardVO vo) {
		return mapper.selectList(vo);
	}
	

	//이하 빛찬(호스트 마이페이지의 내가 남긴 문의글)--------------------
		@Override
		public Map index_in_mypage(HostBoardVO vo) {
			
			int totalCount = mapper.count_in_mypage(vo); //총 게시물수
			int totalPage = totalCount / vo.getPageRow(); //총 페이지수
			
			if (totalCount % vo.getPageRow() > 0 ) totalPage++;
			
			/*
			 * 총 게시물 수 12개 총 페이지는 12 / 한 페이지에 표시되는 행(게시물개수) 수 10개 1페이지(10행), 2행 12 % 10 > 0
			 */
			
			// 페이지별 시작 인덱스 mySQL 에서는 시작이 0부터니까 
			int startIdx = (vo.getPage() - 1 ) * vo.getPageRow();
			vo.setStartIdx(startIdx);
			List<HostBoardVO> list = mapper.list_in_mypage(vo);
			
			// 페이징처리
			int endPage = (int)(Math.ceil(vo.getPage()/10.0) * 10);
			int startPage = endPage - 9;
			
			if (endPage > totalPage) endPage = totalPage;
			
			boolean prev = startPage > 1 ? true : false;
			boolean next = endPage < totalPage ? true : false;
			
			Map map = new HashMap();
			map.put("totalCount", totalCount);
			map.put("totalPage", totalPage);
			map.put("startIdx", startIdx);
			map.put("endPage", endPage);
			map.put("startPage", startPage);
			map.put("prev", prev);
			map.put("next", next);
			map.put("list", list);
			return map;
		}

	

	
}
