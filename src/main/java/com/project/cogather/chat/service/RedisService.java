package com.project.cogather.chat.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Service;

import com.project.cogather.studygroup.model.StudyGroupDAO;
import com.project.cogather.studygroup.model.StudyGroupDTO;

@Service
public class RedisService implements InitializingBean{
	@Autowired
	RedisTemplate<String, Object> redisTemplate; // redis ~ 스프링 간의 데이터 serialize, deserialize
	@Autowired
	RedisMessageListenerContainer redisMessageListener; // 구독 시키기 
	@Autowired
	RedisSubscriber subscriber;
//	HashOperations<String, String, StudyGroupDTO> opsHashStudyGroup; // 오라클에 저장하고 있으니 굳이 하지 않겠음
	
	private Map<String, ChannelTopic> topics; // 구독시 만들어지는 채널들을 보관 
	
	private static final String KEY = "CHAT_ROOM";
	
	// 참고했던 블로그는 chatroom을 db에 저장안하고 redis에 저장해서 모든 서버에서 공유되도록했지만, 여기서는 오라클 서버에 저장했으므로 
	// 굳이 방을 redis에 넣어서 공유하진 않겠음.. 
	
	public void enterChatRoom(int sg_id) {
		ChannelTopic topic = topics.get(String.valueOf(sg_id)); // 구독이 이미 있으면 해당 구독 채널 사용
		if (topic == null) {// 없다면 새로 만들어서 채널 등록하고 구독 저장
			topic = new ChannelTopic(String.valueOf(sg_id)); 
			redisMessageListener.addMessageListener(subscriber,topic); //구독채널을 리스너에 등록
			topics.put(String.valueOf(sg_id), topic);
		}
	}
	
	public ChannelTopic getTopic(int sg_id) { // 구독 채널을 하나 반환
		return topics.get(String.valueOf(sg_id));
	}
	
	@Override
	public void afterPropertiesSet() throws Exception { // @POSTConstructor 어노테이션이 deprecated되고 나서 사용하게 됨-> 빈생성시 초기화 설정하는 역할? 
//		opsHashStudyGroup = redisTemplate.opsForHash();
		topics = new HashMap<String, ChannelTopic>(); 
	}
	
	
}
