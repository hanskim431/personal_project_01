package com.jafa.service.reply;

import java.util.List;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyVO;

public interface ReplyService {

	//LIST
	List<ReplyVO> getList(Criteria criteria, Long bno);
	
	//C
	void register(ReplyVO vo);
	
	//R
	ReplyVO get(Long rno);
	
	//U
	void modify(ReplyVO vo);
	
	//D
	void remove(Long rno);
	
}
