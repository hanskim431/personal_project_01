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
		log.info("리스트 출력");
		boardRepository.getList().forEach(board->log.info(board));
		log.info("리스트 출력 완료");
	}
	
//	@Ignore
	@Test
	public void testRead() {
		log.info("출력");
		BoardVO vo = boardRepository.read(1L);
		log.info(vo);
		log.info("출력 완료");
	}
	
	@Ignore
	@Test
	public void testInsert() {
		log.info("데이터 삽입");
		BoardVO vo = BoardVO.builder()
				.title("삽입 제목")
				.content("삽입 내용")
				.writer("admin")
				.boardType("BOARD1")
				.status("VISIBLE")
				.build();
		boardRepository.insert(vo);
		log.info("데이터 삽입 완료");
	}

}
