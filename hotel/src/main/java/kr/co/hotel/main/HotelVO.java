package kr.co.hotel.main;

import java.util.List;

import kr.co.hotel.HRRegister.ImageVO;
import lombok.Data;

@Data
public class HotelVO {
	private int hotel_no;
	private int host_no;
	private String hotel_name;
	private String addr;
	private String sec_addr;
	private String tel;
	private int isConfirm;
	private String hotel_content;
	private String reject;
	private int state_code;
	private String state_name;
	private int district_code;
	private String district_name;
	private String lat;
	private String lot;
	
	private double avgScore;
	private int totalReview;
	private int totalLike;
	
	private List<ImageVO> imageList;
	private String image_type;
	private int lowPrice;
	private String filename;
	private String filename_org;
	
	private int page;
	private String searchField;
	private String searchWord;
	private String selectbox_district;
	private String searchbox_district;
	
	private String selectbox_state;
	private String sortType;
	
	
	public HotelVO() {
		this.totalReview = 0;
	}
	
	
}
	