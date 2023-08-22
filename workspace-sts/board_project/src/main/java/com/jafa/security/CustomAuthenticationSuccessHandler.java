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
		
		log.info("로그인 성공");
		String name = authentication.getName();
		log.info("getName() : " + name);
		log.info(authentication.getDetails());
		authentication.getAuthorities().forEach(auth -> {
			log.info(auth);
		});
		
		// 사용자 요청 정보를 저장하고 관리하는 HttpSessionRequestCache 객체 생성
		RequestCache requestCache = new HttpSessionRequestCache(); 
		// 세션에 저장된 사용자 원래 요청 정보를 가져옴
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		// 사용자가 guest상태로 접근 제한이 있는 페이지로 접근한 경우
		if(savedRequest!=null) { // 요청 정보가 있다면?
			response.sendRedirect(savedRequest.getRedirectUrl()); // 해당 요청 정보로 리다이렉트
			return;
		}
		
		// 사용자가 직접 로그인 버튼을 눌러서 로그인한 경우
		String prevPage = (String) request.getSession().getAttribute("prevPage");
		if(prevPage!=null) {
			request.getSession().removeAttribute("prevPage");
			response.sendRedirect(prevPage);
			return;
		}

		// 사용자가 주소창에 로그인 페이지로 직접 이동한 경우 -> Home으로 이동
		response.sendRedirect(request.getContextPath());
	}
}