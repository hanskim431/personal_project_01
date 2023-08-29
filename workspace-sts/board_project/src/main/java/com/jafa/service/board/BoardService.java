package com.jafa.service.board;

import java.util.List;

import com.jafa.domain.board.BoardAttachVO;
import com.jafa.domain.board.BoardVO;
import com.jafa.domain.board.LikeDTO;
import com.jafa.domain.common.Criteria;

public interface BoardService {

	//LIST
	List<BoardVO> getList(Criteria criteria, String boardType);
	
	List<BoardAttachVO> getAttachList(Long bno);
	
	//C
	void register(BoardVO vo);
	
	//R
	BoardVO get(Long bno);
	
	//U
	boolean modify(BoardVO vo);
	
	//D
	boolean remove(Long bno);
	
	
	// TOTAL BOARD COUNT
	int totalCount(Criteria criteria, String boardType);

	// 게시물 추천 기능
	boolean hitLike(LikeDTO likeDTO);
	
	// 추천 토글 확인
	boolean isLike(LikeDTO likeDTO);
	
	// 첨부파일 확인
	BoardAttachVO getAttach(String uuid);
	
}
