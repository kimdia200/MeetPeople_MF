package meeting.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import meeting.model.service.MeetingService;
import meeting.model.vo.Attachment;
import meeting.model.vo.Meeting;

@WebServlet("/meeting/meetingUpdate")
public class MeetingUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MeetingService meetingService = new MeetingService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));
		Meeting meeting = meetingService.selectOne(meetingNo);
		Attachment attach = meetingService.selectAttachOne(meetingNo);
		if(attach ==null) {
			attach = new Attachment();
			attach.setRenamedFilename("no_img.png");
		}
		meeting.setAttach(attach);
		
		int particiCnt = meetingService.selectParticiCnt(meetingNo);
		meeting.setCountParticipation(particiCnt);
		System.out.println(meeting);
		request.setAttribute("meeting", meeting);
		request.getRequestDispatcher("/WEB-INF/views/meeting/meetingUpdate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		String location = request.getParameter("location");
		String place = request.getParameter("place");
		String t = request.getParameter("time");
		int cost = Integer.parseInt(request.getParameter("cost"));
		int max = Integer.parseInt(request.getParameter("max"));
		String writer = request.getParameter("writer");
		
		System.out.println("t="+t);
		
		int year = Integer.parseInt(t.substring(0, 4));
		int month = Integer.parseInt(t.substring(5,7));
		int dayOfMonth = Integer.parseInt(t.substring(8,10));
		int hourOfDay = Integer.parseInt(t.substring(11,13));
		int minute = Integer.parseInt(t.substring(14));
		
		Calendar cal = new GregorianCalendar(year, month, dayOfMonth, hourOfDay, minute);
		Date time = new Date(cal.getTimeInMillis());

		Meeting m =new Meeting(no, title, writer, content, null, place, time, max, cost, category, null, location, null, 0, null);
		System.out.println(m);
//		int result = meetingService.updateMeeting(m);
//		
//		HttpSession session = request.getSession();
//		if(result>0) {
//			session.setAttribute("msg", "모임 내용 수정이 완료되었습니다.");
//		}else {
//			session.setAttribute("msg", "모임 내용 수정을 실패했습니다.");
//		}
		
		String referer = request.getHeader("Referer");
		response.sendRedirect(referer);
	}

}
