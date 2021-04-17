package common;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.service.MemberService;
import member.model.vo.Member;

public class SendFindEmail {

	final String username = "meetpeople.kh";
	final String password = "meetpeople.kh";
	MemberService memberService = new MemberService();
	int result = 0;

	public Member sendEmailPassword(Member member) {
		String id = member.getMemberId();
		String email = member.getEmail();
		
		//랜덤값 부여
		String randomString = MvcUtils.randomAlphaWord(30);
		
		//db에 저장
		Map<String, String> map = new HashMap<>();
		map.put("id",id);
		map.put("randomString",randomString);
		int result = 0;
		result = memberService.insertCertification(map);
		if(result>0) {
			System.out.println("인증코드 테이블 저장 성공");
		}else {
			System.out.println("인증코드 테이블 저장 실패");
		}
		
		
		String mail = "http://localhost:9090/semi/member/newpassword?id="+id+"&randomString="+randomString+"&email="+email;

		
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
			message.setSubject("[미플] 비밀번호 변경 링크 메일입니다.");// 제목
			message.setText(mail+"  해당링크를 클릭해서 비밀번호를 변경하세요.");// 내용
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