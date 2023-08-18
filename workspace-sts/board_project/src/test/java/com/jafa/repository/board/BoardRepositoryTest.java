package com.jafa.repository.board;

import java.util.List;

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
//	@Ignore
	@Test
	public void testGetList() {
		Criteria criteria = new Criteria();
		criteria.setPageNum(1);
		criteria.setAmount(10);	
		String boardType = "BOARD2";
		log.info("리스트 출력");
		boardRepository.getList(criteria, boardType).forEach(board->log.info(board));
	}
	
	@Ignore
	@Test
	public void testGetListAll() {
		Criteria criteria = new Criteria();
		criteria.setPageNum(1);
		criteria.setAmount(10);	
		log.info("리스트 출력");
		boardRepository.getListAll(criteria).forEach(board->log.info(board));
	}
	
	@Ignore
	@Test
	public void testRead() {
		log.info("출력");
		BoardVO vo = boardRepository.read(1L);
		log.info("vo"+vo);
	}
	
	@Ignore
	@Test
	public void testGetTotalCount() {
		Criteria criteria = new Criteria();
		log.info(boardRepository.getTotalCount(criteria));
	}

	@Ignore
	@Test
	public void testSearch() {
		Criteria criteria = new Criteria(); 
			criteria.setType("T");
			criteria.setKeyword("200");
		String boardType = "BOARD1";
		List<BoardVO> list = boardRepository.getListAll(criteria);
		log.info(list);
	}

	//U
	@Ignore
	@Test
	public void testUpdate() {
		BoardVO vo = BoardVO.builder()
				.bno(1L)
				.title("수정 제목1")	
				.content("수정 내용")
				.writer("admin")
				.boardType("BOARD3")
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
