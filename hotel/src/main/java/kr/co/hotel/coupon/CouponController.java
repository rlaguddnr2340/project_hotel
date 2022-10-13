package kr.co.hotel.coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hotel.admin.AdminVO;
import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.point.PointVO;


@Controller

public class CouponController {
	
	@Autowired
	CouponService service;
	
	//--------이하 빛찬--------------------------------------------------
	
	@GetMapping("/coupon/index.do")
	public String list(CouponVO vo, Model model, HttpSession sess) {
		try {
			
		//GuestMemberVO loginInfo = (GuestMemberVO)sess.getAttribute("loginInfo"); 		//세션에서 guest_no를 불러옵니다.
		//GuestVO loginInfo1 = new GuestVO();//demo GuestMemberVO()
		//loginInfo1.setGuest_no(25); //demo guest_no 
		//loginInfo1.setGuest_name("호스트_빛찬");
		//sess.setAttribute("loginInfo", loginInfo1);
		
		GuestVO loginInfo= (GuestVO)sess.getAttribute("loginInfo");
		vo.setGuest_no(loginInfo.getGuest_no());
		Map map = service.index(vo);
		model.addAttribute("coupon", map);
		
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("pointController에서 예외발m생!");
		}
		return "coupon/index";
	}
	
	//=====================쿠폰 admin내용 추가=========================
	
	//admin 쿠폰 생성 페이지
	@GetMapping("/admin/main/coupon/couponcreate.do")
	public String couponcreate(AdminVO avo,HttpSession sess, Model model) {
		return "/admin/main/coupon/couponcreate";
	}
	
	//게스트 목록 리스트 출력
	@GetMapping("coupon/idList.do")
	public String idList(Model model, @RequestParam(required = false) String sword) {
		Map map = new HashMap();
		map.put("sword", sword);
		model.addAttribute("data",service.list(map));
		return "/admin/main/coupon/idList";
	}
	
	//쿠폰 생성
	@PostMapping("coupon/create.do")
	public String createpro(GuestVO gvo, CouponVO cvo, 
			@RequestParam List<String> guest_id, 
			@RequestParam List<Integer>coupon_price,
			@RequestParam List<Integer>amount) {
		
		for(String id : guest_id) {
			for(int i=0; i<coupon_price.size(); i++) {
				for(int j=0; j<amount.get(i); j++) {
					cvo.setGuest_no((service.selectGuestNo(id)).getGuest_no());//1
					cvo.setCoupon_price(coupon_price.get(i));
					service.createCoupon(cvo);
				}
			}
		}
			return "/admin/main/coupon/couponcreate";
	}
	
	//쿠폰 발급내역
	@GetMapping("/admin/main/coupon/couponhistory.do")
	public String couponhistory(Model model, CouponVO vo) {
		Map map = service.couponpaging(vo);
		model.addAttribute("couponpaging", map);
		return "/admin/main/coupon/couponhistory";
	}
	
	
}
