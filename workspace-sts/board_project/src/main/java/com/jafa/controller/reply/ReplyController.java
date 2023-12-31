package com.jafa.controller.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.jafa.domain.common.Criteria;
import com.jafa.domain.reply.ReplyPageDTO;
import com.jafa.domain.reply.ReplyVO;
import com.jafa.service.reply.ReplyService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	// LIST
	@GetMapping("/pages/{bno}/{page}")
	private ResponseEntity<ReplyPageDTO> getList(@PathVariable int page, @PathVariable Long bno) {
		Criteria criteria = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.getList(criteria, bno), HttpStatus.OK);
	}
	
	@GetMapping("/replyer/{replyer}/{page}")
	private ResponseEntity<ReplyPageDTO> getListByMemberId(@PathVariable int page, @PathVariable String replyer) {
		Criteria criteria = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.selectByMemberId(criteria, replyer), HttpStatus.OK);
	}

	// C
	@PostMapping("/new")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		int result = replyService.register(vo);
		return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// R
	@GetMapping("/{rno}")
	private ResponseEntity<ReplyVO> get(@PathVariable Long rno) {
		return new ResponseEntity<>(replyService.get(rno), HttpStatus.OK);
	}

	// U
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable Long rno) {
		vo.setRno(rno);
		int result = replyService.modify(vo);
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// D
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> delete(@PathVariable Long rno) {
		int result = replyService.remove(rno);
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}