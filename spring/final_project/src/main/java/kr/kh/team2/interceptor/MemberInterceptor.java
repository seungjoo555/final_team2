package kr.kh.team2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.service.MentorService;

public class MemberInterceptor extends HandlerInterceptorAdapter {

	/* preHandle에서 return값이 true이면 가려던 컨트롤러로 가서 작업을 진행
	 * return값이 false이면 가려던 컨트롤러로 가지 마세요. 리다이렉트할 경로가 있으면 해당 경로로 이동
	 * 
	 * */
	
	@Autowired
	MentorService mentorService;
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null) {
		      if(isAjaxRequest(request)) {
		    	  response.setHeader("SESSION_EXPIRED", "true");
		    	  return false;
		      }else {
		    	  response.setContentType("text/html;charset=UTF-8");
		    	  response.getWriter().write("<script>if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까?')){location.href='" + request.getContextPath() + "/login'};</script>");
		    	  return false;
		      }
		}
		
		if(user != null && user.getMe_temppw()==1) {
			if(isAjaxRequest(request)) {
				response.setHeader("Temp_User", "true");
			}else {
				response.setContentType("text/html;charset=UTF-8");
		        response.getWriter().write("<script>alert('임시 비밀번호를 변경하셔야 사이트 이용이 가능합니다.');location.href='" + request.getContextPath() + "/login/changepwtemp';</script>");
		        return false;
			}
		}
		
		if(user != null && user.getMe_verify()==0) {
			if(isAjaxRequest(request)) {
				response.setHeader("NonVerified_User", "true");
			}else {
				response.setContentType("text/html;charset=UTF-8");
		        response.getWriter().write("<script>alert('이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.');location.href='" + request.getContextPath() + "/signup/verify';</script>");
		        return false;
			}
		}
		
		return true;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
			String ajaxHeader = "AJAX";
			return req.getHeader(ajaxHeader) != null && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());

	}
	

}