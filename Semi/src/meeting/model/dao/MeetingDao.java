package meeting.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import common.SemiException;
import meeting.model.vo.Attachment;
import meeting.model.vo.Meeting;

public class MeetingDao {
	private Properties prop = new Properties();

	public MeetingDao() {
		
		String fileName = MeetingDao.class.getResource("/sql/meeting/meeting-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Meeting> selectIndexRecentlist(Connection conn) {
		List<Meeting> list = new ArrayList<Meeting>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectIndexRecentlist");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Meeting m = new Meeting();
				//인덱스페이지 에서는 이거 두개만 필요함
				m.setMeetingNo(rset.getInt("meeting_no"));
				m.setTitle(rset.getString("title"));
				list.add(m);
			}
			
		} catch (Exception e) {
			throw new SemiException("미팅 리스트 불러오기 실패", e);
		} finally {
			close(rset);
			close(pstmt);
		} 
		
		return list;
	}

	public Attachment selectAttachOne(Connection conn, int meetingNo) {
		Attachment attach = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		//select * from attachment where meeting_no = ? and status = 'Y'
		String sql = prop.getProperty("selectAttachOne");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, meetingNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attach = new Attachment();
				attach.setAttachNo(rset.getInt("attach_no"));
				attach.setMeetingNo(meetingNo);
				attach.setOriginalFilename(rset.getString("original_filename"));
				attach.setRenamedFilename(rset.getString("renamed_filename"));
				attach.setStatus(rset.getString("status"));
			}
			
		} catch (Exception e) {
			throw new SemiException("미팅 리스트 불러오기 실패", e);
		} finally {
			close(rset);
			close(pstmt);
		} 
		
		return attach;
	}

	public List<Meeting> selectMeetingList(Connection conn, int start, int end, String location, String category, String search) {
		List<Meeting> list = new ArrayList<Meeting>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMeetingList");
		sql=sql.replace("@", category);
		sql=sql.replace("#", location);
		sql=sql.replace("$", search);
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rset = pstmt.executeQuery();
			
			
			while(rset.next()) {
				Meeting m = new Meeting();
				//인덱스페이지 에서는 이거 두개만 필요함
				m.setMeetingNo(rset.getInt("meeting_no"));
				m.setTitle(rset.getString("title"));
				m.setTime(rset.getDate("time"));
				list.add(m);
			}
			
		} catch (Exception e) {
			throw new SemiException("미팅 리스트 불러오기 실패", e);
		} finally {
			close(rset);
			close(pstmt);
		} 
		
		return list;
	}

	public int selectMeetingTotalContent(Connection conn, String location, String category, String search) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMeetingTotalContent").replace("@", location).replace("#", category).replace("$", search);
		System.out.println(sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				result = rset.getInt("count(*)");
			}
		} catch (SQLException e) {
			throw new SemiException("미팅리스트 totalContent 불러오기 실패", e);
		}
		
		return result;
	}
}
