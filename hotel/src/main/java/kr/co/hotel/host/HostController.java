package kr.co.hotel.host;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
//import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.hotel.admin.AdminVO;
import kr.co.hotel.hostReserve.HostReserveService;
import kr.co.hotel.hostboard.HostBoardService;
import kr.co.hotel.hostboard.HostBoardVO;
import kr.co.hotel.hostnotice.HostNoticeService;
import kr.co.hotel.hostnotice.HostNoticeVO;



@Controller
public class HostController {
	@Autowired
	HostService hservice;
	
	@Autowired
	HostReserveService service;
	
	@Autowired
	HostNoticeService hnservice;
	
	@Autowired
	HostBoardService hbservice;
	
	@GetMapping("/host/join.do")
	public String join() {
		return "host/join";
	}
	
	@PostMapping("/host/join.do")
	public String join(HostVO hvo, Model model) {
		if (hservice.insert(hvo) > 0) {
			model.addAttribute("msg", "정상적으로 회원가입되었습니다.");
			return "host/login";
		} else {
			model.addAttribute("msg", "회원가입오류");
			return "common/alert";
		}
	}
	@GetMapping("/host/login.do")
	public String login(HttpSession sess, Model model) {
		if(sess.getAttribute("loginInfo2")!=null) {
			model.addAttribute("msg", "중복로그인입니다. 로그아웃해주세요");
			return "common/alert";
		}
		return "host/login";
	}
	
