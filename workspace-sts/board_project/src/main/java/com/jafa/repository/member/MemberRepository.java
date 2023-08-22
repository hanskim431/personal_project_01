package com.jafa.repository.member;

import com.jafa.domain.member.MemberVO;

public interface MemberRepository {
	
	MemberVO read(String memberId);
	
	void insert(MemberVO vo);
	
	void update(MemberVO vo);
	
	MemberVO selectById(String memberId);
}
