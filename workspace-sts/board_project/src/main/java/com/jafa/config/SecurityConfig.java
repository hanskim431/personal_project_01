package com.jafa.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	// Spring Security의 웹 보안 설정
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/guest/**").permitAll()
			.antMatchers("/member/**").access("hasRole('ROLE_MEMBER')")
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')");
		
		http.formLogin(); // 스프링 시큐리티 로그인 폼
	}
	
}
