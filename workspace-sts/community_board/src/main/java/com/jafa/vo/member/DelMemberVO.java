package com.jafa.vo.member;

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
public class DelMemberVO {
    private String memberId;
    private String memberName; 
    private String email;
    private LocalDateTime regDate; 
    private LocalDateTime updateDate; 
    private String address; 
}
