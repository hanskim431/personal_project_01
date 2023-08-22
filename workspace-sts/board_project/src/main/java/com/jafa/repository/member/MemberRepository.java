package com.jafa.repository.member;

import com.jafa.domain.member.MemberVO;

public interface MemberRepository {
	
	// C
	/**
	 * Insert member to TBL_MEMBER
	 * @param MemberVO(memberId,memberPwd,memberName,email)
	 */
	void insert(MemberVO vo);
	
	// R
	/**
	 * 
	 * @param memberId
	 * @return MemberVO(memberId, memberPwd, membername, email, regdate, address, auth, enable)
	 */
	MemberVO read(String memberId);
	
	MemberVO selectById(String memberId);
	
	// U
	void update(MemberVO vo);
	
	// D
	
	
	// LIST
	
	
}
