package com.jafa.repository.reply;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyVO;

public interface ReplyRepository {
	
	//LIST
	List<ReplyVO> getList(
			@Param("criteria") Criteria criteria, 
			@Param("bno")  Long bno);
	
	//C
	int insert(ReplyVO vo);
	
	
	//R
	ReplyVO read(Long rno);
	
	
	//U
	void update(ReplyVO vo);
	
	
	//D
	int delete(Long rno);
	
	//getTotalCount
	int getTotalCount(Long bno);

}
