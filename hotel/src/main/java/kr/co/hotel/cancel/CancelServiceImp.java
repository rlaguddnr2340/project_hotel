package kr.co.hotel.cancel;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.reserve.ReserveMapper;
import kr.co.hotel.reserve.ReserveServiceImp;
import kr.co.hotel.reserve.ReserveVO;

@Service
public class CancelServiceImp implements CancelService {

	@Autowired
	CancelMapper mapper;
	
	@Autowired
	ReserveMapper smapper;

	//카드 결제 취소
	@Override
	public String cancel(ReserveVO vo, GuestVO gvo) throws IOException {
		//인증 토큰 가져오기
		String impKey ="4457337683424501";
		String impSecret ="nbjkQg5PqAesalhxQbxfarlaZmGhvumSWBz1iOuOHwspwMi7eSnp4B7OVPlANmexGgRvIAYt2MS2cLnB";
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/users/getToken");
		
		conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		
		JSONObject json = new JSONObject();
		json.put("imp_key", impKey);
		json.put("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		bw.write(json.toString());
		bw.flush();
		bw.close();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		
		Gson gson = new Gson();
		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		System.out.println(response);
		String token = gson.fromJson(response, Map.class).get("access_token").toString();
		br.close();
		conn.disconnect();
		
		System.out.println("토큰 : " + token);
		
		//결제 취소
		url = new URL("https://api.iamport.kr/payments/cancel");
		conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", token);
		conn.setDoOutput(true);
		
		json.put("imp_uid", vo.getImp_uid());
 
		bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		bw.write(json.toString());
		bw.flush();
		bw.close();
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		StringBuilder sb = new StringBuilder();
		String line = null;
		
		while((line = br.readLine()) != null) { // 읽을 수 있을 때 까지 반복
			sb.append(line);
		}
		br.close();
		conn.disconnect();
		
		mapper.cancelReserve(vo);
		gvo.setTotalpoint(smapper.SelectTotalPoint(vo)+vo.getUsed_point());
		mapper.cancelGuestPoint(gvo);
		mapper.cancelPoint(vo);
		
		mapper.cancelCoupon(vo);
		return sb.toString();
	}	
	
	//예약테이블에서 상태 업데이트
	@Override
	public int UpdateReserveStatus(ReserveVO vo) {
		return mapper.UpdateReserveStatus(vo);
	}

	//특정 게스트에서 데이터 업데이트
	@Override
	public int UpdateGuestPoint(ReserveVO vo) {
		return mapper.UpdateGuestPoint(vo);
	}

	//포인트 테이블 이력 저장(포인트 취소)
	@Override
	public int InsertPointTable(ReserveVO vo) {
		return mapper.InsertPointTable(vo);
	}

	//쿠폰 상태 업데이트
	@Override
	public int UpdateCouponStatus(ReserveVO vo) {
		return mapper.UpdateCouponStatus(vo);
	}

	//특정 예약정보 가져오기
	@Override
	public ReserveVO SelectReserve(ReserveVO vo) {
		return mapper.SelectReserve(vo);
	}
}
