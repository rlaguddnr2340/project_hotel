package kr.co.hotel.guestboard;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import util.ImgHandling;

@Controller
public class Admin_GuestBoardController extends ImgHandling {

	@Autowired
	GuestBoardService service;

	// 목록
	@GetMapping("/admin/main/guestboard/qna/list.do")
	public String index(Model model, GuestBoardVO vo) {
		model.addAttribute("data", service.index(vo));
		return "admin/main/guestboard/qna/list";
	}

	// 관리자 검색조건 (22.10.04 수정, 10.06 최종 수정완료)
	@PostMapping("/admin/main/guestboard/qna/list.do")
	@ResponseBody
	public ResponseObj adminList(GuestBoardVO vo) {
		ResponseObj resObj = new ResponseObj();
		Map map = service.index(vo);
		resObj.setTotalCount((int) map.get("totalCount"));
		resObj.setTotalPage((int) map.get("totalPage"));
		resObj.setPage(vo.getPage());
		resObj.setObjList(service.adminList(vo));
		System.out.println("=============================" + resObj);
		return resObj;
	}

	// 조회
	@GetMapping("/admin/main/guestboard/qna/view.do")
	public String view(Model model, GuestBoardVO vo) {
		// System.out.println(vo.get);
		service.viewCount(vo.getGboard_no());
		System.out.println("==========================" + vo.getGboard_no());
		GuestBoardVO gvo = service.view(vo.getGboard_no());
		model.addAttribute("data", gvo);
		System.out.println("==============================" + gvo.getGuest_name());
		return "admin/main/guestboard/qna/view";
	}

	// 답글달기 폼
	@GetMapping("/admin/main/guestboard/qna/answer.do")
	public String editForm(Model model, GuestBoardVO vo) {
		model.addAttribute("data", service.edit(vo.getGboard_no()));
		System.out.println("======================================" + model.getAttribute("data"));
		return "admin/main/guestboard/qna/answer";
	}

	// 답글달기 처리
	@PostMapping("/admin/main/guestboard/qna/answer.do")
	public String update(GuestBoardVO vo, Model model, HttpSession sess) {

		if (service.replyupdate(vo)) {
			model.addAttribute("data", service.replyupdate(vo));
			model.addAttribute("msg", "정상적으로 답변 등록되었습니다");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 실패했습니다.");
			return "common/alert";
		}
	}

	// 삭제처리
	@GetMapping("/admin/main/guestboard/qna/delete.do")
	public String delete(GuestBoardVO vo, Model model) {
		if (service.delete(vo.getGboard_no())) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제 실패했습니다.");
			return "common/alert";
		}
	}

	// api 목록 url 호출 (22.09.28 - 22.09.29)
	@GetMapping("/test/guestboard/qna/list.do")
	public String api(GuestBoardVO vo, HttpServletResponse res, Model model, Object objList) throws Exception {
		String apiUrl = "http://localhost:8080//hotel/admin/main/guestboard/qna/list.do";

		URL url = new URL(apiUrl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("POST");

		InputStreamReader streamReader = new InputStreamReader(con.getInputStream());

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			String jsonString = responseBody.toString();
				
			JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParse.parse(jsonString); // json 객체니까 JSONObject로 객체화해준다. {}
			
			JSONArray jsonArr = (JSONArray) jsonObj.get("objList"); // objList가 배열이므로 
			
			System.out.println("jsonArr========================"+jsonArr);
			
			List<GuestBoardVO> boardList = new ArrayList<GuestBoardVO>(); // 데이터를 저장할 List
			for (int i = 0; i < jsonArr.size(); i++) {
				GuestBoardVO vo2 = new GuestBoardVO(); // GuestBoardVO 객체 생성

				JSONObject newJsonObj = (JSONObject) jsonArr.get(i);
				// System.out.println(newJsonObj.get("gboard_no"));
				vo2.setGboard_no(Integer.parseInt(String.valueOf(newJsonObj.get("gboard_no"))));
				vo2.setGboard_type(Integer.parseInt(String.valueOf(newJsonObj.get("gboard_type"))));
				vo2.setGboard_viewcount(Integer.parseInt(String.valueOf(newJsonObj.get("gboard_viewcount"))));
				vo2.setGboard_content(String.valueOf(newJsonObj.get("gboard_content")));
//				System.out.println(newJsonObj.get("gboard_regdate"));

				Long regdate = Long.parseLong(String.valueOf(newJsonObj.get("gboard_regdate"))); // Object->String->Long
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 날짜포맷지정

				System.out.println(sdf.format(new Timestamp(regdate))); // Long타입의 날짜값을 Timestamp타입으로 변경->날짜포맷지정

				vo2.setGboard_regdate(new Timestamp(regdate));
				vo2.setGboard_title(String.valueOf(newJsonObj.get("gboard_title")));
				vo2.setGboard_status(Integer.parseInt(String.valueOf(newJsonObj.get("gboard_status"))));
				vo2.setGboard_writer(String.valueOf(newJsonObj.get("gboard_writer")));
				
				boardList.add(vo2);

//				System.out.println(newJsonObj.get("gboard_title"));
//				boardList.add(newJsonObj);
			}
			System.out.println(boardList);
			model.addAttribute("boardList", boardList); // jsp에서 출력할 수 있도록 model에 boardList 담기
		} catch (NumberFormatException e) {
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
		System.out.println("=================================api");
		return "test/apiTest";
	}

}
