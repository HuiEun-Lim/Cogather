package com.project.cogather.controller;



import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.cogather.domain.ChatMessage;



@Controller
public class ChatController {
	
	@MessageMapping("/chat/{roomId}")
	@SendTo("/sub/message/{roomId}")
	public ChatMessage chat(
			@Payload ChatMessage message
			) {
		
		System.out.println("hi");

		
		return message;
	}

	
}
