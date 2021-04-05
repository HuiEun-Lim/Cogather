package com.project.cogather.common;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AjaxResult {
	private int cnt; // 결과 개수
	private String status; // 성공 유무
	private String message; // 결과 메시지
}
