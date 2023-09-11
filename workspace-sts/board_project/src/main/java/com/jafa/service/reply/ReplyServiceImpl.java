package com.jafa.service.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyPageDTO;
import com.jafa.domain.reply.ReplyVO;
import com.jafa.repository.board.BoardRepository;
import com.jafa.repository.reply.ReplyRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyRepository replyRepository;

	@Autowired
	private BoardRepository boardRepository;
	
	@Override
	public ReplyPageDTO getList(Criteria criteria, Long bno) {
		return new ReplyPageDTO(
				replyRepository.getTotalCount(bno),
				replyRepository.getList(criteria, bno));
	}

	@Override
	public ReplyPageDTO selectByMemberId(Criteria criteria, String replyer) {
		return new ReplyPageDTO(
				replyRepository.getTotalCountByMemberId(replyer),
				replyRepository.selectByMemberId(criteria, replyer)
				);
	}

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		boardRepository.updateReplyCnt(vo.getBno(), 1);
		return replyRepository.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return replyRepository.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		replyRepository.update(vo);
		return 1;
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		ReplyVO vo = replyRepository.read(rno);
		boardRepository.updateReplyCnt(vo.getBno(), -1);
		return replyRepository.delete(rno);
	}

}
