package com.jafa.repository.board;

import java.util.List;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;

public interface BoardRepository {

	
	// List
	List<BoardVO> getList(Criteria criteria);
	
	// C
	void insert(BoardVO vo);
	
	// R
	BoardVO read(Long bno);
	
	// U
	void update(BoardVO vo);
	
	// D
	void delete(Long bno);
	
	// 전체 게시물 수
	int getTotalCount();
	
	
}
