package com.kh.teampl.socket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.teampl.dto.LoginDto;
 
 
 
 
public class EchoHandler extends TextWebSocketHandler {
    
    private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	Map<String, Object> map =  session.getAttributes();
    	LoginDto loginDto = (LoginDto)map.get("loginInfo");
    	String member_id = loginDto.getMember_id();
    	
    	// 처음에는 admin만 세션에 입장 가능
    	if (sessionList.size() == 0) {
	    	if (member_id.equals("admin")) {
	    		sessionList.add(session);
	    	} else {
	    		session.sendMessage(new TextMessage("상담원이 현재 부재 중입니다. 나중에 다시 시도해 주세요."));
	    		return;
	    	}
	    // 두 번째는 아무나 입장 가능
    	} else if (sessionList.size() == 1) {
    		if (!member_id.equals("admin")) {
    			sessionList.add(session);
    		}
    		for(WebSocketSession sess : sessionList) {
    			sess.sendMessage(new TextMessage(member_id + "님이 접속했습니다."));
    		}
    	// 세 번째는 아무도 입장 불가능
    	} else {
    		System.out.println("방이 가득 찼습니다.");
    		return;
    	}
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

    	if(sessionList.size() != 2) {
    		session.sendMessage(new TextMessage("상담대상이 없습니다."));
    		return;
    	}
    	// 접속자의 ID 추출
    	Map<String, Object> map = session.getAttributes();
    	LoginDto loginDto = (LoginDto)map.get("loginInfo");
    	String member_id = loginDto.getMember_id();
    	
    	// 2번째 세션의 ID 추출 ( 1번째 ID는 admin고정임 )
    	LoginDto participant = (LoginDto)sessionList.get(1).getAttributes().get("loginInfo");
    	String participant_id = participant.getMember_id();
    	
    	if(!member_id.equals(participant_id) && !member_id.equals("admin")) {
    		session.sendMessage(new TextMessage("상담원이 현재 상담 중입니다."));
    		return;
    	}
    	// 메세지 전송
    	for(WebSocketSession sess: sessionList) {
            sess.sendMessage(new TextMessage(member_id + ": " + message.getPayload()));
        }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	Map<String, Object> map = session.getAttributes();
    	LoginDto loginDto = (LoginDto)map.get("loginInfo");
    	String member_id = loginDto.getMember_id();        
        sessionList.remove(session);
        
        for(WebSocketSession sess : sessionList) {
            sess.sendMessage(new TextMessage(member_id + "님의 연결이 끊어졌습니다."));
        }
    }
    
}
