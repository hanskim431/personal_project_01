package com.jafa.repository.reply;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.reply.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyRepositoryTest extends AppTest{

	@Autowired
	private ReplyRepository replyRepository;
	
	@Ignore
	@Test
	public void testGetList() {
		log.info(replyRepository.getList(1L));
	}
	
	@Ignore
	@Test
	public void testRead() {
		log.info(replyRepository.read(2L));
	}
	
	@Ignore
	@Test
	public void testInsert() {
		ReplyVO vo = ReplyVO.builder()
				.bno(2L)
				.reply("댓글 작성")
				.replyer("admin2")
				.status("VISIBLE")
				.build();
		replyRepository.insert(vo);
	}
	
	@Ignore
	@Test
	public void testUpdate() {
		ReplyVO vo = ReplyVO.builder()
				.rno(1L)
				.reply("댓글 수정")
				.status("VISIBLE")
				.build();
		replyRepository.update(vo);
	}
	
	@Ignore
	@Test
	public void testDelete() {
		replyRepository.delete(2L);
	}
	
//	@Ignore
	@Test
	public void testgetTotalCount() {
		log.info(replyRepository.getTotalCount(1L));
	}

}
