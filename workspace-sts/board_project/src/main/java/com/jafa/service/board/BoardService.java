package com.jafa.service.board;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.board.LikeDTO;
import com.jafa.domain.common.Criteria;

import lombok.RequiredArgsConstructor;

public interface BoardService {
	
	//LIST
	List<BoardVO> getList(Criteria criteria, String boardType);
	
	//C
	boolean register(BoardVO vo);
	
	//R
	BoardVO get(Long bno);
	
	//U
	boolean modify(BoardVO vo);
	
	//D
	boolean remove(Long bno);
	
	// TOTAL BOARD COUNT

	int totalCount(Criteria criteria, String boardType);

	// hit like
	boolean hitLike(LikeDTO likeDTO);
	
	// is like
	boolean isLike(LikeDTO likeDTO);
}
