package com.jafa.config;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.jafa.security.CustomUserDetailService;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity
@ComponentScan("com.jafa.security")
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
	private DataSource dataSource;
	
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
		
		// 한글 인코딩
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("utf-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
		
		// 접근 권한 
		http.authorizeRequests().antMatchers("/guest/**").permitAll();
		
		// 로그인 폼
		http.formLogin().loginPage("/login");

		// 로그인 
		http.formLogin() // 스프링 시큐리티 로그인 폼
			.loginPage("/login")
			.loginProcessingUrl("/user/login")
			.usernameParameter("memberId")
			.passwordParameter("memberPwd")
			.successHandler(authenticationSuccessHandler)
			.failureHandler(authenticationFailureHandler);
		
		// 로그아웃
		http.logout().logoutUrl("/user/logout").invalidateHttpSession(true)
				.deleteCookies("remember-me","JSESSION_ID");
		
		// 기억하기
		http.rememberMe().key("jafa")
			.tokenRepository(persistentTokenRepository())
			.tokenValiditySeconds(604800); // 604800 sec = 1 week
		
		// 403
		http.exceptionHandling().accessDeniedPage("/accessDenied"); // 403에러 발생시 페이지를 당겨옴
		http.exceptionHandling().accessDeniedHandler(accessDeniedHandler);
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
	
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl jdbcTokenRepositoryImpl = new JdbcTokenRepositoryImpl();
		jdbcTokenRepositoryImpl.setDataSource(dataSource);
		return jdbcTokenRepositoryImpl;
	}
}
