package com.jafa.repository.board;

import com.jafa.domain.board.BoardInfoVO;

public interface BoardInfoRepository {

	// R
	BoardInfoVO read (String boardType);

	// U
	void update(BoardInfoVO vo);

}
