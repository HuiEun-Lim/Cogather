package com.project.cogather.controller;

import java.util.List;

import com.project.cogather.domain.AjaxResult;
import com.project.cogather.domain.CafeDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestReservationResult extends AjaxResult{
	List<CafeDTO> chkdates; 
}
