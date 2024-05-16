package kr.kh.team2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.member.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		
		//관리자페이지/게시판-등록-수정-삭제-조회 ajax url / 멘토 허가페이지 / 멘토신청 조회허가거절모달창 ajax url
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user==null || !user.getMe_ma_auth().equals("관리자")) {
			response.getWriter().write("<script>alert(\"허용되지 않은 접근입니다.\"</script>");
			response.sendRedirect(request.getContextPath());
			return false;
		}
		
		
		return true;
	}

}
