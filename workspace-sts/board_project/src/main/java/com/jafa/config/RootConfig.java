package com.jafa.config;


import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySource(value = "classpath:database/db.properties")
@MapperScan("com.jafa.mapper")
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
		return sqlSessionFactoryBean.getObject();
	}

}
