package com.jafa.repository.member;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.jafa.AppTest;
import com.jafa.domain.member.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberRepositoryTest extends AppTest{

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
//	@Ignore
	@Test
	public void testRead() {
		log.info(memberRepository.read("admin1"));
	}
	
	@Ignore
	@Test
	public void testInsert() {
		MemberVO vo = new MemberVO();
		vo.setMemberId("admin3");
		vo.setMemberPwd("1234");
		vo.setMemberName("관리자3");
		vo.setEmail("admin3@test.com");
		memberRepository.insert(vo);
		
		log.info(memberRepository.read("admin3"));
	}
	
	@Ignore
	@Test
	public void testUpdate() {
		MemberVO vo = new MemberVO();
		vo.setMemberId("admin3");
		vo.setMemberName("관리자3");
		vo.setEmail("admin3@test.com");
		memberRepository.update(vo);
		
		log.info(memberRepository.read("admin3"));
	}
	
	@Ignore
	@Test
	public void testUpdatePassword() {
		memberRepository.updatePassword("admin1", passwordEncoder.encode("1111"));
		
		log.info(memberRepository.read("admin1"));
	}
	
	@Ignore
	@Test
	public void testSelectById() {
		log.info(memberRepository.selectById("admin1"));
	}

}
