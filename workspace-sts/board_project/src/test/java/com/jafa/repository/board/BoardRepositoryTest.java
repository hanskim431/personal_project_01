package com.jafa.repository.board;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardRepositoryTest extends AppTest{

	@Autowired
	private BoardRepository boardRepository;
	
	//C
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

	// R
	@Ignore
	@Test
	public void testGetList() {
		Criteria criteria = new Criteria();
		criteria.setPageNum(4);
		criteria.setAmount(2);		
		log.info("리스트 출력");
		boardRepository.getList(criteria).forEach(board->log.info(board));
	}
	
	@Ignore
	@Test
	public void testRead() {
		log.info("출력");
		BoardVO vo = boardRepository.read(1L);
		log.info("vo"+vo);
	}
	
//	@Ignore
	@Test
	public void testGetTotalCount() {
		log.info(boardRepository.getTotalCount());
	}

	//U
	@Ignore
	@Test
	public void testUpdate() {
		BoardVO vo = BoardVO.builder()
				.bno(1L)
				.title("수정 제목")	
				.content("수정 내용")
				.writer("admin")
				.boardType("BOARD3")
				.status("HIDDEN")
				.build();
		boardRepository.update(vo);
	}
	
	
	//D
	@Ignore
	@Test
	public void testDelete() {
		boardRepository.delete(10L);
	}
	
}
