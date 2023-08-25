package com.jafa.service.member;

import java.util.HashMap;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.jafa.AppTest;
import com.jafa.domain.member.AuthVO;
import com.jafa.domain.member.MemberVO;
import com.jafa.repository.auth.AuthRepository;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberServiceImplTest extends AppTest{

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AuthRepository authRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Ignore
	@Test
	public void test() {
		MemberVO vo = new MemberVO();
		vo.setMemberId("admin3");
		vo.setMemberPwd("1111");
		vo.setMemberName("관리자3");
		vo.setEmail("admin3@test.com");
		memberService.join(vo);
		
		AuthVO authVO = new AuthVO("admin3", "ROLE_ADMIN", "ACTIVE");
		authRepository.insert(authVO);
		
	}

	@Ignore
	@Test
	public void testAuthInsert() {
		AuthVO authVO = new AuthVO();
		authVO.setMemberId("admin3");
		authVO.setAuth("ROLE_ADMIN");
		authVO.setEnable("ACTIVE");
		authRepository.insert(authVO);
	}
	
//	@Ignore
	@Test
	public void testChangePassword() {
		Map<String, String> memberMap = new HashMap();
		memberMap.put("memberId", "member3");
		memberMap.put("newPwd", "1111");
		memberMap.put("currentPwd", "1234");
		memberService.changePassword(memberMap);
	}
	
}
