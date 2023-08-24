package com.jafa.service.member;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailSendService {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int authNumber;
	
	private void makeRandomNumber() {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = "eatcodeall@naver.com"; // 발신
		String toMail = email; // 수신
		String title = "Project_Board의 회원 가입 인증 이메일 입니다.";
		String content = "";
		content += "인증번호는 " + authNumber + "입니다.<br>";
		content += "해당 인증번호를 인증번호 확인란에 기입하여 주세요.<br>";
		
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}

	private void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true); // true: html 형식으로 전송함
			mailSender.send(message);
		} catch (MessagingException e) {
			 e.printStackTrace();
		}
	}

}
