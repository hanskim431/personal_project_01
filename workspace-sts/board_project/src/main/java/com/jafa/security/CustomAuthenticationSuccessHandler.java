package com.jafa.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		// 로그인하지 않은 경우  Spring Security가 요청을 가로챔
		// 사용자의 요청 정보 저장
		RequestCache requestCache = new HttpSessionRequestCache(); 
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if(savedRequest!=null) {
			log.info(savedRequest.getRedirectUrl());
			response.sendRedirect(savedRequest.getRedirectUrl());
			return; 
		}
		
		// 사용자가 로그인 버튼으로 직접 로그인 페이지로 이동하는 경우 보던 페이지 호출
		String prevPage = (String) request.getSession().getAttribute("prevPage");
		if(prevPage!=null) {
			request.getSession().removeAttribute("prevPage");
			response.sendRedirect(prevPage);
			return;
		}
		
		// 사용자가 주소창에 로그인 페이지를 입력함으로 로그인 페이지로 직접 이동하는 경우 
		//TODO 보던 페이지 호출
		response.sendRedirect(request.getContextPath());
	}
}