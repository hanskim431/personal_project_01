package com.jafa.repository.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;

public interface BoardRepository {

	
	// List
	List<BoardVO> getList(
			@Param("criteria") Criteria criteria, 
			@Param("boardType") String boardType);
	
	List<BoardVO> getListAll(Criteria criteria);
	
	// C
	void insert(BoardVO vo);
	
	// R
	BoardVO read(Long bno);
	
	// U
	void update(BoardVO vo);
	
	// D
	void delete(Long bno);
	
	// 전체 게시물 수
	int getTotalCount(Criteria criteria);
	
	// 댓글 수 셈
	void updateReplyCnt(
			@Param("bno") Long bno, 
			@Param("amount") int amount);
}
