package kr.co.hotel.guestnotice;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hotel.admin.AdminVO;

@Controller
public class Admin_GuestNoticeController {

	@Autowired
	GuestNoticeService service;

	// 목록
	@GetMapping("/admin/main/guestboard/notice/list.do")
	public String index(Model model, GuestNoticeVO vo, HttpSession sess) {

		model.addAttribute("data", service.index(vo));
		return "admin/main/guestboard/notice/list";

	}

	// 조회
	@GetMapping("/admin/main/guestboard/notice/view.do")
	public String view(Model model, int gnotice_no, GuestNoticeVO vo) {
		service.updateViewcount(gnotice_no);
		model.addAttribute("data", service.view(gnotice_no));
		vo.setRownum(service.nowRownum(vo).getRownum());

		model.addAttribute("now", service.nowRownum(vo)); // 현재글 rownum
		model.addAttribute("prev", service.prevRownum(vo)); // 이전글 rownum
		model.addAttribute("next", service.nextRownum(vo)); // 다음글 rownum
		return "admin/main/guestboard/notice/view";
	}

	// 등록폼(관리자용)
	@GetMapping("/admin/main/guestboard/notice/write.do")
	public String write() {
		return "admin/main/guestboard/notice/write";
	}

	// 등록처리(관리자용)
	@PostMapping("/admin/main/guestboard/notice/write.do")
	public String insert(Model model, GuestNoticeVO vo, @RequestParam MultipartFile filename, HttpServletRequest req, HttpSession sess) {
		// 첨부파일 처리
		if (!filename.isEmpty()) {
			String org = filename.getOriginalFilename();
			String ext = org.substring(org.lastIndexOf("."));
			String real = new Date().getTime() + ext;

			// 첨부파일 저장처리
			String path = req.getRealPath("/upload/");
			try {
				filename.transferTo(new File(path + real));
			} catch (Exception e) {
			}
			vo.setFilename_org(org);
			vo.setFilename_real(real);
		}

		if (service.insert(vo)) {
			model.addAttribute("msg", "정상적으로 등록되었습니다.");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장 실패했습니다.");
			return "common/alert";
		}
	}

	// 수정폼(관리자용)
	@GetMapping("/admin/main/guestboard/notice/edit.do")
	public String editForm(Model model, GuestNoticeVO vo) {
		
		model.addAttribute("data", service.edit(vo.getGnotice_no()));
		System.out.println(model.getAttribute("data"));
		return "/admin/main/guestboard/notice/edit";
	}

	// 수정처리(관리자용
	@PostMapping("/admin/main/guestboard/notice/edit.do")
	public String update(GuestNoticeVO vo, @RequestParam MultipartFile filename, Model model, HttpServletRequest req) {
	
		// 첨부파일 처리
		if (!filename.isEmpty()) {
			String org = filename.getOriginalFilename();
			String ext = org.substring(org.lastIndexOf("."));
			String real = new Date().getTime() + ext;

			// 첨부파일 저장처리
			String path = req.getRealPath("/upload/");
			try {
				filename.transferTo(new File(path + real));
			} catch (Exception e) {
			}
			vo.setFilename_org(org);
			vo.setFilename_real(real);
		}
		
		if (service.update(vo)) {
			model.addAttribute("data", service.update(vo));
			model.addAttribute("msg", "정상적으로 수정되었습니다");
			model.addAttribute("url", "/hotel/admin/main/guestboard/notice/view.do?gnotice_no=" + vo.getGnotice_no());
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 실패했습니다.");
			return "common/alert";
		}
	}

	// 삭제(관리자용)
	@GetMapping("/admin/main/guestboard/notice/delete.do")
	public String delete(int gnotice_no, Model model, HttpSession sess) {

		if (service.delete(gnotice_no)) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제 실패했습니다.");
			return "common/alert";
		}

	}

}
