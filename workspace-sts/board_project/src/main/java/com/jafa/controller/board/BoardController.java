package com.jafa.controller.board;

import java.nio.file.AccessDeniedException;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.board.BoardAttachVO;
import com.jafa.domain.board.BoardVO;
import com.jafa.domain.board.LikeDTO;
import com.jafa.domain.common.Criteria;
import com.jafa.domain.common.Pagination;
import com.jafa.service.board.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping({"/board/{boardType}"})
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	private String[] boardNames = {"road","mtb","commuter","touring","gears","repair","shop","lost-and-found"};

	// ========= 게시글 ========= 
	// 게시글 리스트 조회 페이지
	@GetMapping({"","/","/list"})
	public String list(@PathVariable String boardType, Model model, Criteria criteria) {
		boolean isBoard = false;
		
		if(boardType.equals("list")) {
			return "home";
		}
		
		if (!Arrays.asList(boardNames).contains(boardType)) {
		    throw new IllegalArgumentException("유효하지 않은 게시판 종류입니다."); // 예외 던지기
		}

		
		log.info(boardType);
		model.addAttribute("boardType", boardType);
		model.addAttribute("info", boardService.readBoardInfo(boardType));
		model.addAttribute("list", boardService.getList(criteria, boardType));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria, boardType)));
		return "/board/list";
	}
	
	// 게시글 첨부파일 리스트 조회
	@GetMapping("/getAttachList")
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttchList(Long bno){
		return new ResponseEntity<List<BoardAttachVO>>(boardService.getAttachList(bno),HttpStatus.OK);
	}
	
	// 게시글 조회 페이지
	@GetMapping("/get")
	public String get(@PathVariable String boardType, Model model, 
						@RequestParam("bno") Long bno, Criteria criteria) {
		model.addAttribute("board", boardService.get(bno));
		model.addAttribute("boardType", boardType);
		return "/board/get";
	}
	
	// 게시글 작성 페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public String register(@PathVariable String boardType, Model model) {
		log.info(boardType);
		model.addAttribute("boardType", boardType);
		return "board/register";
	}
	
	// 게시글 작성 처리
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(@PathVariable String boardType, BoardVO vo, RedirectAttributes rttr) {
		log.info("getAttachList:"+vo.getAttachList());
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno()); // ${result}
		rttr.addFlashAttribute("operation", "register");
		return "redirect:/board/"+boardType;
//		return "redirect:/board"+boardType+"/get?bno="+vo.getBno();
	}
	
	// 게시글 수정 페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String modify(@PathVariable String boardType, Model model, @RequestParam("bno") Long bno, 
			Criteria criteria, RedirectAttributes rttr, Authentication auth) throws AccessDeniedException {
		BoardVO vo = boardService.get(bno);
		log.info(vo);
		String username = auth.getName();
		if (!vo.getWriter().equals(username)
				&& !auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			throw new AccessDeniedException("Access denied");
		}
		model.addAttribute("board", boardService.get(bno));
		return "board/modify";

	}
	
	// 게시글 수정 처리 페이지
	@PreAuthorize("isAuthenticated() and principal.username== #vo.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(@PathVariable String boardType, BoardVO vo, RedirectAttributes rttr, Criteria criteria) {
//		log.info(vo.getBno());
		boardService.modify(vo);
		rttr.addFlashAttribute("result",vo.getBno());
		rttr.addAttribute("pageNum",criteria.getPageNum());
		rttr.addAttribute("amount",criteria.getAmount());
//		return "redirect:/board/list";
		return "redirect:/board/"+boardType + "/get?bno=" + vo.getBno();
	}

	// 게시글 삭제 처리 페이지
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
	
	// 게시물 추천 처리
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/like", produces = "plain/text; charset=utf-8")
	public ResponseEntity<String> hitLike(LikeDTO likeDTO){
		log.info(likeDTO.getMemberId());
		log.info(likeDTO.getBno());

		String message = likeDTO.getBno() + "번";
		if(boardService.hitLike(likeDTO)) {
			message += "게시글을 추천하였습니다.";
		} else {
			message += "게시글의 추천을 취소하였습니다.";
		}
		return new ResponseEntity<String>(message,HttpStatus.OK);
	}
	
	// 게시물 추천 확인
	@ResponseBody
	@PostMapping(value = "/islike")
	public ResponseEntity<Boolean> isLike(LikeDTO likeDTO){
		return new ResponseEntity<>(boardService.isLike(likeDTO),HttpStatus.OK);
	}
	
	// 첨부파일 확인
	@GetMapping("/getAttachFileInfo")
	@ResponseBody
	public ResponseEntity<BoardAttachVO> getAttach(String uuid){
		return new ResponseEntity<BoardAttachVO>(boardService.getAttach(uuid),HttpStatus.OK);
	}
}
