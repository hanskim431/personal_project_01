package com.jafa.domain.board;

import org.apache.ibatis.type.Alias;

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
@Alias("boardAttach")
public class BoardAttachVO {
	private String uuid;
	private Long bno; 
	private String uploadPath; 
	private boolean fileType; 
	private String fileName; 
	private String regDate; 
	private String status;
}
