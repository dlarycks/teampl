package com.kh.teampl.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderVo {
	private int order_no;
	private int member_no;
	private String order_content;
	private int order_price;
	private Timestamp order_orderdate;
}