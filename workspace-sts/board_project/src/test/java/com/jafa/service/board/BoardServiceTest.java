package com.jafa.service.board;

import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardServiceTest extends AppTest{

	@Autowired
	private BoardService boardService;
	
	@Ignore
	@Test
	public void test() {
		log.info(boardService);
		assertNotNull(boardService);
	}
	
	@Ignore
	@Test
	public void testGetList() {
		boardService.getList().forEach(vo-> log.info(vo));
	}
	
//	@Ignore
	@Test
	public void testGet() {
		log.info("get:"+boardService.get(1L));
	}
	
	@Ignore
	@Test
	public void testRegister() {
		BoardVO vo = BoardVO.builder()
				.title("���� �ۼ� ����")
				.content("���� �ۼ� ����")
				.writer("admin")
				.boardType("BOARD3")
				.status("VISIBLE")
				.build();
		boardService.register(vo);
		log.info(vo.getBno()+"�� �Խñ� �ۼ�");
	}
	
	@Ignore
	@Test
	public void testModify() {
		BoardVO vo = BoardVO.builder()
				.bno(2L)
				.title("���� ���� ����")
				.content("���� ���� ����")
				.writer("admin")
				.boardType("board3")
				.status("VISIBLE")
				.build();
		boardService.modify(vo);
		log.info(vo.getBno()+"�� �Խñ� ����");
	}
	
	@Ignore
	@Test
	public void testDelete() {
		Long bno = 11L;
		boardService.remove(bno);
		log.info(bno+"�� �Խñ� ����");
	}

	
}
