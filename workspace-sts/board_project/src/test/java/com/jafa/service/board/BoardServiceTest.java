package com.jafa.service.board;

import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardAttachVO;
import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;

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
		Criteria criteria = new Criteria();
		String boardType = "board1";
		boardService.getList(criteria, boardType).forEach(vo-> log.info(vo));
	}
	
	@Ignore
	@Test
	public void testGetListAll() {
		Criteria criteria = new Criteria();
		String boardType = "BOARD1";
		boardService.getList(criteria, boardType).forEach(vo-> log.info(vo));
	}
	
	@Ignore
	@Test
	public void testGet() {
		log.info("get:"+boardService.get(1L));
	}
	
	@Ignore
	@Test
	public void testRegister() {
		BoardVO vo = BoardVO.builder()
				.title("서비스 작성 제목")
				.content("서비스 작성 내용")
				.writer("admin")
				.boardType("BOARD3")
				.status("VISIBLE")
				.build();
		boardService.register(vo);
		log.info(vo.getBno()+"번 게시글 작성");
	}
	
	@Ignore
	@Test
	public void testModify() {
		BoardVO vo = BoardVO.builder()
				.bno(1L)
				.title("서비스 수정 제목1")
				.content("서비스 수정 내용")
				.writer("admin")
				.boardType("board3")
				.build();
		boardService.modify(vo);
		log.info(vo.getBno()+"번 게시글 수정");
	}
	
	@Ignore
	@Test
	public void testDelete() {
		Long bno = 4L;
		boardService.remove(bno);
		log.info(bno+"번 게시글 삭제");
	}
	
//	@Ignore
	@Test
	public void testGetAttach() {
		String uuid = "2d844f61-457b-48b9-97ad-89ef240eb402";
		log.info(boardService.getAttach(uuid));
	}


}
