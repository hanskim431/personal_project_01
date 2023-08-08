package com.jafa.config;

import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariConfig;

@Configuration
public class AppCtx {

	HikariConfig config = new HikariConfig();

	
}
