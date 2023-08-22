package com.jafa.domain.member;

import java.time.LocalDateTime;
import java.util.List;

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
@Alias("member")
public class MemberVO {
    private String memberId;
    private String memberPwd;
    private String memberName; 
    private String email;
    private LocalDateTime regDate; 
    private String address; 
    
    private List<AuthVO> authList;
}
