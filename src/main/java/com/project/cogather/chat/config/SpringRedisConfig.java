package com.project.cogather.chat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;


@Configuration
public class SpringRedisConfig {
	// redis pub/sub 메시지 처리하는 listener 설정
	@Bean // Redis server 연결을 위한 Redis Client Factory bean 생성
	public JedisConnectionFactory connectionFactory() {
		// 기존 JedisConnectionFactory로 생으로 만들어서 host, port 설정하는 함수가 deprecated 됨
		RedisStandaloneConfiguration connection = new RedisStandaloneConfiguration();
		connection.setHostName("localhost");
		// redis 기본 포트 6379
		connection.setPort(6379); // docker redis server 외부 포트를 20000으로 설정했음
		
		return new JedisConnectionFactory(connection); 
	}
	// Subscriber 들을 담아둠 -> 구독들이 이 리스너에 등록됨  
	@Bean
	public RedisMessageListenerContainer redisContainer() {
		RedisMessageListenerContainer container = new RedisMessageListenerContainer();
		container.setConnectionFactory(connectionFactory());
		return container;
	}
	
	// Spring ~ Redis 간 데이터의 serialize, deserialize 해주는 역할이며, JDK serialize하는 방식이 기본이라 jackson으로 json 데이터를 변환해야 하므로 serializer를 변경한다.
	@Bean
	public RedisTemplate<String, Object> redisTemplate(){
		RedisTemplate<String, Object> redisTemplate = new RedisTemplate<String, Object>();
		redisTemplate.setConnectionFactory(connectionFactory());
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<>(String.class));// 바꾸려는것은 키가 아닌 json 데이터 이므로 value에 대한 serializer를 바꿈
		return redisTemplate;
		
	}
}
