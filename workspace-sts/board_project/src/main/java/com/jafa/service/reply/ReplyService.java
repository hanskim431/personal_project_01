package com.jafa.service.reply;

import java.util.List;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyVO;

public interface ReplyService {

	/**
	 * 댓글의 리스트를 출력하는 서비스 함수
	 * @param {int , int} criteria 
	 * @param bno
	 * @return
	 */
	List<ReplyVO> getList(Criteria criteria, Long bno);
	
	//C
	int register(ReplyVO vo);
	
	//R
	ReplyVO get(Long rno);
	
	//U
	int modify(ReplyVO vo);
	
	//D
	int remove(Long rno);
	
}
