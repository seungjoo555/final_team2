package kr.kh.team2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.member.MemberVO;


public class LoginMemberInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user != null) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("<script>alert('비회원전용 기능입니다.');location.href='" + request.getContextPath() + "/';</script>");
			return false;
		}
		
		return true;
	}

}
