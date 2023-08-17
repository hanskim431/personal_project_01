package com.jafa.controller.board;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import com.jafa.AppTest;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardControllerTest extends AppTest{

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc; 
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Ignore
	@Test
	public void testGetList() throws Exception {
		ModelMap modelMap = mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
		.andReturn()
		.getModelAndView()
		.getModelMap();
		log.info(modelMap);
	}
	
	@Ignore
	@Test
	public void testGet() throws Exception {
		ModelMap modelMap = mockMvc.perform(MockMvcRequestBuilders.get("/board/get?bno=1"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(modelMap);
	}
	
	@Ignore
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders
				.post("/board/register")
					.param("title", "MVC 테스트 제목")
					.param("content", "MVC 테스트 내용")
					.param("writer", "admin")
					.param("boardType", "BOARD3")
					.param("status", "HIDDEN")
					)
				.andReturn()
				.getModelAndView()
				.getViewName();
		log.info(resultPage);
	}
	
//	@Ignore
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders
				.post("/board/modify?bno=2")
				.param("title", "MVC 수정 제목")
				.param("content", "MVC 수정 내용")
				.param("writer", "admin")
				.param("boardType", "BOARD3")
				)
				.andReturn()
				.getModelAndView()
				.getViewName();
		log.info(resultPage);
	}
	
	@Ignore
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders
				.post("/board/remove?bno=5"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		log.info(resultPage);
	}
}
