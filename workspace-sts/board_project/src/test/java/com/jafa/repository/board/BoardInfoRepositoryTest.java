package com.jafa.repository.board;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardInfoVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardInfoRepositoryTest extends AppTest{

	@Autowired
	private BoardInfoRepository boardInfoRepository;
	
	@Ignore
	@Test
	public void testRead() {
		log.info(boardInfoRepository.read("road"));
		log.info(boardInfoRepository.read("road").getBoardName());
		log.info(boardInfoRepository.read("road").getExpanation());
	}
	
	
	@Test
	public void testUpdate() {
		BoardInfoVO vo = new BoardInfoVO("road","Road cycle","talk about Road bicycle");
		
		boardInfoRepository.update(vo);
		
		log.info(boardInfoRepository.read("road"));
	}

}
