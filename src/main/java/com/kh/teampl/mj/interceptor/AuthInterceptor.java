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
//		// �α��εǾ����� �ʴٸ�
//		if (userVo == null) {
//			String uri = request.getRequestURI();
//			String queryString = request.getQueryString();
//			String targetLocation = uri + "?" + queryString; // �̵��ϰ��� �� ���
//			session.setAttribute("targetLocation", targetLocation);
//			
//			// �α��� �������� �̵�
//			response.sendRedirect("/user/login");
//			return false; // ���� ��û ó���� ���� ����
//		}
		return true;
	}
}
