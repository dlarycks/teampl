package com.kh.teampl.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductVo {
	private int product_no;
	private String product_name;
	private String product_category;
	private int product_price;
	private String product_manufacturer;
	private Timestamp product_releasedate;
}
