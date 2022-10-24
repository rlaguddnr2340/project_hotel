package kr.co.hotel.coupon;

import java.sql.Timestamp;
//import java.time.LocalDate;

import lombok.Data;

@Data
public class CouponVO {
	private String coupon_no; 
	private String guest_id; 
	private int coupon_price; 
	private Timestamp coupon_date; 
	private Timestamp expdate; 
	private Timestamp usedate; 
	private int use_status;
	private int delete_status;
	
	
	//---------이하 빛찬---------------------
	//페이징
	private int startIdx; //페이지의 row시작 번호
	private int pageRow; //페이지당 row갯수 //기본 10의로 설정
	private int page;
	
	private Timestamp searchStartDate; 
	private Timestamp searchEndDate; 
	
	
	
	
	
	 public CouponVO() { 
		 this.pageRow = 10; //기본 10의로 설정 
		 this.page = 1;
	 }
	
}
