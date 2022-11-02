package kr.co.hotel.HRRegister;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hotel.host.HostMapper;
import kr.co.hotel.host.HostVO;
import kr.co.hotel.main.HotelVO;
import kr.co.hotel.room.RoomVO;
import util.ImgHandling;

@Controller
public class HRRegisterController {

	@Autowired
	HRRegisterService service;
	
	@Autowired
	HostMapper hmapper;
	
	//-----------이하 객실----------------
	
	//객실, 호텔 등록 리스트
	@GetMapping("/room/index.do")
	public String index(Model model,HotelVO hvo, RoomVO vo, HttpSession sess, HttpServletRequest req) {
		
		
		HostVO Host_loginInfo = (HostVO)(sess.getAttribute("loginInfo2"));
		vo.setHost_no(Host_loginInfo.getHost_no());
		
		model.addAttribute("data", service.index(vo));
		//-----------이하 호텔--------------------------------
		HotelVO hotelInfo = service.get_hotelInfo(Host_loginInfo.getHost_no());//1개의 호텔 인스턴스를 불러옴
		if(hotelInfo != null) {
			model.addAttribute("Hdata", hotelInfo);
		}else {
			model.addAttribute("Hdate","");
		}
		return "room/index";//검색...포함?
	}
	
	//객실 등록 페이지
	@GetMapping("/room/write.do")
	public String write() {
		//로그인세션이 없으면 들어갈 수 없도록 처리
		return"/room/write";
	}
	
	@PostMapping("/room/insert.do")
	public String insert(RoomVO vo, ImageVO ivo, Model model, @RequestParam("filename") List<MultipartFile> filename, HttpServletRequest req ) {
		
		HttpSession sess = req.getSession();
		//세션에서 host_no를 가져옴, host_no로 hotel테이블에서 hotel_no를 가져옴
		HostVO Host_loginInfo = (HostVO) sess.getAttribute("loginInfo2");
		
		vo.setHost_no(Host_loginInfo.getHost_no());
		HotelVO hotelInfo = service.get_hotelInfo(vo.getHost_no());
		vo.setHotel_no(hotelInfo.getHotel_no());   
		
		ivo.setImage_type("ROOM");
		ImgHandling ih = new ImgHandling();//파일명을 org와 real 구분 후, map에 담아 반환하고 파일을 저장
		
		if(service.insert(vo)) {
			RoomVO latest =service.get_roomInfo();//바로 윗줄 insert 실행시 발생되는 room_no를 구해와 image테이블에 room_no를 같이 insert함
			vo.setRoom_no(latest.getRoom_no());
			ivo.setNo(latest.getRoom_no());
			
			//이미지 insert처리
			if(!filename.get(0).isEmpty()) {//filename이 비어있는지 확인
				for(int i=0; i<filename.size(); i++) {
					Map map = ih.imghandle(filename.get(i), req);
					ivo.setFilename_org((String)map.get("filename_org"));
					ivo.setFilename_real((String)map.get("filename_real"));
					ivo.setImage_order(i);
					boolean r= service.img_insert(ivo);
					System.out.println(	"imgInsert : " + r);
				}
			}
			
			model.addAttribute("msg", "정상적으로 저장되었습니다");
			model.addAttribute("url", "index.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패하였습니다.");
			return "common/alert";
		}
	}
	
	@GetMapping("/room/view.do")
	public String view(RoomVO vo, Model model, ImageVO ivo) {
		RoomVO data = service.view(vo.getRoom_no());
		ivo.setNo(vo.getRoom_no());
		ivo.setImage_type("ROOM");
		
		List<ImageVO> imgList = service.get_imgList(ivo);
		
		model.addAttribute("data", data);
		model.addAttribute("imgList", imgList);
		return "room/view";
	}
	
	
	@GetMapping("/room/edit.do")
	public String edit(RoomVO vo, Model model, ImageVO ivo) {
		RoomVO data = service.edit(vo.getRoom_no());
		ivo.setNo(vo.getRoom_no());
		ivo.setImage_type("ROOM");
		List<ImageVO> imgList = service.get_imgList(ivo);
		model.addAttribute("data", data);
		model.addAttribute("imgList", imgList);
		
		return "room/edit";
	}
	
