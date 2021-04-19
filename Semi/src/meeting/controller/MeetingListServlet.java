package meeting.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/meeting/meetingList")
public class MeetingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String location = request.getParameter("location");
		String category = request.getParameter("category");
		String search = request.getParameter("search");
		
		if(location==null){
			location="";
		}
		if(category==null) {
			category="";
		}
		if(search==null) {
			search="";
		}
		
		System.out.println("location@servlet = "+location);
		System.out.println("category@servlet = "+category);
		System.out.println("search@servlet = "+search);
	}

}
