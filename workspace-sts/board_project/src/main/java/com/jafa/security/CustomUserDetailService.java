package com.jafa.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.jafa.domain.member.MemberVO;
import com.jafa.repository.member.MemberRepository;

@Component
public class CustomUserDetailService implements UserDetailsService {

	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO memberVO = memberRepository.read(username);
		if(memberVO == null) {
			throw new UsernameNotFoundException("사용자 정보를 찾을 수 없음 : " + username);
		}
		return new CustomUser(memberVO);
	}

}