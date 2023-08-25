package com.jafa.service.member;

import java.security.SecureRandom;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.exception.NotFoundMemberException;
import com.jafa.repository.member.MemberRepository;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class MailSendService {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private int authNumber; 
	
	public void makeRandomNumber() {
		//111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
		
	// 회원가입 인증 메일 양식 
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = "eatcodeall@naver.com"; // 발신자  
		String toMail = email; // 수신자
		String title = "[Board_Project] 회원 가입 인증 이메일 입니다.";  
		String content = "인증 번호는 " + authNumber + "입니다." + "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		mailSend(setFrom, toMail, title, content);
		log.info(authNumber);
		return Integer.toString(authNumber);
	}
		
	//이메일 전송 메소드
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true); // true : html 형식으로 전송
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	// 아이디 찾기 이메일 전송
	public void findIdEmail(String email) {
		String findMemberId = memberRepository.selectByEmail(email);
		if(findMemberId==null) {
			throw new NotFoundMemberException();
		}
		
		String setForm = "eatcodeall@naver.com";
		String toMail = email;
		String title = "[Board_Project] 아이디 찾기 서비스 메일입니다.";
		String content = "";
		content += "회원님의 아이디는 <b>";
		content += findMemberId;
		content += "</b> 입니다";
		
		mailSend(setForm, toMail, title, content);
	}
	
	// 임시 비밀번호 이메일 전송
	@Transactional
	public void findPwdEmail(String email) {
		String findMemberId = memberRepository.selectByEmail(email);
		if(findMemberId==null) {
			throw new NotFoundMemberException();
		}
		String tempPassword = generateTemporaryPassword();
		String encodingPwd = passwordEncoder.encode(tempPassword);
		memberRepository.updatePassword(findMemberId, encodingPwd);

		String setFrom = "eatcodeall@naver.com"; // 발신자  
		String toMail = email; // 수신자
		String title = "[Board_Project] 임시비밀번호 발급 서비스 메일입니다.";  
		String content = "";
		content += "임시 비밀번호는 [<b>";
		content += tempPassword;
		content += "</b>] 입니다";
		mailSend(setFrom, toMail, title, content);
	}

	// 임시 비밀번호 생성
	public String generateTemporaryPassword() {
		StringBuilder charSb = new StringBuilder();
		for(char c = 48; c <= 122; c++) {
			if(c>=58 && c<=64 || c>=91 && c<=96) {continue;}
			charSb.append(c);
		}
		
		String characters = charSb.toString();
		Random random = new SecureRandom();
		
		StringBuilder sb = new StringBuilder(12);
		for(int i = 0; i<12; i++) {
			int randomIdx = random.nextInt(characters.length());
			char randomChar = characters.charAt(randomIdx);
			sb.append(randomChar);
		}
		
		return sb.toString();
	}
	
}