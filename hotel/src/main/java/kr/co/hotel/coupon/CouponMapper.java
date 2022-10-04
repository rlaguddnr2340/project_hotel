package kr.co.hotel.coupon;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.hotel.guest.GuestVO;

@Mapper
public interface CouponMapper {

	//게스트 목록 출력
	public List<GuestVO> list(Map map);
	
	//특정 게스트 정보 출력
	public GuestVO selectGuestNo(String guest_id);
	
	//쿠폰 번호 중복 체크
	public int couponNodup(CouponVO vo);
	
	//쿠폰 생성
	public int createCoupon(CouponVO vo);
	
	//쿠폰 발급 리스트
	public int counthistory();
	public List<CouponVO> couponpaging(CouponVO vo);
	
	//---이하 빛찬-----------------------------------
	public int count (CouponVO vo);
	public List<CouponVO> C_list(CouponVO vo);
	
	
}
