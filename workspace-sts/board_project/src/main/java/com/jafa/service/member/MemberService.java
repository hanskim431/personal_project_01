package com.jafa.service.member;

import java.util.Map;

import com.jafa.domain.member.MemberVO;

public interface MemberService {

// C
	/**
	 * INSERT member to TBL_MEMBER : service
	 * 
	 * @param MemberVO(memberId, memberPwd, memberName, email)
	 */
	void join(MemberVO vo);

// R
	/**
	 * SELECT member for role admin : service
	 * 
	 * @param memberId
	 * @return MemberVO
	 */
	MemberVO read(String memberId);

	/**
	 * SELECT member for role member : service
	 * 
	 * @param memberId
	 * @return MemberVO
	 */
	MemberVO selectById(String memberId);
	
	/**
	 * SELECT member by email : service
	 * 
	 * @param email
	 * @return String (email)
	 */
	String selectByEmail(String email);

// U
	/**
	 * UPDATE member information to TBL_MEMBER : service 
	 * SET (memberName, address) where (memberId)
	 * 
	 * @param MemberVO(memberName, address, memberId)
	 */
	void modify(MemberVO vo);
	
	/**
	 * UPDATE member password to TBL_MEMBER : service 
	 * SET (memberPwd) WHERE (memberId)
	 * 
	 * @param memberMap(Map<memberId, memberPwd>)
	 */
	void changePassword(Map<String, String> memberMap);

// D

// LIST

}