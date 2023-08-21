package com.jafa.repository.member;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberRepositoryTest extends AppTest{

	@Autowired
	private MemberRepository memberRepository;
	
	@Test
	public void test() {
		log.info(memberRepository.read("admin1"));
	}

}
