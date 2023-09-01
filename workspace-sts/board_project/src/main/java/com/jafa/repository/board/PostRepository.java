package com.jafa.repository.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;

public interface PostRepository {

	// List
	List<BoardVO> getList(
			@Param("criteria") Criteria criteria, 
			@Param("boardType") String boardType);

	List<BoardVO> getListAll(@Param("criteria") Criteria criteria);

	// C
	void insert(BoardVO vo);
	
	Integer insertSelectKey(BoardVO vo);

	// R
	BoardVO read(Long bno);

	// U
	int update(BoardVO vo);

	// D
	int delete(Long bno);

	// 전체 게시물 수
	int getTotalCount(
			@Param("criteria") Criteria criteria, 
			@Param("boardType") String boardType);

	// 댓글 수 셈
	void updateReplyCnt(
			@Param("bno") Long bno, 
			@Param("amount") int amount);
	
	// 추천 수
	void updateLikeCnt(
			@Param("bno") Long bno,
			@Param("amount") int amount);
}
