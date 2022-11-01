package kr.co.hotel.main;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hotel.admin.AdminVO;
import kr.co.hotel.host.HostVO;
import kr.co.hotel.favorite.FavoriteVO;
import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.review.ReviewVO;
import kr.co.hotel.room.RoomVO;
import lombok.AllArgsConstructor;

@Controller
@ComponentScan
@AllArgsConstructor
public class HotelController {

	HotelService service;
	
	@GetMapping("/main/main.do")
	public String Main(HotelVO vo, Model model) {
		model.addAttribute("data",service.hotelTopFive(vo, model));
		model.addAttribute("list", service.stateInfo(vo));
		return "/main/main";
	}
	
	@GetMapping("/main/search.do")
	public String searchList(HotelVO vo, Model model, @RequestParam("selectbox_state") int state_code) {
		model.addAttribute("state", service.stateInfo(vo));
		model.addAttribute("hotelList",service.searchList(vo));
		vo.setState_code(state_code);
		List list = service.getDistrict(vo);
		model.addAttribute("district",list);
		return "/main/search";
	}
	
	@PostMapping("/main/district.do")
	@ResponseBody
	public List selectBox(HotelVO vo, Model model) {
		List list = service.getDistrict(vo);
		System.out.println(list);
		return list;
	}
	
	@PostMapping("/main/sortType.do")
	public String sortType(HotelVO vo, Model model, @RequestParam("sortType") String sortType) {
		vo.setSortType(sortType);
		model.addAttribute("hotelList",service.searchList(vo));
		return "/main/sortType";
	}
	
	@GetMapping("/main/hotelView.do")
	public String hotelView(HotelVO vo, Model model, HttpSession sess, FavoriteVO fvo) {
		//"찜하기" 구현 중_빛찬
		GuestVO guestInfo = (GuestVO)sess.getAttribute("loginInfo");
		if(guestInfo != null) {
			
		int guest_no = guestInfo.getGuest_no();
		int hotel_no = vo.getHotel_no();
		fvo.setGuest_no(guest_no);
		fvo.setHotel_no(hotel_no);
		FavoriteVO rev = service.get_favorite(fvo);
		model.addAttribute("rev", rev);
		}
		//END-"찜하기" 구현 중_빛찬
		
		
		model.addAttribute("hotel",service.hotelView(vo.getHotel_no()));//호텔이름가져오기
		List<HotelVO> hotelImage = service.getHotelImage(vo.getHotel_no());//호텔사진 가져오기
		model.addAttribute("hotelImage",hotelImage);
		
		List<RoomVO> roomList = service.roomList(vo.getHotel_no()); //a호텔의 객실들
		for (RoomVO list : roomList) {
			list.setImageList(service.getRoomImage(list.getRoom_no()));
		}
		model.addAttribute("room",roomList);
		System.out.println("===================="+roomList);
		return "/main/hotelView";
	}
	
	@GetMapping("/admin/main/confirm.do")
	public String confirm(AdminVO avo, HostVO hvo, Model model) {
		model.addAttribute("view",service.hostView(hvo.getHost_no()));
		System.out.println("================"+service.hostView(hvo.getHost_no()).get("imageH"));
		return "/admin/main/confirm";
	}
	
	//=====================이하 형욱================================
	
	@GetMapping("/main/map.do")
	public String map(HotelVO vo, Model model) {
		model.addAttribute("hotel", service.hotelView(vo.getHotel_no()));
		return "/main/map";
	}

}
