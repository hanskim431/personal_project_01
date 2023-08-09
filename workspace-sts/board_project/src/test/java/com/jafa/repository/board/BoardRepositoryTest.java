package com.jafa.repository.board;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardRepositoryTest extends AppTest{

	@Autowired
	private BoardRepository boardRepository;
	
	@Ignore
	@Test
	public void testGetList() {
		log.info("����Ʈ ���");
		boardRepository.getList().forEach(board->log.info(board));
		log.info("����Ʈ ��� �Ϸ�");
	}
	
//	@Ignore
	@Test
	public void testRead() {
		log.info("���");
		BoardVO vo = boardRepository.read(1L);
		log.info(vo);
		log.info("��� �Ϸ�");
	}
	
	@Ignore
	@Test
	public void testInsert() {
		log.info("������ ����");
		BoardVO vo = BoardVO.builder()
				.title("���� ����")
				.content("���� ����")
				.writer("admin")
				.boardType("BOARD1")
				.status("VISIBLE")
				.build();
		boardRepository.insert(vo);
		log.info("������ ���� �Ϸ�");
	}

}
