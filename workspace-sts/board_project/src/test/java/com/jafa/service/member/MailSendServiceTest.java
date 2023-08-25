package com.jafa.service.member;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;

import lombok.extern.log4j.Log4j;

@Log4j
public class MailSendServiceTest extends AppTest{

	@Autowired
	private MailSendService mailSendService;
	
	@Ignore
	@Test
	// 회원가입 인증 메일 양식 
	public void testJoinEmail() {
		mailSendService.joinEmail("fogy431@gmail.com");
	}
		
	@Ignore
	@Test
	//이메일 전송 메소드
	public void testMailSend() { 
		String setFrom = "eatcodeall@naver.com"; // 발신자  
		String toMail = "fogy431@gmail.com"; // 수신자
		String title = "[Board_Project] 이메일 전송 서비스의 전송 메소드 테스트 메일입니다.";  
		String content = "";
		content += "테스트 <b>";
		content += "메일";
		content += "</b> 입니다";
		mailSendService.mailSend(setFrom, toMail, title, content);
	}

	@Ignore
	@Test
	// 아이디 찾기 이메일 전송
	public void testFindIdEmail() {
		mailSendService.findIdEmail("fogy431@gmail.com");
	}
	
	@Ignore
	@Test
	// 임시 비밀번호 이메일 전송
	public void testFindPwdEmail() {
		mailSendService.findPwdEmail("fogy431@gmail.com");
	}

//	@Ignore
	@Test
	// 임시 비밀번호 생성 메서드
	public void testGenerateTemporaryPassword() {
		log.info(mailSendService.generateTemporaryPassword());
	}
	
}