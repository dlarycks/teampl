package com.kh.teampl.controller;

import java.io.IOException;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/verifyIamport")
public class VerifyController {

    // Iamport 결제 검증 컨트롤러
    private final IamportClient iamportClient;
    private final String REST_API_KEY = "/* !! REST_API_KEY !! */";
    private final String REST_API_SECRET = "/* !! REST_API_SECRET !! */";

    // 생성자를 통해 REST API 와 REST API secret 입력
    public VerifyController(){
        this.iamportClient = new IamportClient(REST_API_KEY, REST_API_SECRET);
    }
    
    // 프론트에서 받은 PG사 결괏값을 통해 아임포트 토큰 발행
    @RequestMapping(value = "/{imp_uid}", method = RequestMethod.POST)
    public IamportResponse<Payment> paymentByImpUid(@PathVariable String imp_uid) throws IamportResponseException, IOException{
    	log.info("paymentByImpUid 진입");
//    	System.out.println("imp_uid: " + imp_uid);
    	return iamportClient.paymentByImpUid(imp_uid);
    }
    
}