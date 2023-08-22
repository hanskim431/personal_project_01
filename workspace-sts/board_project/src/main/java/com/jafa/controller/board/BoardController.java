package com.jafa.controller.board;

import java.nio.file.AccessDeniedException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping("/board/{boardType}")
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping({"","/","/list"})
	public String list(@PathVariable String boardType, Model model, Criteria criteria) {
		if(boardType.equals("list")) {
			return "home";
		}
		log.info(boardType);
		model.addAttribute("boardType", boardType);
		model.addAttribute("list", boardService.getList(criteria, boardType));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria, boardType)));
		return "/board/list";
	}
	
	@GetMapping("/get")
	public String get(@PathVariable String boardType, Model model, 
						@RequestParam("bno") Long bno, Criteria criteria) {
		model.addAttribute("board", boardService.get(bno));
		model.addAttribute("boardType", boardType);
		return "/board/get";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public String register(@PathVariable String boardType) {
		return "board/register";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(@PathVariable String boardType, BoardVO vo, RedirectAttributes rttr) {
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		return "redirect:/board/"+boardType;
//		return "redirect:/board/get?bno="+vo.getBno();
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String modify(@PathVariable String boardType, Model model, 
						@RequestParam("bno") Long bno, RedirectAttributes rttr,
						Authentication auth) throws AccessDeniedException {
		BoardVO vo = boardService.get(bno);
		String username = auth.getName();
		if(!vo.getWriter().equals(username) && !auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			throw new AccessDeniedException("Access denied"); 
		}
		model.addAttribute("board", boardService.get(bno));
		return "board/modify";
		
	}
	
	@PreAuthorize("isAuthenticated() and principal.username== #vo.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(@PathVariable String boardType, BoardVO vo, RedirectAttributes rttr, Criteria criteria) {
		boardService.modify(vo);
		rttr.addFlashAttribute("result",vo.getBno());
		rttr.addAttribute("pageNum",criteria.getPageNum());
		rttr.addAttribute("amount",criteria.getAmount());
//		return "redirect:/board/list";
		return "redirect:/board/"+boardType+"/get?bno="+vo.getBno();
	}
	
	@PreAuthorize("isAuthenticated() and principal.username== #writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(@PathVariable String boardType, Long bno, String writer, RedirectAttributes rttr, Criteria criteria) {
		if(boardService.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum",criteria.getPageNum());
		rttr.addAttribute("amount",criteria.getAmount());
		return "redirect:/board/"+boardType+"/list";
	}
}
