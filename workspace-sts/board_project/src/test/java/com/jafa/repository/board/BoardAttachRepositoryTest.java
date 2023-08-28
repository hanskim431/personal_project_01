package com.jafa.repository.board;

import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardAttachVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardAttachRepositoryTest extends AppTest{

	@Autowired
	BoardAttachRepository boardAttachRepository;
	
//	@Ignore
	@Test
	public void testInsert() {
		BoardAttachVO vo = new BoardAttachVO();
		vo.setBno(1L);
		vo.setFileName("test01.txt");
		vo.setFileType(false);
		vo.setUploadPath("c:/upload");
		String uuid = UUID.randomUUID().toString();
		vo.setUuid(uuid);
		
		boardAttachRepository.insert(vo);
	}
	
	@Ignore
	@Test
	public void testDelete() {
		boardAttachRepository.delete("80e3b517-80d4-4154-9ba1-c2882d0b4578");
	}
	
//	@Ignore
	@Test
	public void testSelectByBno() {
		log.info(boardAttachRepository.selectByBno(1L));
	}

}
