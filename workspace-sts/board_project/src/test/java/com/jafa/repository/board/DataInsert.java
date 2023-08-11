package com.jafa.repository.board;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardVO;

public class DataInsert extends AppTest{
	
	@Autowired
	BoardRepository repository; 
	
	
	// 408개 데이터 삽입 총 412개의 게시물
	@Test
	public void test() {
		
		String status;
		
		for(int i=1;i<=408;i++) {
			BoardVO vo = BoardVO.builder()
					.title("제목 : 페이징 처리 " + i)
					.content("내용 : 페이징 처리 " + i)
					.writer("admin")
					.boardType("BOARD3")
					.status(status = i % 2 == 0 ? "HIDDEN" : "VISIBLE")
					.build();
			repository.insert(vo);			
		}
	}
}