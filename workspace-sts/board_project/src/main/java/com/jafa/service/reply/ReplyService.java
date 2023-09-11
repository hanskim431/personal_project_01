package com.jafa.service.reply;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyPageDTO;
import com.jafa.domain.reply.ReplyVO;

public interface ReplyService {

	/**
	 * 댓글의 리스트를 출력하는 서비스 함수
	 * @param {int , int} criteria 
	 * @param bno
	 * @return
	 */
	ReplyPageDTO getList(Criteria criteria, Long bno);
	
	/**
	 * memberId로 댓글 리스트를 검색하는 서비스 함수
	 * @param {int , int} criteria 
	 * @param String replyer
	 * @return
	 */
	ReplyPageDTO selectByMemberId(Criteria criteria, String replyer);
	
	//C
	int register(ReplyVO vo);
	
	//R
	ReplyVO get(Long rno);
	
	//U
	int modify(ReplyVO vo);
	
	//D
	int remove(Long rno);
	
}
