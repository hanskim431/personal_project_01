package com.jafa.repository.member;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.member.MemberVO;

public interface MemberRepository {

	// C
	/**
	 * INSERT member to TBL_MEMBER : repository
	 * 
	 * @param MemberVO(memberId, memberPwd, memberName, email)
	 */
	void insert(MemberVO vo);

	// R
	/**
	 * SELETE member for role admin : repository
	 * 
	 * @param memberId
	 * @return MemberVO(memberId, memberPwd, membername, email, regdate, address, auth, enable)
	 */
	MemberVO read(String memberId);

	/**
	 * SELETE member for role member : repository
	 * 
	 * @param memberId
	 * @return MemberVO (memberId, memberName, email, regDate, address)
	 */
	MemberVO selectById(String memberId);

	// U
	/**
	 * UPDATE member information to TBL_MEMBER : repository 
	 * set (memberName, address) where (memberId)
	 * 
	 * @param MemberVO(memberName, address, memberId)
	 */
	void update(MemberVO vo);
	

	/**
	 * UPDATE member password to TBL_MEMBER : repository 
	 * set (memberPwd) where (memberId)
	 * 
	 * @param MemberVO(memberPwd, memberId)
	 */
	void updatePassword(
			@Param("memberId") String memberId,
			@Param("memberPwd") String memberPwd);
	

	// D

	// LIST

}
