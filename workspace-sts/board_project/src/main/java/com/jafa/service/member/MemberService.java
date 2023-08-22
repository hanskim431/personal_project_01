package com.jafa.service.member;

import com.jafa.domain.member.MemberVO;

public interface MemberService {

// C
void join(MemberVO vo);

// R
/**
 * select member for role admin
 * @param memberId
 * @return MemberVO
 */
MemberVO read(String memberId);

/**
 * select member for role member
 * @param memberId
 * @return MemberVO
 */
MemberVO selectById(String memberId);

// U
void modify(MemberVO vo);

// D


// LIST

}