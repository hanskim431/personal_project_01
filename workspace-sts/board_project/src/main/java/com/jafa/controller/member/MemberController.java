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

import com.jafa.domain.common.Criteria;
import com.jafa.domain.common.Pagination;
import com.jafa.domain.member.MemberVO;
import com.jafa.exception.NotFoundMemberException;
import com.jafa.exception.PasswordMisMatchException;
import com.jafa.service.board.BoardService;
import com.jafa.service.member.MailSendService;
import com.jafa.service.member.MemberService;
import com.jafa.service.reply.ReplyService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReplyService replyService;

	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		return mailSendService.joinEmail(email);
	}

	// ========= 회원 가입 ========= 
	// 약관동의 
	@GetMapping("/join/step1")
	public String step1(Authentication authentication) {
	    if (authentication != null && (authentication.getAuthorities().stream().anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN")) || authentication.getAuthorities().stream().anyMatch(r -> r.getAuthority().equals("ROLE_MEMBER")))) {
	        // ROLE_ADMIN 또는 ROLE_MEMBER 역할을 가진 경우 홈으로 리다이렉트
	        return "redirect:/";
	    }
	    // 해당 역할이 없는 경우 회원가입 단계 1 페이지로 이동
	    return "member/step1";
	}


	// 이메일 인증
	@PreAuthorize("not hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping("/join/step2")
	public String step2(@RequestParam(defaultValue = "false") List<Boolean> agreement) {
		if(agreement.size()>=2 && agreement.stream().allMatch(v->v) ) {
			return "member/step2";
		}
		return "member/step1";
	}

	// 회원가입작성
	@PreAuthorize("not hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping("/join/step3")
	public String step3(MemberVO memberVO) {
		return "member/join";
	}

	// 회원가입 처리 
	@PreAuthorize("not hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping("/member/join")
	public String join(MemberVO memberVO, RedirectAttributes rttr) {
		log.info(memberVO);
		memberService.join(memberVO);
		return "redirect:/";
	}

	@GetMapping({"/join/step2","/join/step3"})
	public String joinForm() {
		return "member/step1";
	}

	// 아이디 중복 확인
	@PostMapping("/member/idCheck")
	@ResponseBody
	public ResponseEntity<Boolean> idDuplicateCheck(String memberId) {
		MemberVO vo = memberService.read(memberId);
		return vo == null ? new ResponseEntity<>(Boolean.TRUE, HttpStatus.OK)
				: new ResponseEntity<>(Boolean.FALSE, HttpStatus.OK);
	}

	// 이메일 중복 확인
	@PostMapping("/member/checkDuplicatedEmail")
	@ResponseBody
	public ResponseEntity<Boolean> checkDuplicatedEmail(String email){
		String memberId = memberService.selectByEmail(email);
		return memberId == null ? new ResponseEntity<>(Boolean.TRUE, HttpStatus.OK)
				: new ResponseEntity<>(Boolean.FALSE, HttpStatus.OK);
	}
	
	
	// ========= 로그인 ========= 
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

	// ========= 페이지 ========= 
	// 403
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "error/accessError";
	}
	
	// 마이페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping({"/mypage", "/mypage/{path}"})
	public String myPage(Model model, Principal principal, 
			@PathVariable(required = false) String path, Criteria criteria) {
		String memberId = principal.getName();
		if(path==null || path.isEmpty()) {
			MemberVO memberVO = memberService.read(memberId);
			model.addAttribute("vo",memberVO);
			return "member/mypage";
		} else if(path.equals("mypost")) {
			model.addAttribute("list", boardService.getList(criteria, null));
			model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria, null)));
			return "member/mypost";
		} else if(path.equals("myreply")) {
			return "member/myreply";
		}
		return "member/mypage";
	}

	// 관리자 페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/admin/adminpage")
	public String adminPage() {
		return "/admin/adminPage";
	}

	// ========= 정보 수정 ========= 
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

	// ========= 정보 찾기 ========= 
	// 아이디 / 비밀번호 찾기 페이지
	@GetMapping("/findMemberInfo")
	public String findMemberInfo() {
		return "member/findMemberInfo";
	}
	
	// 아이디 찾기 처리
	@ResponseBody
	@PostMapping(value = "/findMemberId", produces = "plain/text; charset=utf-8")
	public ResponseEntity<String> findMemberId(String email){
		String message = null;
		try {
			mailSendService.findIdEmail(email);
			message = "가입하신 이메일로 전송되었습니다.";
		} catch (NotFoundMemberException e) {
			 message = "회원 정보를 찾을 수 없습니다.";
			 return new ResponseEntity<String> (message,HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String> (message,HttpStatus.OK);
	}
	
	// 비밀번호 찾기 처리
	@ResponseBody
	@PostMapping(value = "/findMemberPwd", produces = "plain/text; charset=utf-8")
	public ResponseEntity<String> findMemberPwd(String email){
		String message = null;
		try {
			mailSendService.findPwdEmail(email);
			message = "가입하신 이메일로 전송되었습니다.";
		} catch (NotFoundMemberException e) {
			message = "회원 정보를 찾을 수 없습니다.";
			return new ResponseEntity<String> (message,HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String> (message,HttpStatus.OK);
	}
	

}
