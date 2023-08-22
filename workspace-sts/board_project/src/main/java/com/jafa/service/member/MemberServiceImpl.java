package com.jafa.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.domain.member.AuthVO;
import com.jafa.domain.member.MemberVO;
import com.jafa.repository.auth.AuthRepository;
import com.jafa.repository.member.MemberRepository;

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
	public void join(MemberVO vo) {
		vo.setMemberPwd(passwordEncoder.encode(vo.getMemberPwd()));
		memberRepository.insert(vo);
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

	// U
	@Override
	public void modify(MemberVO vo) {
		memberRepository.update(vo);
	}

	// D
	
}
