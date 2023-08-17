package com.jafa.domain.reply;

import java.util.List;

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
public class ReplyPageDTO {
	private int replyCount;
	private List<ReplyVO> list;
}
