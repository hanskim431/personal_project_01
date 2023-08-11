package com.jafa.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;
import com.jafa.repository.board.BoardRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardRepository boardRepository;
	
	@Override
	public List<BoardVO> getList(Criteria criteria) {
		List<BoardVO> list = new ArrayList<>();
		return boardRepository.getList(criteria);
	}

	@Override
	public boolean register(BoardVO vo) {
//		log.info("### register: "+ vo);
		boardRepository.insert(vo);
		return true;

	}

	@Override
	public BoardVO get(Long bno) {
		return boardRepository.read(bno);
	}

	@Override
	public boolean modify(BoardVO vo) {
//		log.info("### modify: " + vo);
		boardRepository.update(vo);
		return true;
	}

	@Override
	public boolean remove(Long bno) {
//		log.info("### delete: "+ bno);
		boardRepository.delete(bno);
		return true;
	}

	@Override
	public int totalCount() {
		return boardRepository.getTotalCount();
	}

}
