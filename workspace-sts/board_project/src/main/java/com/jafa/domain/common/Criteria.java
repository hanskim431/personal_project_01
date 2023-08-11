package com.jafa.domain.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class Criteria {

	private int pageNum;
	private int amount;
	
	public Criteria() {
		this(1, 10);
	}
	
	public int getMaxRow() {
		return pageNum*amount;
	}
	
	public int getMinRow() {
		return (pageNum-1)*amount;
	}
}
