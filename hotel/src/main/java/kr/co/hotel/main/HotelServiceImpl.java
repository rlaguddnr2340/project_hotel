package kr.co.hotel.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.hotel.HRRegister.ImageVO;
import kr.co.hotel.favorite.FavoriteVO;
import kr.co.hotel.room.RoomVO;

@Service
public class HotelServiceImpl implements HotelService {
	
	@Autowired
	HotelMapper mapper;

	@Override
	public List<HotelVO> searchList(HotelVO vo) {
		return mapper.searchList(vo);
	}

	@Override
	public Model hotelTopFive(HotelVO vo, Model model) {
		vo.setState_code(11);
		model.addAttribute("listSeoul",mapper.hotelTopFive(vo));
		vo.setState_code(23);
		model.addAttribute("listIncheon",mapper.hotelTopFive(vo));
		vo.setState_code(31);
		model.addAttribute("listKyeonggi",mapper.hotelTopFive(vo));
		return model;
	}

	@Override
	public List<HotelVO> getDistrict(HotelVO vo) {
		return mapper.getDistrict(vo);
	}
	
	@Override
	public List<HotelVO> stateInfo(HotelVO vo) {
		return mapper.getState(vo);
	}

	@Override
	public int searchCount(HotelVO vo) {
		return mapper.searchCount(vo);
	}

	@Override
	public List<RoomVO> roomList(int hotel_no) {
		return mapper.roomList(hotel_no);
	}

	@Override
	public HotelVO hotelView(int hotel_no) {
		return mapper.hotelView(hotel_no);
	}

	@Override
	public List<HotelVO> getHotelImage(int hotel_no) {
		return mapper.getHotelImage(hotel_no);
	}

	@Override
	public List<ImageVO> getRoomImage(int room_no) {
		return mapper.getRoomImage(room_no);
	}

	@Override
	public void setConfirm(HotelVO vo) {
		mapper.setConfirm(vo);
		
	}

	@Override
	public Map hostView(int host_no) {
		Map map = new HashMap();
		map.put("room",mapper.getHostRoom(host_no));
		map.put("hotel",mapper.getHostHotel(host_no));
		map.put("imageR",mapper.getHostRoomImage(host_no));
		map.put("imageH",mapper.getHostHotelImage(host_no));
		return map;
	}
	
	public FavoriteVO get_favorite(FavoriteVO fvo) {
		
		return mapper.get_favorite(fvo);
	}


}

