package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberSendEmailSevlet
 */
@WebServlet("/member/send")
public class MemberSendEmailSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final String username = "meetpeople.kh";
	final String password = "meetpeople.kh";

	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 사용자 이메일아이디 받아오기.
		String memberEamilId = request.getParameter("memberEamilId");
		System.out.println("memberEamilId@servlet.doPost = " + memberEamilId);

		
		
		
		// 2. 업무로직 이메일 보내기(랜덤값 만들기)
		
		//5자리 랜덤번호 생성
		int randomNumber = (int)(Math.random() * (99999 - 10000 + 1)) + 10000;
		
		
		
		
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
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(memberEamilId));//받는사람이메일 입력받는곳
			message.setSubject("[미플] 이메일 인증번호입니다.");//제목
			message.setText("인증번호는 ["+randomNumber + "] 입니다.");// 내용
			System.out.println("send!!!");
			Transport.send(message);
			System.out.println("SEND");

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		//3. 응답처리
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		//이메일보낸 random data 전달하기
		out.print(randomNumber);
	}

}
