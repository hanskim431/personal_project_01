package com.jafa.repository.reply;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.AppTest;
import com.jafa.domain.reply.ReplyVO;
import com.jafa.repository.board.BoardRepository;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyInsert extends AppTest{

	@Autowired
	private ReplyRepository replyRepository;
	
	@Autowired
	private BoardRepository boardRepository;
	
	@Test
	public void test() {
		
		for(int i=1; i<=100; i++) {
				ReplyVO vo = ReplyVO.builder()
						.bno(1L)
						.reply("댓글 : 페이징 처리 " + i)
						.replyer("admin1")
						.status("VISIBLE")
						.build();
				replyRepository.insert(vo);
				boardRepository.updateReplyCnt(1L, 1);
		}
	}
	
}


