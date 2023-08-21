package com.jafa.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.jafa.security.CustomUserDetailService;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity
@ComponentScan("com.jafa.security")
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
	private AccessDeniedHandler accessDeniedHandler;
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
	@Autowired
	private AuthenticationFailureHandler authenticationFailureHandler; 
	
	@Autowired
	private CustomUserDetailService customUserDetailService;
	
	// Spring Security의 웹 보안 설정
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/guest/**").permitAll()
			.antMatchers("/member/**").access("hasRole('ROLE_MEMBER')")
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')");
		
		http.formLogin() // 스프링 시큐리티 로그인 폼
			.loginPage("/login")
			.loginProcessingUrl("/user/login")
			.usernameParameter("memberId")
			.passwordParameter("memberPwd")
			.successHandler(authenticationSuccessHandler)
			.failureHandler(authenticationFailureHandler);
		
		http.logout().logoutUrl("/user/logout").invalidateHttpSession(true);
			
		http.exceptionHandling().accessDeniedPage("/accessDenied"); // 403에러 발생시 페이지를 당겨옴
		http.exceptionHandling().accessDeniedHandler(accessDeniedHandler);
		
		http.formLogin().loginPage("/login");
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserDetailService)
			.passwordEncoder(passwordEncoder());
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
