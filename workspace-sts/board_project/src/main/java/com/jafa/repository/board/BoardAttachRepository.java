package com.jafa.repository.board;

import java.util.List;

import com.jafa.domain.board.BoardAttachVO;

public interface BoardAttachRepository {

	// C
	void insert(BoardAttachVO vo);
	
	// R
	BoardAttachVO selectByUuid(String uuid);
	
	// U
	
	
	// D
	void delete(String uuid);
	
	void deleteAll(Long bno);
	
	
	// LIST
	List<BoardAttachVO> selectByBno(Long bno);
	
	List<BoardAttachVO> pastFiles();
}
