package com.fithe.common.commons.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import com.fithe.common.CommonUtils;

public class MailAuth extends Authenticator {

	/*
	 * 메일을 보내기 위해 pom.xml에 javax.mail을 추가해주었다.
	 * javax.mail 패키지의 주요 클래스는
	 * Session, Message, Address, Authenticator, Transport 등이 있다.
	 * SMTP 서버에 연결해 사용자 인증을 하기 위해 Authenticator 클래스 사용
	 * */
	PasswordAuthentication pa;
	
	public MailAuth() {
		// 보내는 메일
		String mail_id = CommonUtils.EMAIL_ID;
		String mail_pw = CommonUtils.EMAIL_PW;
		pa = new PasswordAuthentication(mail_id, mail_pw);
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		
		return pa;
		/* 
		 * Authenticator를 사용하기 위해서는 PasswordAuthenticator 클래스로부터 
		 * 인스턴스를 생성하고 getPasswordAuthentication 메소드로 리턴받아야 한다.
		 * PasswordAuthentication 클래스는 사용자의 
		 * 아이디와 패스워드를 입력받아 반환하도록 재정의한다.
		 */
	}
}
