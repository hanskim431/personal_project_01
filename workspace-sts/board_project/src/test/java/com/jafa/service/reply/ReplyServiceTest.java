package com.jafa.service.reply;

import static org.junit.Assert.assertNotNull;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyPageDTO;
import com.jafa.domain.reply.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyServiceTest extends AppTest{
	
	@Autowired
	private ReplyService replyService;
	
	@Ignore
	@Test
	public void test() {
		log.info(replyService);
		assertNotNull(replyService);
	}
	
//	@Ignore
	@Test
	public void testGetList() {
		Criteria criteria = new Criteria();
		log.info(replyService.getList(new Criteria(20,10), 1L));
		
	}
	
	@Ignore
	@Test
	public void testGet() {
		log.info(replyService.get(1L));
	}
	
	@Ignore
	@Test
	public void testRegister() {
		ReplyVO vo = ReplyVO.builder()
				.bno(1L)
				.reply("댓글")
				.replyer("admin2")
				.build();
		replyService.register(vo);
	}
	
	@Ignore
	@Test
	public void testModify() {
		ReplyVO vo = ReplyVO.builder().rno(3L).reply("댓글 수정 서비스").status("HIDDEN").build();
		replyService.modify(vo);
	}
	
	@Ignore
	@Test
	public void testDelete() {
		replyService.remove(4L);
	}
}
