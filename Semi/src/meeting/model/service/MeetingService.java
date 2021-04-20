package meeting.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import meeting.model.dao.MeetingDao;
import meeting.model.vo.Attachment;
import meeting.model.vo.Meeting;

public class MeetingService {
	private MeetingDao meetingDao = new MeetingDao();

	public List<Meeting> selectIndexRecentlist() {
		List<Meeting> list = null;
		Connection conn = getConnection();
		try {
			list=meetingDao.selectIndexRecentlist(conn);
			if(list!=null && list.size()!=0) {
				System.out.println("모임리스트 불러오기 성공");
			}else {
				System.out.println("리스트 불러오기 실패 혹은 리스트 사이즈0");
			}
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return list;
	}

	public Attachment selectAttachOne(int meetingNo) {
		Attachment attach = null;
		Connection conn = getConnection();
		try {
			attach = meetingDao.selectAttachOne(conn, meetingNo);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return attach;
	}

	public List<Meeting> selectMeetingList(int start, int end, String location, String category, String search) {
		List<Meeting> list = null;
		Connection conn = getConnection();
		try {
			list=meetingDao.selectMeetingList(conn, start, end, location, category, search);
			if(list!=null && list.size()!=0) {
				System.out.println("모임리스트 불러오기 성공");
			}else {
				System.out.println("리스트 불러오기 실패 혹은 리스트 사이즈0");
			}
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return list;
	}

	public int selectMeetingTotalContent(String location, String category, String search) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = meetingDao.selectMeetingTotalContent(conn,location, category, search);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
