package com.kh.teampl.mj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.teampl.mj.dto.LoginDto;


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
				targetLocation = uri + "?" + queryString; // �̵��ϰ��� �� ���
			}
			
			System.out.println("AuthInterceptor, targetLocation : " + targetLocation);
			session.setAttribute("targetLocation", targetLocation);

			// �α��� �������� �̵�
			response.sendRedirect("/user/login");
			return false; // ���� ��û ó���� ���� ����
		}
		return true;
	}
}
