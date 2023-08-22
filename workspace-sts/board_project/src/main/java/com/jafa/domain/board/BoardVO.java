package com.jafa.domain.board;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Alias("board")
public class BoardVO {
		    private Long bno;
		    
		    private String title;
		    private String content;
		    private String writer;
		    
		    private LocalDateTime regDate;
		    private LocalDateTime updateDate;
		    
		    private String boardType;
		    private String status;
		    
		    private int replyCnt;
		    private int likeHit;
}
