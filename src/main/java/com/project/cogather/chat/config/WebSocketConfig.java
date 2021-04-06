package com.project.cogather.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// 소켓 통신을 위한 엔드 포인트 지정 소켓 생성시 해당 url을 사용, 모든 오리진에게 허용, 
		// SockJs는 webSocket을 미지원하는 브라우저에서도 동작할 수 있도록 함
		registry.addEndpoint("/endpoint").setAllowedOrigins("*").withSockJS();
		
		/*
		 * withSockJS ()

  SockJS는 웹 소켓을 지원하지 않는 브라우저에 폴백 옵션을 활성화하는 데 사용됩니다.

  Fallback 이란?  어떤 기능이 약해지거나 제대로 동작하지 않을 때, 이에 대처하는 기능 또는 동작
		 * */
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// 해당 문자열로 시작하는 주소값을 받아서 받은 메시지를 처리하는 Broker를 활성화하게 된다.
		// Broker가 활성화되면 클라이언트는 해당 Broker로 부터 메시지를 받을 수 있다.
		registry.enableSimpleBroker("/sub");
		// 클라이언트가 서버로 메시지를 전송할 때 prefix로 붙여야하는 url 앞부분
		registry.setApplicationDestinationPrefixes("/pub");
	}

	// Subscriber(receive socket) : 채팅방에 입장하여 채팅창을 구독, 구독이 되어 있다면 메시지를 받을 수 있음
	// sender(send socket) : 구독하고 있는 채널의 채팅 창에 메시지를 쓰면 모든 구독된 subscriber에게 전달됨
	
	// broker 란? 연결된 socket들의 세션을 관리해준다. subscriber를 구독한 채널에 연결해주고, sender가 해당 채널에 메시지를 보내면 subscriber에게 전달해주는 중간 다리
	
}
