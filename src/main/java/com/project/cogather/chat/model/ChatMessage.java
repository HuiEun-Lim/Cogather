package com.project.cogather.chat.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
public class ChatMessage {
    // 메시지 타입 : 입장, 채팅
    public enum MessageType {
        JOIN, LEAVE, TALK
    }
    private MessageType type; // 메시지 타입
    private Integer roomId; // 방번호
    private String sender; // 메시지 보낸사람
    private String content; // 메시지
    
    
}