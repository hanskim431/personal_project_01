package com.jafa.vo.board;

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
		    private String boardtype;
		    private LocalDateTime regdate;
		    private LocalDateTime updatedate;
		    private String status;
		    private Long replycnt;
		    private Long likehit;
}
