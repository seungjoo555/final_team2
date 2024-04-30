package kr.kh.team2.interceptor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.service.CommonService;
import lombok.extern.log4j.Log4j;

@Log4j
public class MenuInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	CommonService commonService;
	
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		//메뉴 가져오기
		ArrayList<ProgrammingCategoryVO> menuCateList = commonService.getCateList();
		ArrayList<SearchMenuVO> menuLangList = commonService.getMenuList();
		//화면마다 메뉴 뿌려주기
		request.setAttribute("menuCateList", menuCateList);
		request.setAttribute("menuLangList", menuLangList);
		
		return true;
	}
}