	 @PostMapping("/room/update.do")	
	 public String update(RoomVO vo, Model model, ImageVO ivo,  @RequestParam("filename") List<MultipartFile> filename, HttpServletRequest req ) {
		 //수정내용 update
		 boolean r = false;
		 r = service.update(vo);
		 
		 ivo.setNo(vo.getRoom_no());
		 ivo.setImage_type("ROOM");
		 ImgHandling ih = new ImgHandling();
		 
		//이미지 insert처리
			if(!filename.get(0).isEmpty()) {//filename이 비어있는지 확인
				for(int i=0; i<filename.size(); i++) {
					Map map = ih.imghandle(filename.get(i), req);
					ivo.setFilename_org((String)map.get("filename_org"));
					ivo.setFilename_real((String)map.get("filename_real"));
					ivo.setImage_order(i);
					r= service.img_insert(ivo);
					System.out.println("imgInsert : " + r);
				}
			}
		 
		 if(r) {
			 model.addAttribute("msg","정상적으로 수정되었습니다");
			 model.addAttribute("url","view.do?room_no="+vo.getRoom_no());
			 return"common/alert";
		 }else {
			 model.addAttribute("msg","수정 실패");
			 return"common/alert";
		 }
	 }
	 
	 @GetMapping("/room/delImg.do")//객실 수정 페이지에서 ajax로 이미지 삭제
	 @ResponseBody
	 public boolean delImg(ImageVO ivo, @RequestParam int image_no) {
		 System.out.println("이미지번호	 : "+ivo.getImage_no());
		 System.out.println("이미지번호 : "+image_no);
		 return service.delImg(ivo.getImage_no());
	 }
	 
	 	 
	 @GetMapping("/room/delete.do")	
	 public String delete(RoomVO vo, Model model, ImageVO ivo) {
		 ivo.setNo(vo.getRoom_no());
		 if(service.delete(ivo)) {
			 model.addAttribute("msg","정상적으로 삭제되었습니다");
			 model.addAttribute("url","index.do");
			 return"common/alert";
		 }else {
			 model.addAttribute("msg","삭제 실패");
			 return"common/alert";
		 }
	 }
	 
	 
	 
	//-----------이하 호텔---------------------------------------------------------------------

		@GetMapping("/myhotel/write.do")
		public String hotelWrite() {
			return"/hotel/write";
		}
		
		// 호텔등록페이지 지역코드 ajax
		@PostMapping("/myhotel/district.do")
		@ResponseBody
		public List<HotelVO> district(HotelVO vo, Model model) {
			System.out.println("지역코드확인 : "+vo.getState_code());
			return service.get_district_code(vo);
		}
		
