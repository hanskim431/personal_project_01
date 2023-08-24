package com.jafa.controller.member;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.member.MemberVO;
import com.jafa.exception.PasswordMisMatchException;
import com.jafa.service.member.MailSendService;
import com.jafa.service.member.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailSendService mailSendService;

	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		return mailSendService.joinEmail(email);
	}
	
	// 약관 동의
	@GetMapping("/join/step1")
	public String step1() {
		return "member/step1";
	}
	
	// 약관 동의
	@PostMapping("/join/step2")
	public String step2(@RequestParam(defaultValue = "false") List<Boolean> agreement) {
		if(agreement.size()>=2 && agreement.stream().allMatch(v->v)) {
			return "member/step2";
		}
		return "member/step1";
	}
	
	// 회원 가입 작성
	@PostMapping("/join/step3")
	public String step3(MemberVO memberVO) {
		return "member/join";
	}
	
	// 회원 가입 step 스킵 방지
	@GetMapping({"/join/step2","/join/step3"})
	public String joinForm() {
		return "member/step1";
	}
	
	// 회원 가입 처리
	@PostMapping("/member/join")
	public String join(RedirectAttributes rttr, MemberVO memberVO) {
		memberService.join(memberVO);
		return "redirect:/";
	}
	
	// 아이디 중복 체크
	@PostMapping("/member/idCheck")
	@ResponseBody
	public ResponseEntity<Boolean> idDuplicateCheck(String memberId){
		MemberVO vo = memberService.selectById(memberId);
		return vo == null?
				new ResponseEntity<Boolean>(Boolean.TRUE,HttpStatus.OK)
				: new ResponseEntity<Boolean>(Boolean.FALSE,HttpStatus.OK);
	}
	
	
	// 로그인 
	@RequestMapping("/login")
	public String loginPage(HttpServletRequest request, Model model, Authentication authentication,
			Principal principal, RedirectAttributes rttr, String error, String logout) {
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
	
	// 403
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "error/accessError";
	}
	
	// 마이페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping({"/mypage", "/mypage/{path}"})
	public String myPage(Model model, Principal principal, @PathVariable(required = false) String path) {
		String memberId = principal.getName();
		if(path==null) {
			MemberVO memberVO = memberService.read(memberId);
			model.addAttribute("vo",memberVO);
			return "member/mypage";
		}
		return "member/memberPage";
	}

	// 관리자 페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/admin/adminpage")
	public String adminPage() {
		return "/admin/adminPage";
	}
	
	// 개인 정보 수정 
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping("/member/modify")
	public String modify(RedirectAttributes rttr, MemberVO memberVO) {
		log.info(memberVO);
		memberService.modify(memberVO);
		rttr.addFlashAttribute("result","modify");
		return "redirect:/mypage";
	}
	
	// 비밀 번호 수정 
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping(value = "/mypage/changePwd", produces = "application/test; charset=utf-8")
	public ResponseEntity<String> changePwd(@RequestParam Map<String, String> memberMap) {
		
		try {
			memberService.changePassword(memberMap);
		} catch (PasswordMisMatchException e) {
			return new ResponseEntity<>("비밀번호가 일치하지 않음",HttpStatus.UNAUTHORIZED);
		}
		return new ResponseEntity<>("success",HttpStatus.OK);
	}
	
}
