package common;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.vo.Member;

public class SendFindEmail {

	final String username = "lila230011";
	final String password = "alvmf1234";
	int result = 0;

	public Member sendEmailPassword(Member member) {
		String email = member.getEmail();
		String userpassword = member.getPassword();
		System.out.println(userpassword + "이게 보내줄 비밀번호다");

		// 메일용 api
		Properties props = new Properties();

		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "25");
		props.put("mail.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("MEPLE"));//
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));// 받는사람이메일 입력받는곳
			message.setSubject("[미플] 비밀번호 찾기 메일입니다.");// 제목
			message.setText("찾고자 하는 비밀번호는 [" + userpassword + "] 입니다.");// 내용
			System.out.println("send!!!");
			Transport.send(message);
			System.out.println("SEND");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return member;
	}
	
	
	

	public Member sendEmailId(Member member) {
		String id = member.getMemberId();
		String email = member.getEmail();
		System.out.println(id + "이게 보내줄 아이디다");

		// 메일용 api
		Properties props = new Properties();

		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "25");
		props.put("mail.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("MEPLE"));//
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));// 받는사람이메일 입력받는곳
			message.setSubject("[미플] 아이디 찾기 메일입니다.");// 제목
			message.setText("찾고자 하는 아이디는 [" + id + "] 입니다.");// 내용
			System.out.println("send!!!");
			Transport.send(message);
			System.out.println("SEND");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return member;
	}

}