		@PostMapping("/myhotel/insert.do")
		public String hotel_insert(HostVO vo ,HotelVO hvo, ImageVO ivo, Model model, @RequestParam("filename2") List<MultipartFile> filename, HttpServletRequest req, HttpSession sess ) {
			
			HostVO Host_loginInfo = (HostVO)sess.getAttribute("loginInfo2");
			
			hvo.setHost_no(Host_loginInfo.getHost_no());//hvo에 세션으로부터 host_no를 넣어줌
			vo.setHost_no(Host_loginInfo.getHost_no());
			ivo.setImage_type("HOTEL");
			ImgHandling ih = new ImgHandling();//파일명을 org와 real 구분 후, map에 담아 반환하고 파일을 저장
			
			System.out.println("hvo확인 : "+ hvo);
			
			if(service.hotel_insert(hvo)) {
				//호텔정보 입력 후, 호스트 테이블에 hotel_no 업데이트
				vo.setHotel_no(hvo.getHotel_no());
				int no =service.update_host_no(vo);
				System.out.println("업데이트확인 : "+ no);
				
				//이미지 insert처리
				if(!filename.get(0).isEmpty()) {//filename이 비어있는지 확인
					ivo.setNo(hvo.getHotel_no());
					for(int i=0; i<filename.size(); i++) {
						Map map = ih.imghandle(filename.get(i), req);
						ivo.setFilename_org((String)map.get("filename_org"));
						ivo.setFilename_real((String)map.get("filename_real"));
						ivo.setImage_order(i);
						boolean r= service.img_insert(ivo);
						System.out.println("imgInsert : " + r);
					}
				}
				Host_loginInfo = service.get_hostInfo(vo);
				sess.setAttribute("loginInfo2", Host_loginInfo);
				
				model.addAttribute("msg", "정상적으로 저장되었습니다");
				model.addAttribute("url", "../room/index.do");
				return "common/alert";
			}else {
				model.addAttribute("msg", "저장 실패하였습니다.");
				return "common/alert";
			}
		}
		
		
		@GetMapping("/myhotel/view.do")
		public String H_view(HotelVO hvo, Model model, ImageVO ivo) {
			
			HotelVO data = service.get_hotelview(hvo.getHotel_no());
			model.addAttribute("data", data);
			
			ivo.setNo(hvo.getHotel_no());
			ivo.setImage_type("HOTEL");
			
			List<ImageVO> imgList = service.get_imgList(ivo);
			model.addAttribute("imgList", imgList);
					
			return "hotel/view";
		}
		
		
		@GetMapping("/myhotel/edit.do")
		public String H_edit(HotelVO hvo, Model model, ImageVO ivo) {
			HotelVO data = service.get_hotelview(hvo.getHotel_no());
			System.out.println("코드확인 : "+data.getState_code());
			ivo.setNo(hvo.getHotel_no());
			ivo.setImage_type("HOTEL");
			List<ImageVO> imgList = service.get_imgList(ivo);
			model.addAttribute("data", data);
			model.addAttribute("imgList", imgList);
			
			return "hotel/edit";
		}
	
		
		 @PostMapping("/myhotel/update.do")	
		 public String H_update(Map mapp, HotelVO hvo, Model model,ImageVO ivo, @RequestParam("filename2") List<MultipartFile> filename, HttpServletRequest req) {
			 System.out.println("vo 확인 : "+ hvo+mapp);
			 
			 ivo.setNo(hvo.getHotel_no());
			 ivo.setImage_type("HOTEL");
			 ImgHandling ih = new ImgHandling();
			
			//이미지 insert처리
				if(!filename.get(0).isEmpty()) {//filename이 비어있는지 확인
					for(int i=0; i<filename.size(); i++) {
						Map map = ih.imghandle(filename.get(i), req);
						ivo.setFilename_org((String)map.get("filename_org"));
						ivo.setFilename_real((String)map.get("filename_real"));
						ivo.setImage_order(i);
						boolean r= service.img_insert(ivo);
						System.out.println("imgInsert : " + r);
					}
				}
			 
			 if(service.H_update(hvo)) {
				 model.addAttribute("msg","정상적으로 수정되었습니다");
				 model.addAttribute("url","view.do?hotel_no="+hvo.getHotel_no());
				 return"common/alert";
			 }else {
				 model.addAttribute("msg","수정 실패");
				 return"common/alert";
			 }
		 }
		 
		 
		 @GetMapping("/myhotel/delete.do")	
		 public String H_delete(HotelVO hvo, Model model, ImageVO ivo) {
			 ivo.setNo(hvo.getHotel_no());
			 
			 if(service.H_delete(ivo)) {
				 model.addAttribute("msg","정상적으로 삭제되었습니다");
				 model.addAttribute("url","../room/index.do");
				 return"common/alert";
			 }else {
				 model.addAttribute("msg","삭제 실패");
				 return"common/alert";
			 }
		 }
		 
		 
		//-----------이하 호텔---------------------------------------------------------------------		 
		 
		 @GetMapping("/myhotel/toAdmin.do")	
		 public String HRRegister(RoomVO vo, HotelVO hvo, Model model) {
			 if(service.toAdmin(vo, hvo)) {
				 model.addAttribute("msg","관리자에게 정상적으로 신청되었습니다");
				 model.addAttribute("url","../room/index.do");
				 return"common/alert";
			 }else {
				 model.addAttribute("msg","신청 실패");
				 return"common/alert";
			 }
		 }
		 
		 
}
