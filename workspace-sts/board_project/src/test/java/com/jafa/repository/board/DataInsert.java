package com.jafa.repository.board;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.board.BoardVO;

public class DataInsert extends AppTest{
	
	@Autowired
	BoardRepository boardRepository; 
	
	
	// 408개 데이터 삽입 총 412개의 게시물
	@Test
	public void test() {
		
		String writer;
		String writerArr[] = {"admin1","admin2","member1","member2","member3","member4"};
		String boardType;
		String status;
		
		for(int j=1; j<10; j++) {
			for(int i=1;i<=408;i++) {
				BoardVO vo = BoardVO.builder()
						.title("제목 : 테스트 데이터 " + i)
						.content("내용 : 테스트 데이터 " + i)
						.writer(writer = writerArr[i%6])
						.boardType(boardType ="board" + j)
						.status(status = i % 5 == 0 ? "HIDDEN" : "VISIBLE")
						.build();
				boardRepository.insert(vo);			
			}
		}
		
	}
}