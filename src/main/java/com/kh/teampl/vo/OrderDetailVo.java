package com.kh.teampl.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailVo {
	private int order_no;
	private int order_cpu;
	private int order_mb;
	private int order_ram;
	private int order_vga;
	private int order_power;
	private int order_case;
	private int order_ssd;
}