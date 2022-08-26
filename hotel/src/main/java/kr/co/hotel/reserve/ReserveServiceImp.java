package kr.co.hotel.reserve;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.host.HostVO;
import kr.co.hotel.main.HotelVO;
import kr.co.hotel.room.RoomVO;

@Service
public class ReserveServiceImp implements ReserveService {

	@Autowired
	ReserveMapper mapper;
	
	@Override
	public GuestVO select(GuestVO vo) {
		return mapper.select(vo);
	}

	@Override
	public synchronized int insert(ReserveVO vo,GuestVO gvo) {
		int data = mapper.reservecheck(vo);
		if(data !=0) {
			return data;
		}else {
			mapper.insert(vo);
			mapper.guestUsedPointUpdate(gvo);
			if(vo.getUsed_point() !=0) {
				mapper.pointinsert(vo);
			}
			mapper.updateCoupon(vo);
			return data;
		}
	}

	@Override
	public int reservecheck(ReserveVO vo) {
		return mapper.reservecheck(vo);
	}
	
	
	//--이하 마이페이지 예약내역리스트_빛찬--------------------
	@Override
	public Map index(ReserveVO vo) {
		
		int totalCount = mapper.count(vo);//총개시물 수
		//총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if(totalCount % vo.getPageRow() > 0) totalPage++;
		
		//시작 인덱스
		int startIdx = (vo.getPage()-1)*vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<ReserveVO> list = mapper.list(vo);
		
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
	public List<GuestVO> couponlist(GuestVO vo) {
		return mapper.couponlist(vo);
	}

	@Override
	public int CouponDelete() {
		return mapper.CounponDelete();
	}

	@Override
	public int PointDeposit(ReserveVO vo, GuestVO gvo) {
		mapper.UpdatePointDeposit(vo);
		int point_depoist = (int)(vo.getTotal_price()*0.09);
		gvo.setTotalpoint(gvo.getTotalpoint()+point_depoist);
		mapper.guestUsedPointUpdate(gvo);
		vo.setUsed_point(point_depoist);
		mapper.UpdatePointDeposit(vo);
		return mapper.InsertPointDeposit(vo);
	}

	@Override
	public HostVO SelectHostNo(HotelVO vo) {
		vo.setHost_no(mapper.SelectHostNo(vo).getHost_no());
		return mapper.SelectHostAccount(vo);
	}

	@Override
	public HotelVO SelectHotelInfo(HotelVO vo) {
		return mapper.SelectHostNo(vo);
	}

	@Override
	public RoomVO SelectRoomInfo(ReserveVO vo) {
		return mapper.SelectRoominfo(vo);
	}

	@Override
	public ReserveVO SelectReserveInfo(ReserveVO vo) {
		return mapper.SelectReserveInfo(vo);
	}

	@Override
	public ReserveVO UpdatePay_Status(ReserveVO vo) {
		return mapper.UpdatePay_Status(vo);
	}

	@Override
	public void DeleteAccountPay() {
		mapper.DeleteAccountPay();
	}

	
	//스케줄러로 자동취소메소드 구현
	@Override
	public List<ReserveVO> CancleList() {
		return mapper.CancleList();
	}

	@Override
	public int UpdateReserveStatus(ReserveVO vo) {
		return mapper.cancelReserve(vo);
	}

	@Override
	public int UpdateGuestPoint(ReserveVO vo) {
		return mapper.UpdateGuestPoint(vo);
	}

	@Override
	public int InsertPointTable(ReserveVO vo) {
		return mapper.InsertPointTable(vo);
	}

	@Override
	public int UpdateCouponStatus(ReserveVO vo) {
		return mapper.UpdateCouponStatus(vo);
	}

	@Override
	public int SelectTotalPoint(ReserveVO vo) {
		return mapper.SelectTotalPoint(vo);
	}

}
