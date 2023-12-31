package com.jafa.service.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.domain.member.AuthVO;
import com.jafa.domain.member.MemberVO;
import com.jafa.exception.PasswordMisMatchException;
import com.jafa.repository.auth.AuthRepository;
import com.jafa.repository.member.MemberRepository;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private AuthRepository authRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// C
	@Transactional
	@Override
	public void join(MemberVO memberVO) {
		memberVO.setMemberPwd(passwordEncoder.encode(memberVO.getMemberPwd()));
		memberRepository.insert(memberVO);
		
		AuthVO authVO = new AuthVO(memberVO.getMemberId(),"ROLE_MEMBER","ACTIVE");
		authRepository.insert(authVO);
	}

	// R
	@Override
	public MemberVO read(String memberId) {
		return memberRepository.read(memberId);
	}

	@Override
	public MemberVO selectById(String memberId) {
		return memberRepository.selectById(memberId);
	}
	
	@Override
	public String selectByEmail(String email) {
		return memberRepository.selectByEmail(email);
	}
	
	// U
	@Transactional
	@Override
	public void modify(MemberVO vo) {
		memberRepository.update(vo);
	}

	@Override
	public void changePassword(Map<String, String> memberMap) {
		String memberId = memberMap.get("memberId");
		
		String newPwd = memberMap.get("newPwd");
		
		String currentPwd = memberMap.get("currentPwd");
		
		MemberVO vo = memberRepository.read(memberId);
		
		if(!passwordEncoder.matches(currentPwd, vo.getMemberPwd())) {
			throw new PasswordMisMatchException();
		}
		
		memberRepository.updatePassword(memberId, passwordEncoder.encode(newPwd));
	}

	// D
	
}
