package com.jafa.domain.reply;

import java.time.LocalDateTime;

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
public class ReplyLikeDTO {
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private LocalDateTime regdate;
	private LocalDateTime updatedate;
	private String status;
	private Long likehit;
}
