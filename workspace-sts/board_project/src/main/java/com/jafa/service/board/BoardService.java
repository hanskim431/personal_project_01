package com.jafa.service.board;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jafa.domain.board.BoardVO;

import lombok.RequiredArgsConstructor;

public interface BoardService {
	
	//LIST
	List<BoardVO> getList();
	
	//C
	boolean register(BoardVO vo);
	
	//R
	BoardVO get(Long bno);
	
	//U
	boolean modify(BoardVO vo);
	
	//D
	boolean remove(Long bno);
	
}
