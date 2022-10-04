package kr.co.hotel.coupon;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.point.PointVO;

@Service
public interface CouponService {

	//게스트 목록 출력
	public List<GuestVO> list(Map map);
	
	//특정 게스트 정보 출력
	public GuestVO selectGuestNo(String guest_id);
	
	//쿠폰 생성
	public int createCoupon(CouponVO vo);
	
	//쿠폰 페이징
	public Map couponpaging(CouponVO vo);
	
	//---이하 빛찬--------------------------------
	public Map index(CouponVO vo);
	
}
