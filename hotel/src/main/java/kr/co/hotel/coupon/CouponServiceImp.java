package kr.co.hotel.coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.point.PointVO;

@Service
public class CouponServiceImp implements CouponService {

	@Autowired
	CouponMapper mapper;

	//게스트 목록 출력
	@Override
	public List<GuestVO> list(Map map) {
		return mapper.list(map);
	}

	//특정 게스트 정보 출력
	@Override
	public GuestVO selectGuestNo(String guest_id) {
		return mapper.selectGuestNo(guest_id);
	}
	
	//쿠폰 생성
	@Override
	public int createCoupon(CouponVO vo) {
		boolean result=true;
		while(result) {
			String temp="";
			for(int i=0; i<2;i++) {
				temp+=(char)(Math.random()*26+65);
			}
			for(int i=0; i<2;i++) {
				temp+=(char)(Math.random()*26+97);
			}
			temp+="-";
			for(int i=0; i<4;i++) {
				temp +=(int)(Math.random()*9);
			}
			vo.setCoupon_no(temp);
			if(mapper.couponNodup(vo) != 1) {
				break;
			}
			
		}
		return mapper.createCoupon(vo);
	}

	
	
	
	//---이하 빛찬
	
	@Override
	public Map index(CouponVO vo) {
		int totalCount = mapper.count(vo);//총개시물 수
		//총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if(totalCount % vo.getPageRow() > 0) totalPage++;
		
		//시작 인덱스
		int startIdx = (vo.getPage()-1)*vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<CouponVO> list = mapper.C_list(vo);
		
		
		//페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage - 9;
		if(endPage > totalPage) endPage= totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map= new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("page", vo.getPage());
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		return map;

	}


	//쿠폰 페이징
	@Override
	public Map couponpaging(CouponVO vo) {
		int totalCount = mapper.counthistory();//총개시물 수
		//총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if(totalCount % vo.getPageRow() > 0) totalPage++;
		
		//시작 인덱스
		int startIdx = (vo.getPage()-1)*vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<CouponVO> list = mapper.couponpaging(vo);
		
		
		//페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage - 9;
		if(endPage > totalPage) endPage= totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map= new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("page", vo.getPage());
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		return map;
	}

	
	
}
