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
	public void register(ReplyVO vo) {
		replyRepository.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return replyRepository.read(rno);
	}

	@Override
	public void modify(ReplyVO vo) {
		replyRepository.update(vo);
	}

	@Override
	public void remove(Long rno) {
		replyRepository.delete(rno);
	}

}
