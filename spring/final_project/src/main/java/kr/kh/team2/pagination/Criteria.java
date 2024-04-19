package kr.kh.team2.pagination;

import java.util.ArrayList;
import java.util.Arrays;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
public class Criteria {
	
	private int page = 1;//현재 페이지 : 기본값 - 1
	private int perPageNum = 20;//한 페이지에서 컨텐츠 개수 : 기본값 - 10
	private String search = ""; //검색어 : 기본값 - 빈문자열=> 전체 검색
	private String type = "all"; //검색 타입 : 기본값 - 전체검색
	private ArrayList<String> typeList = //검색분야
			new ArrayList<String>(Arrays.asList("프론트엔드","백엔드","풀스택","프로그래밍 언어","웹 개발","데이터베이스","웹 퍼블리싱")); 

	
	public Criteria(int page) {
		this.page = page;
	}
	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}
	public Criteria(int page, int perPageNum, String type, String search) {
		this(page, perPageNum);
		this.type = type == null ? "" : type;
		this.search = search == null ? "" : search;
	}
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}
}

