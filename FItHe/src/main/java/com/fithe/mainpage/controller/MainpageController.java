package com.fithe.mainpage.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainpageController {

	private Logger logger = Logger.getLogger(MainpageController.class);
	
	@RequestMapping(value="mainpageForm", method=RequestMethod.GET)
	public String mainpageForm() {
		logger.info("(MainpageController) mainpageForm() 진입");
		
		return "mainpage/mainpage";
	}
}
