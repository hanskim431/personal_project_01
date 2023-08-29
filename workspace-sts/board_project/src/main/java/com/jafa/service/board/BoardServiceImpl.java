package com.jafa.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.domain.board.BoardAttachVO;
import com.jafa.domain.board.BoardVO;
import com.jafa.domain.board.LikeDTO;
import com.jafa.domain.common.Criteria;
import com.jafa.repository.board.ArticleLikeRepository;
import com.jafa.repository.board.BoardAttachRepository;
import com.jafa.repository.board.BoardRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private BoardAttachRepository boardAttachRepository;

	@Autowired
	private ArticleLikeRepository articleLikeRepository;

	//LIST
	@Override
	public List<BoardVO> getList(Criteria criteria, String boardType) {
		List<BoardVO> list = new ArrayList<>();
		return boardRepository.getList(criteria, boardType);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return boardAttachRepository.selectByBno(bno);
	}

	//C
	@Transactional
	@Override
	public void register(BoardVO board) {
		boardRepository.insertSelectKey(board);

		log.info("bno:"+board.getBno());
		// 첨부파일이 있을 때
		if(board.getAttachList()!=null && !board.getAttachList().isEmpty()) { 
			board.getAttachList().forEach(attachFile->{
				attachFile.setBno(board.getBno());
				boardAttachRepository.insert(attachFile);
			});
		}
	}

	//R
	@Override
	public BoardVO get(Long bno) {
		return boardRepository.read(bno);
	}

	//U
	@Override
	public boolean modify(BoardVO vo) {
//		log.info("### modify: " + vo);
		boardRepository.update(vo);
		return true;
	}

	//D
	@Override
	public boolean remove(Long bno) {
//		log.info("### delete: "+ bno);
		boardRepository.delete(bno);
		return true;
	}

	// TOTAL BOARD COUNT
	// TODO boardType?
	@Override
	public int totalCount(Criteria criteria, String boardType) {
		boardType = "board1";
		return boardRepository.getTotalCount(criteria, boardType);
	}

	// 게시물 추천 기능
	@Transactional
	@Override
	public boolean hitLike(LikeDTO likeDTO) {
		LikeDTO result = articleLikeRepository.get(likeDTO);
		if(result==null) { // 추천
			articleLikeRepository.insert(likeDTO);
			boardRepository.updateLikeCnt(likeDTO.getBno(), 1);
			return true;
		} else { // 추천 취소
			articleLikeRepository.delete(likeDTO);
			boardRepository.updateLikeCnt(likeDTO.getBno(), -1);
			return false;
		}
	}

	// 추천 토글 확인
	@Override
	public boolean isLike(LikeDTO likeDTO) {
		return articleLikeRepository.get(likeDTO)!=null;
	}

	// 첨부파일 확인
	@Override
	public BoardAttachVO getAttach(String uuid) {
		return boardAttachRepository.selectByUuid(uuid);
	}


}
