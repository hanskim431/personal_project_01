package com.jafa.repository.board;

import java.util.List;

import com.jafa.domain.board.BoardVO;

public interface BoardRepository {

	// List
	List<BoardVO> getList();
	
	// C
	void insert(BoardVO vo);
	
	// R
	BoardVO read(Long bno);
	
	// U
	
	
	// D
	
	
	
}
