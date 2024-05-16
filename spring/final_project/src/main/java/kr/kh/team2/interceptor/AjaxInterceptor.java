package kr.kh.team2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.member.MemberVO;

public class AjaxInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		
		
		if(!isAjaxRequest(request)) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("<script>alert('잘못된 접근입니다.');location.href='" + request.getContextPath() + "/';</script>");
			return false;
		}
		
		return true;
		
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
	       String ajaxHeader = req.getHeader("X-Requested-With");
	       return "XMLHttpRequest".equals(ajaxHeader);

	}
}
