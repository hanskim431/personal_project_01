package com.jafa.service.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyVO;
import com.jafa.repository.reply.ReplyRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyRepository replyRepository;
	
	@Override
	public List<ReplyVO> getList(Criteria criteria, Long bno) {
		return replyRepository.getList(criteria, bno);
	}

	@Override
	public int register(ReplyVO vo) {
		replyRepository.insert(vo);
		return 1;
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

	@Override
	public int remove(Long rno) {
		replyRepository.delete(rno);
		return 1;
	}

}
