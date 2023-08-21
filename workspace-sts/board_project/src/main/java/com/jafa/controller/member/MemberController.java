package com.jafa.controller.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MemberController {

	@RequestMapping("/login")
	public String loginPage(HttpServletRequest request, Model model, Authentication authentication,
			RedirectAttributes rttr, String error, String logout) {
		String uri = request.getHeader("Referer"); // 로그인 전 사용자가 보던 페이지
		
		if(uri!=null && !uri.contains("/login") && !uri.contains("/accessDenied")) {
			request.getSession().setAttribute("prevPage", uri);
		}
		
		if(authentication!=null) {
			rttr.addFlashAttribute("duplicateLogin", "이미 로그인 중입니다.");
			if(uri==null) {uri = "/";}
			return "redirect:" + uri;
		}
		
		if(error!=null) model.addAttribute("error", "로그인 에러");
		if(logout!=null) model.addAttribute("logout", "로그아웃");
		return "member/login";
	}
	
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "/error/accessError";
	}
	
	@GetMapping("/guest/guestpage")
	public void guestPage() {
	}
	
	@GetMapping("/member/memberpage")
	public void memberPage() {
	}
	
	@GetMapping("/admin/adminpage")
	public void adminPage() {
	}
}
