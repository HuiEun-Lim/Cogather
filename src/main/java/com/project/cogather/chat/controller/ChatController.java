package com.project.cogather.chat.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.cogather.chat.model.ChatMessage;
import com.project.cogather.chat.service.RedisPublisher;
import com.project.cogather.chat.service.RedisService;



@Controller
public class ChatController {
	@Autowired
	RedisPublisher redispublisher;
	@Autowired
	RedisService redisService;
	
	@MessageMapping("/chat/{roomId}")
	public void chat(ChatMessage message) {
		// Websocket에서 발행된 메시지를 redis Publisher로 발행함
		redispublisher.publish(redisService.getTopic(message.getRoomId()), message);
	}
	
	
	
	// stomp 방식
//	@MessageMapping("/chat/{roomId}") // /pub/chat/방번호 로 클라이언트가 메시지를 전달하면 브로커로 메시지를 전달
//	@SendTo("/sub/message/{roomId}") // 클라이언트가 해당 url를 구독(subscribe)하면 브로커가 활성화되며 브로커로 전달된 메시지를 전달한다.
//	public ChatMessage chat( // 메시지 핸들러 : 메시지를 처리하여 브로커로 전달한다. 
//			@Payload ChatMessage message // roomId와 같은 전달되는 파라미터들을 넣으면 안된다. 넣게되면 json 데이터를 roomId로 변환하려 함. 
//			) {
//		
//		System.out.println("hi");
//
//		
//		return message;
//	}

	
}
