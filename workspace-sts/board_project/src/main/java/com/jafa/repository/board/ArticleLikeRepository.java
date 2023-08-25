package com.jafa.repository.board;

import com.jafa.domain.board.LikeDTO;

public interface ArticleLikeRepository {

	// C
	void insert(LikeDTO likeDTO);
	
	// R
	LikeDTO get(LikeDTO likeDTO);
	
	// U 
	
	
	// D
	void delete(LikeDTO likeDTO);
	
}
