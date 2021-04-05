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
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// 해당 문자열로 시작하는 주소값을 받아서 받은 메시지를 처리하는 Broker를 활성화하게 된다.
		// Broker가 활성화되면 클라이언트는 해당 Broker로 부터 메시지를 받을 수 있다.
		registry.enableSimpleBroker("/sub");
		// 클라이언트가 서버로 메시지를 전송할 때 prefix로 붙여야하는 url 앞부분
		registry.setApplicationDestinationPrefixes("/pub");
	}

}
