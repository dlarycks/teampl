package com.kh.teampl.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.teampl.dto.LoginDto;


public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession(); 
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		
		if (loginDto == null) {
			String uri = request.getRequestURI();
			String queryString = request.getQueryString();
			String targetLocation = null;
			if (queryString == null) {
				targetLocation = uri;
			} else {
				targetLocation = uri + "?" + queryString; // 이동하고자 한 경로
			}
			
			System.out.println("AuthInterceptor, targetLocation : " + targetLocation);
			session.setAttribute("targetLocation", targetLocation);

			// 로그인 페이지로 이동
			response.sendRedirect("/user/login");
			return false; // 실제 요청 처리를 하지 않음
		}
		return true;
	}
}
