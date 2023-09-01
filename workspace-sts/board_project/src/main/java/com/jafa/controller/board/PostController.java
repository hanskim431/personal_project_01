package com.jafa.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.service.board.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping({"/mypost"})
public class PostController {
	
	@Autowired
	private BoardService boardService;
	
//
//	// ========= 게시글 ========= 
//	// 게시글 리스트 조회 페이지
//	@GetMapping({"","/","/list"})
//	public String list(@PathVariable String boardType, Model model, Criteria criteria) {
//		if(boardType.equals("list")) {
//			return "home";
//		}
//		log.info(boardType);
//		model.addAttribute("boardType", boardType);
//		model.addAttribute("list", boardService.getList(criteria, boardType));
//		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria, boardType)));
//		return "/board/list";
//	}

	
}
