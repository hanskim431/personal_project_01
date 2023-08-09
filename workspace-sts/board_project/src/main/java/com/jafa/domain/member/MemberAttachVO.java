package com.jafa.domain.member;

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
public class MemberAttachVO {
	private String uuid;
	private Long memberId; 
	private String uploadPath;
	private String fileType; 
	private String fileName; 
	private String regDate; 
	private String status;
}
