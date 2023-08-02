package com.kh.teampl.mj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
//		System.out.println("got a prehandle");
		
//		HttpSession session = request.getSession(); 
//		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
//		
//		// 로그인되어있지 않다면
//		if (userVo == null) {
//			String uri = request.getRequestURI();
//			String queryString = request.getQueryString();
//			String targetLocation = uri + "?" + queryString; // 이동하고자 한 경로
//			session.setAttribute("targetLocation", targetLocation);
//			
//			// 로그인 페이지로 이동
//			response.sendRedirect("/user/login");
//			return false; // 실제 요청 처리를 하지 않음
//		}
		return true;
	}
}
