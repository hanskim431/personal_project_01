package com.jafa.domain.reply;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReplyVO {
	private Long rno;
	private Long bno;
	private String boardType;
	private String reply;
	private String replyer;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private LocalDateTime regdate;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private LocalDateTime updatedate;
	
	private String status;
	private Long likehit;
	
}
