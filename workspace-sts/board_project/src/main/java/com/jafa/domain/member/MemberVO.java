package com.jafa.domain.member;

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
public class MemberVO {
    private String memberId;
    private String memberPwd;
    private String memberName; 
    private String email;
    private LocalDateTime regDate; 
    private String address; 
}
