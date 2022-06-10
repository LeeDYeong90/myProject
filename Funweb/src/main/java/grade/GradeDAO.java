package grade;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GradeDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public Connection getConnection() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/funweb";
		String user = "root";
		String password = "1234";

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 클래스 로드 실패!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패!");
			e.printStackTrace();
		}
		return con;

	}

	public void close(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void close(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
//	회원 점수 저장 메서드
	public void insertGrade(GradeDTO gradeDto) {
		
		con = getConnection();
//		해당 회차에 저장된 점수가 있는지 조회
		try {
			String sql = "SELECT score FROM grade WHERE id=? AND year=? AND cnt=? AND subject_cd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gradeDto.getId());
			pstmt.setInt(2, gradeDto.getYear());
			pstmt.setInt(3, gradeDto.getCnt());
			pstmt.setInt(4, gradeDto.getSubject_cd());
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				//기존 점수가 있는 경우 update실행
				sql = "UPDATE grade SET score = ? WHERE id=? AND year=? AND cnt=? AND subject_cd=?";
				pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, gradeDto.getScore());
						pstmt.setString(2, gradeDto.getId());
						pstmt.setInt(3, gradeDto.getYear());
						pstmt.setInt(4, gradeDto.getCnt());
						pstmt.setInt(5, gradeDto.getSubject_cd());
				pstmt.executeUpdate();
				
			} else {
				//기존 점수가 없는 경우 insert실행
				sql = "INSERT INTO grade VALUES (?, ?, ?, ?, ?) ";
				pstmt = con.prepareStatement(sql);
					pstmt.setString(1, gradeDto.getId());
					pstmt.setInt(2, gradeDto.getYear());
					pstmt.setInt(3, gradeDto.getCnt());
					pstmt.setInt(4, gradeDto.getSubject_cd());
					pstmt.setInt(5, gradeDto.getScore());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
	}
	
//	기출문제의 점수 조회하는 메서드. 리턴값 : 점수 / 파라미터값 : 회원아이디, 기출년도, 기출회차, 과목코드
	public int selectScore(String id, int year, int cnt, int subject_cd) {
		con = getConnection();
		int score = 0;
		try {
			String sql = "SELECT score FROM grade WHERE id=? AND year=? AND cnt=? AND subject_cd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, year);
			pstmt.setInt(3, cnt);
			pstmt.setInt(4, subject_cd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				score = rs.getInt("score");
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return score;
	}
	
//	관리자가 회원 모두의 점수를 조회하는 메서드. 리턴값 : ArrayList 
	public ArrayList<GradeDTO> selectMember() {
		ArrayList<GradeDTO> memberScoreList = null;
		con = getConnection();
		try {
//			서브쿼리를 이용하여 sub_table의 과목명도 함께 조회
			String sql = "SELECT id, year, cnt, score, (SELECT name FROM sub_table WHERE cd=subject_cd) as subject_name FROM grade";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			memberScoreList = new ArrayList<GradeDTO>();
			while(rs.next()) {
				GradeDTO dto = new GradeDTO();
				dto.setId(rs.getString("id"));
				dto.setYear(rs.getInt("year"));
				dto.setCnt(rs.getInt("cnt"));
				dto.setSubject_name(rs.getString("subject_name"));
				dto.setScore(rs.getInt("score"));
				memberScoreList.add(dto);
			}
		}  catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return memberScoreList;
	}
}