	@PostMapping("/host/login.do")
	public String login(HostVO hvo, HttpSession sess, Model model) {
		if (hservice.HostloginCheck(hvo, sess)) {
			return "redirect:/host/mypage.do";
		} else {
			model.addAttribute("msg", "로그인정보를 확인해 주세요");
			return "common/alert";
		}
	}
	
	
	@GetMapping("/host/emailDupCheck.do")
	public void emailDupCheck(@RequestParam String host_email, HttpServletResponse res) throws IOException {
		int count = hservice.emailDupCheck(host_email);
		boolean r = false;
		if (count >= 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	@GetMapping("/host/idDupCheck.do")
	public void idDupCheck(@RequestParam String host_id, HttpServletResponse res) throws IOException {
		int count = hservice.idDupCheck(host_id);
		boolean r = false;
		if (count >= 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	@GetMapping("/host/hpDupCheck.do")
	public void hpDupCheck(@RequestParam String host_hp, HttpServletResponse res) throws IOException {
		int count = hservice.hpDupCheck(host_hp);
		boolean r=false;
		if(count>=1)r=true;
		PrintWriter out=res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/host/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/hotel/host/login.do");
		return "common/alert";
	}
	
	@GetMapping("/host/findHostId.do")
	public String findHostEmail() {
		return "host/findId";
	}
	
	@PostMapping("/host/findHostId.do")
	public String findHostEmail(Model model, HostVO param) {
		HostVO hvo = hservice.findHostId(param);
		if (hvo != null) {
			model.addAttribute("result", hvo.getHost_id());
		}
		return "common/return";
	}
	
	@GetMapping("/host/findHostPwd.do")
	public String findHostPwd() {
		return "host/findPwd";
	}
	
	@PostMapping("/host/findHostPwd.do")
	public String findHostPwd(Model model, HostVO param) {
		HostVO hvo = hservice.findHostPwd(param);
		if (hvo != null) {
			model.addAttribute("result", hvo.getHost_email());
		}
		return "common/return";
	}
	@GetMapping("/host/mypage.do")
	public String mypage(HttpSession sess, Model model, HostNoticeVO vo, HostBoardVO hvo) {
		if(sess.getAttribute("loginInfo2")==null) {
			model.addAttribute("msg","로그인해야 합니다");
			return "common/aleret";
		}else {
			//빛찬_220824
			//해당 호텔의 가용객실 총 수
			HostVO host_loginInfo =(HostVO)sess.getAttribute("loginInfo2");
			int host_no = host_loginInfo.getHost_no();
			System.out.println(host_loginInfo.getHotel_no()+"=====================");
			System.out.println(host_loginInfo.getHost_no()+"=======호스트no확인=============");
			
			int r =service.room_count(host_no);
			model.addAttribute("room_count", service.room_count(host_no));
			System.out.println("==============hotel_no======="+ host_loginInfo.getHotel_no());
			Map map = hservice.get_numbers(host_loginInfo);
			model.addAttribute("map", map);
			//공지사항
			Map map2 =hnservice.index(vo);
			model.addAttribute("map2", map2);
			//문의글
			hvo.setHost_no(host_no);
			Map map3 = hbservice.index_in_mypage(hvo);
			model.addAttribute("map3", map3);
			//END_빛찬_220824
			return "/host/myPage";
		}
	}
	@GetMapping("/host/myinfo.do")
	public String myinfo(HttpSession sess, Model model) {
		if(sess.getAttribute("loginInfo2")==null) {
			model.addAttribute("msg","로그인이 필요한 기능입니다.");
			return "common/alert";
		}else {
			return "/host/myinfoLogin";
		}
	}
	@PostMapping("/host/myinfoLogin.do")
	public void myinfoLogin(HostVO hvo, HttpServletResponse res, HttpSession sess) throws IOException {
		HostVO myinfo=(HostVO)sess.getAttribute("loginInfo2");
		myinfo.setHost_pwd(hvo.getHost_pwd());
		boolean r=false;
		if(hservice.myinfoLogin(myinfo)!=null)r=true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	@PostMapping("/host/myinfoModify.do")
	public String myinfoModify() {
		return "/host/myinfoModify";
	}
	@GetMapping("/host/pwdChangePopup")
	public String pwdChangePopup() {
		return "/host/pwdChangePopup";
	}
	@PostMapping("/host/updatePwd.do")
	public void updatePwd(HttpSession sess, HostVO hvo, HttpServletResponse res) throws IOException {
		HostVO myinfo=(HostVO)sess.getAttribute("loginInfo2");
		myinfo.setHost_pwd(hvo.getHost_pwd());
		boolean r=false;
		if(hservice.updatePwd(myinfo) > 0) {
			r=true;
			PrintWriter out = res.getWriter();
			out.print(r);
			out.flush();
		}
	}
	@PostMapping("/host/update.do")
	public String update(HostVO hvo, Model model) {
		if(hservice.totalUpdate(hvo)) {
			model.addAttribute("msg","자동 로그아웃 됩니다. 다시 로그인해주세요");
			model.addAttribute("url","/hotel/host/logout.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정실패");
			return "common/alert";
		}
	}
	@GetMapping("/host/deleteHostInfo.do")
	public String deleteHost(HttpSession sess,Model model) {
		if(sess.getAttribute("loginInfo2") == null) {
			model.addAttribute("msg","로그인이 필요한 기능입니다");
			return "common/alert";
		}else { 
			return"/host/deleteHost";
			//로그인이 되어 있어야 deleteHost.jsp로 넘어갈수 있음
		}
	}
	@PostMapping("/host/deleteHostInfo.do")
	public void deleteHostInfo(HttpSession sess, HostVO hvo, HttpServletResponse res) throws IOException{
		HostVO myinfo = (HostVO)sess.getAttribute("loginInfo2");
		myinfo.setHost_pwd(hvo.getHost_pwd());
		boolean r=false;
		if(hservice.deleteHostInfo(myinfo) != null)
			r=true;
			PrintWriter out = res.getWriter();
			out.print(r);
			out.flush();
	}
	
	
	
	//==================================이하 원표작성=======================================
	@GetMapping("/admin/main/hostList.do")
	public String hostList(AdminVO vo, Model model) {
		model.addAttribute("hostList",hservice.getHostList(vo));
		return "/admin/main/hostList";
	}
	
	@GetMapping("/admin/main/hostView.do")
	public String hostView(AdminVO avo, HostVO hvo, Model model) {
		model.addAttribute("host", hservice.getView(hvo));
		return "/admin/main/hostView";
	}
	
	
	//==================================이하 빛찬작성=======================================
	
	@GetMapping("/host/sales.do")
	public String sales(HttpSession sess, Model model) {
		HostVO host_info = (HostVO)sess.getAttribute("loginInfo2");
		Map map = hservice.get_sales(host_info.getHotel_no());
		model.addAttribute("map", map);
		
		
		return "host/sales";
	}
	
	

	
	  //캘린더 테이블 만드는 메소드
	  
	  @GetMapping("/host/test.do") 
	  public void making() {
	  
		  LocalDate now =LocalDate.now(); 
		  Map map = new HashMap();
	  
		  for(int i = -365; i<4000; i++ ) { 
			  map.put("date", now.plusDays(i));
			  map.put("day", now.plusDays(i).getDayOfWeek());
			  hservice.making_calendar(map); 
			  }
	  
	  }
	 
	 
}