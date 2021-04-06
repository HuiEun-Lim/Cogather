package com.project.cogather.chat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.cogather.chat.model.ChatMessage;

import lombok.RequiredArgsConstructor;


@Service
public class RedisSubscriber implements MessageListener{
	@Autowired
	ObjectMapper objectMapper; // 직력화된 메시지를 DTO로 매핑
	@Autowired
	RedisTemplate<String, Object> redisTemplate; // 데이터 직렬화 역직렬화
	@Autowired
	SimpMessageSendingOperations messagingTemplate; // 특정 url에 메시지 
	
	
	@Override
	public void onMessage(Message message, byte[] pattern) { 
		// 구현체인데 반환 값이 없어서 어떻게 메세지를 전달해야하나 했는데, SimpMessageSendingOperations라고 원하는 곳에 메시지를 전달하는 객체를 쓰면 됬음
		// 이거 말고도 다른 방법이 더 있는 듯 하지만 해야할게 많기에 넘어가겠음... 
		
		// publisher 에서 받은 데이터를 config에서 설정한 jackson으로 deserialize로 얻은 object 객체를 문자열로 직렬화
		String publishMessage = (String) redisTemplate.getStringSerializer().deserialize(message.getBody());
		// ChatMessage 객체로 매핑
		ChatMessage chatMessage;
		
		try {
			chatMessage = objectMapper.readValue(publishMessage, ChatMessage.class); // 문자열을 원하는 형태(ChatMessage)로 바꿈
			messagingTemplate.convertAndSend("/sub/message/"+chatMessage.getRoomId(), chatMessage); // 원하는 방번호를 뽑아 만든 특정 url로 구독된 곳에 전달 
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
