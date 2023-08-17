package com.jafa.controller.reply;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jafa.AppTest;
import com.jafa.domain.reply.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyControllerTest extends AppTest{
	
	@Autowired
	WebApplicationContext ctx;
	
	ObjectMapper objectMapper;
	
	public MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		objectMapper = Jackson2ObjectMapperBuilder.json().build(); 
	}
	
	
	//C
	@Ignore
	@Test
	public void testRegister() throws Exception {
		ReplyVO vo = ReplyVO.builder()
				.bno(1L)
				.reply("웹 계층 : 댓글추가2")
				.replyer("admin2")
				.status("VISIBLE")
				.build();
		String content = objectMapper.writeValueAsString(vo);
		mockMvc.perform(post("/replies/new")
				.content(content)
				.contentType(MediaType.APPLICATION_JSON)
		).andReturn();
	}
	
	//U
//	@Ignore
	@Test
	public void testModify() throws Exception {
		ReplyVO vo = ReplyVO.builder()
				.reply("웹 계층 : 댓글 수정1")
				.build();
		String content = objectMapper.writeValueAsString(vo);
		mockMvc.perform(put("/replies/2")
				.content(content)
				.contentType(MediaType.APPLICATION_JSON)
				).andReturn();
	}
	
	//D
	@Ignore
	@Test
	public void testDelete() throws Exception {
		mockMvc.perform(delete("/replies/2"));
	}
}
