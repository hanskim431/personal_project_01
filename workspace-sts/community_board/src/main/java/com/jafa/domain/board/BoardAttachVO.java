package com.jafa.domain.board;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardAttachVO {
	private String uuid;
	private Long bno; 
	private String uploadpath; 
	private String filetype; 
	private String filename; 
	private String regdate; 
	private String status;
}
