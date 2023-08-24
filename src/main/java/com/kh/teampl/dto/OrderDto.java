package com.kh.teampl.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDto {
	private String order_cpu_name;
	private String order_mb_name;
	private String order_ram_name;
	private String order_vga_name;
	private String order_power_name;
	private String order_case_name;
	private String order_ssd_name;
	
	private int order_cpu_price;
	private int order_mb_price;
	private int order_ram_price;
	private int order_vga_price;
	private int order_power_price;
	private int order_case_price;
	private int order_ssd_price;
	private int total_price;
}
