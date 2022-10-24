package kr.co.hotel.HRRegister;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hotel.host.HostVO;
import kr.co.hotel.main.HotelVO;
import kr.co.hotel.room.RoomVO;

@Service
public class HRRegisterServiceImpl implements HRRegisterService {

	@Autowired
	HRRegisterMapper mapper;
	
	@Override
	public Map index(RoomVO vo) {
		
		int totalCount = mapper.count(vo);//총개시물 수
		//총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if(totalCount % vo.getPageRow() > 0) totalPage++;
		
		//시작 인덱스
		int startIdx = (vo.getPage()-1)*vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<RoomVO> list = mapper.list(vo);
		
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

	@Override
	public RoomVO view(int no) {
		return mapper.view(no);
	}

	@Override
	public RoomVO edit(int no) {
		return mapper.view(no);
	}

	@Override
	public boolean update(RoomVO vo) {
		return mapper.update(vo) >0?true:false;
	}
	
	@Override
	public boolean H_update(HotelVO vo) {
		return mapper.H_update(vo) > 0 ? true : false;
	}

	@Override
	public boolean delete(ImageVO ivo) {
		//회원 삭제시, 회원테이블만 인스턴스만 지우는 것이 아니라 relation이 걸려있는 테이블을 모두 찾아서 delete해야한다.
		boolean r = false;
		if(mapper.delete(ivo.getNo())>0) {
			int a = mapper.delete_img(ivo);
			if(a>=0) {
				r = true;
			}
		}return r ;
	}
	
	@Override
	public boolean H_delete(ImageVO ivo) {
		//회원 삭제시, 회원테이블만 인스턴스만 지우는 것이 아니라 relation이 걸려있는 테이블을 모두 찾아서 delete해야한다.
		boolean r = false;
		if(mapper.H_delete(ivo.getNo())>0) {
			int a = mapper.H_delete_img(ivo);
			if(a>=0) {
				r = true;
			}
		}return r ;

	}

	@Override
	public boolean insert(RoomVO vo) {
		return mapper.insert(vo) > 0 ? true : false;
	}

	@Override
	public boolean img_insert(ImageVO ivo) {
		return mapper.img_insert(ivo) > 0 ? true : false;
	}

	@Override
	public HotelVO get_hotelInfo(int host_no) {
		return mapper.get_hotelInfo(host_no);
	}
	
	@Override
	public HotelVO get_hotelview(int hotel_no) {
		return mapper.get_hotelview(hotel_no);
	}

	@Override
	public RoomVO get_roomInfo() {
		return mapper.get_roomInfo();
	}

	@Override
	public List<ImageVO> get_imgList(ImageVO ivo) {
		return mapper.get_imgList(ivo);
	}

	@Override
	public boolean hotel_insert(HotelVO hvo) {
		return mapper.hotel_insert(hvo) > 0 ? true : false;
	}

	@Override
	public List<HotelVO> get_district_code(HotelVO hvo) {
		
		return mapper.get_district_code(hvo);
	}

	@Override
	public boolean toAdmin(RoomVO vo, HotelVO hvo) {
		System.out.println("=============="+vo.getHost_no());
		System.out.println(hvo.getHost_no());
		boolean r = mapper.room_toAdmin(vo);
		boolean h = mapper.hotel_toAdmin(hvo);
		System.out.println("결과"+r);
		System.out.println("결과"+h);
		if(r||h) {
			return true;
		}
		return false;
	}

	@Override
	public int update_host_no(HostVO vo) {
		return mapper.update_host_no(vo);
	}

	@Override
	public HostVO get_hostInfo(HostVO vo) {
		return mapper.get_hostInfo(vo);
	}

	@Override
	public boolean delImg(int image_no) {
		return  mapper.delImg(image_no) > 0? true : false;
	}



	

	

}
