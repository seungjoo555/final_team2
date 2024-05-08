package kr.kh.team2.interceptor;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.MemberService;


public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	MemberService memberService;
	
	@Override
	public void postHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler, 
		ModelAndView modelAndView)
		throws Exception {
		//ModelAndView 객체에서 model 객체에 넣어준 user를 가져오는 코드
		MemberVO user = (MemberVO)modelAndView.getModel().get("user");

		//회원 정보가 있으면
		if(user != null) {
			//세션에 회원 정보를 추가
			request.getSession().setAttribute("user", user);
			//자동로그인 쿠키
			if(user.isAutoLogin()) {
				//쿠키를 생성해서
				String value = request.getSession().getId();
				Cookie cookie = new Cookie("loginCookie", value);
				cookie.setPath("/");
				//1주일
				int time = 7 * 24 * 60 * 60;//7일을 초로 환산
				cookie.setMaxAge(time);
				//화면에 전송
				response.addCookie(cookie);
				//DB에 관련 정보를 추가
				//세션 아이디와 만료시간
				user.setMe_cookie(value);
				Date date = new Date(System.currentTimeMillis() + time * 1000);
				user.setMe_cookie_limit(date);
				memberService.updateMemberCookie(user);
			}
		}
	}
}