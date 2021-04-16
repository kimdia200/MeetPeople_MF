package member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import board.model.dao.BoardDao;
import member.model.vo.Member;

public class MemberDao {
	private Properties prop = new Properties();

	public MemberDao() {
		
		String fileName = BoardDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//맴버 조회 = 로그인
	public Member selectOne(Connection conn, String memberId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectOne");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				member = new Member();
				member.setMemberId(rset.getString("MEMBER_ID"));
				member.setPassword(rset.getString("PASSWORD"));
				member.setName(rset.getString("NAME"));
				member.setEmail(rset.getString("EMAIL"));
				member.setPhone(rset.getString("PHONE"));
				member.setEvent1(rset.getString("EVENT1"));
				member.setEvent2(rset.getString("EVENT2"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				member.setMemberRole(rset.getString("MEMBER_ROLE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return member;

	}

	//회원가입
	public int insertMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertMember");

		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			// 쿼리문미완성
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getEvent1());
			pstmt.setString(7, member.getEvent2());
			pstmt.setString(8, member.getMemberRole());
			
			// 쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			// DML은 executeUpdate()
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	//아이디 찾기
	public Member findId(Connection conn, String memberName, String memberEmail) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("findId");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberEmail);
			
			rset = pstmt.executeQuery();

			if (rset.next()) {
				member = new Member();
				member.setMemberId(rset.getString("MEMBER_ID"));
				member.setPassword(rset.getString("PASSWORD"));
				member.setName(rset.getString("NAME"));
				member.setEmail(rset.getString("EMAIL"));
				member.setPhone(rset.getString("PHONE"));
				member.setEvent1(rset.getString("EVENT1"));
				member.setEvent2(rset.getString("EVENT2"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				member.setMemberRole(rset.getString("MEMBER_ROLE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return member;
	}

	
	public Member findPassword(Connection conn, String memberId, String memberEmail) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("findPassword");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberEmail);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				member = new Member();
				member.setMemberId(rset.getString("MEMBER_ID"));
				member.setPassword(rset.getString("PASSWORD"));
				member.setName(rset.getString("NAME"));
				member.setEmail(rset.getString("EMAIL"));
				member.setPhone(rset.getString("PHONE"));
				member.setEvent1(rset.getString("EVENT1"));
				member.setEvent2(rset.getString("EVENT2"));
				member.setEnrollDate(rset.getDate("ENROLL_DATE"));
				member.setMemberRole(rset.getString("MEMBER_ROLE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return member;
	}
}