package com.jafa.domain.member;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Alias("auth")
public class AuthVO {
	private String memberId;
	private String auth;
	private String enable;
}
