package kr.co.hotel.room;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;

@Controller
@ComponentScan
@AllArgsConstructor
public class RoomController {

	RoomService service;
	
	@GetMapping("/main/roomView.do")
	public String roomView(RoomVO vo, Model model) {
		model.addAttribute("roomInfo", service.roomView(vo.getRoom_no())); //첫번째 리스트 : n개의 객실정보
		List<RoomVO> roomList = service.getRoomImage(vo.getRoom_no()); //두번째 리스트 : 객실마다 n개의 객실이미지
		model.addAttribute("roomImage",roomList);
		model.addAttribute("review",service.getReviewList(vo.getRoom_no()));
		return "/main/roomView";
	}

}
