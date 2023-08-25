package com.jafa.config;


import java.util.Properties;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySource(value = "classpath:database/db.properties")
@MapperScan("com.jafa.repository") // mapper를 스프링 빈으로 등록
@EnableTransactionManagement // 트랜잭션 설정 
@Import({SecurityConfig.class})
public class RootConfig {
	
	@Value("${db.driver}")
	private String driverClassName;
	
	@Value("${db.url}")
	private String jdbcUrl;
	
	@Value("${db.username}")
	private String username;
	
	@Value("${db.password}")
	private String password;
	
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		HikariConfig config = new HikariConfig();
		config.setDriverClassName(driverClassName);
		config.setJdbcUrl(jdbcUrl);
		config.setUsername(username);
		config.setPassword(password);
		return new HikariDataSource(config);
	} 
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception {
	SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
	sqlSessionFactoryBean.setDataSource(dataSource());
	sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver()
			.getResources("classpath:mappers/**/*Mapper.xml"));
	sqlSessionFactoryBean.setTypeAliasesPackage("com.jafa.domain"); // @alias 사용
	return sqlSessionFactoryBean.getObject();
	}
	
	// 트랜잭션 매니저 빈 등록
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	// 이메일 인증 
	@Bean
	public JavaMailSenderImpl mailSender() {
	    JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	    mailSender.setHost("smtp.naver.com");
		mailSender.setPort(587);
		mailSender.setUsername("eatcodeall@naver.com");
		mailSender.setPassword("zheldahdzl1!");

	    Properties properties = new Properties();
	    properties.put("mail.transport.protocol", "smtp");
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.debug", "true");
	    properties.put("mail.smtp.ssl.trust", "smtp.naver.com");
	    properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    mailSender.setJavaMailProperties(properties);
	    return mailSender;
	}

}
