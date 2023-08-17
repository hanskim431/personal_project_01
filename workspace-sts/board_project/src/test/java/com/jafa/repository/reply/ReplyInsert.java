package com.jafa.repository.reply;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.reply.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyInsert extends AppTest{

	@Autowired
	private ReplyRepository replyRepository;
	
	@Test
	public void test() {
		
		String replyer;
		
		for(int i=1; i<=408; i++) {
				ReplyVO vo = ReplyVO.builder()
						.bno(1L)
						.reply("댓글 : 페이징 처리 " + i)
						.replyer(replyer = i % 2 == 0 ? "admin1" : "admin2")
						.status("VISIBLE")
						.build();
				replyRepository.insert(vo);
		}
	}
	
}


