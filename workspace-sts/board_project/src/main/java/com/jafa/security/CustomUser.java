package com.jafa.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.jafa.domain.member.MemberVO;

import lombok.Getter;
import lombok.Setter;

@Getter // 지정하지 않으면 오류 뜸
@Setter
/*
 * org.springframework.beans.NotReadablePropertyException: Invalid property
 * 'principal.memberVO' of bean class
 * [org.springframework.security.authentication
 * .UsernamePasswordAuthenticationToken]: Bean property 'principal.memberVO' is
 * not readable or has an invalid getter method: Does the return type of the
 * getter match the parameter type of the setter? at
 * org.springframework.beans.AbstractNestablePropertyAccessor.getPropertyValue
 */
public class CustomUser extends User{
	private static final long serialVersionUID = -1794558029817021167L;
	
	private MemberVO memberVO; 
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMemberId(), memberVO.getMemberPwd(), 
				memberVO.getAuthList().stream()
					.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
					.collect(Collectors.toList()));
		this.memberVO = memberVO; 
	}
	
}