package com.jafa.domain.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//@AllArgsConstructor
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
	public int getMaxRow() {
		return pageNum*amount;
	}
	
	public int getMinRow() {
		return (pageNum-1)*amount;
	}

	public String[] getTypes() {
		return type == null ? new String[] {} : type.split("");
	}

}
