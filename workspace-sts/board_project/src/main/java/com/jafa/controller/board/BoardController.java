package com.jafa.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.board.BoardVO;
import com.jafa.domain.common.Criteria;
import com.jafa.domain.common.Pagination;
import com.jafa.service.board.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public String list(Model model, Criteria criteria) {
		model.addAttribute("list", boardService.getList(criteria));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount()));
		return "/board/list";
	}
	
	@GetMapping("/get")
	public String get(Model model, @RequestParam("bno") Long bno, Criteria criteria) {
		model.addAttribute("board", boardService.get(bno));
		return "/board/get";
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {		
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		return "redirect:/board/list";
//		return "redirect:/board/get?bno="+vo.getBno();
	}
	
	@GetMapping("/modify")
	public void modify(Model model, @RequestParam("bno") Long bno, RedirectAttributes rttr) {
		model.addAttribute("board", boardService.get(bno));
		
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		boardService.modify(vo);
		rttr.addFlashAttribute("result",vo.getBno());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		if(boardService.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
}
