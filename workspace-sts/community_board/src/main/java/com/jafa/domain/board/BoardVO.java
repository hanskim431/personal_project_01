package com.jafa.domain.board;

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
public class BoardVO {
		    private Long bno;
		    private String title;
		    private String content;
		    private String writer;
		    private String boardType;
		    private LocalDateTime regDate;
		    private LocalDateTime updateDate;
		    private String status;
		    private Long replyCnt;
		    private Long likeHit;
}
