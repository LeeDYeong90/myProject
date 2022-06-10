package archive;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import board.BoardDTO;

public class ArchiveDAO {

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

//	문제입력 메서드. 리턴값 int / 파라미터값 : ArchiveDTO
	public int insertArchive(ArchiveDTO dto	) {
		int insertArchive = 0;
		con = getConnection();
		
		try {
			String sql = "insert into archive values (?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getYear());
			pstmt.setInt(2, dto.getCnt());
			pstmt.setInt(3, dto.getSubject_cd());
			pstmt.setInt(4, dto.getQ_num());
			pstmt.setString(5, dto.getQ_subject());
			pstmt.setString(6, dto.getQ_content());
			pstmt.setString(7, dto.getA_1());
			pstmt.setString(8, dto.getA_2());
			pstmt.setString(9, dto.getA_3());
			pstmt.setString(10, dto.getA_4());
			pstmt.setInt(11, dto.getAnswer());
			
			insertArchive = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return insertArchive;
	}
//	기출문제 검색 메서드. 리턴값 : ArrayList / 파라미터값 : archive_content.jsp에서 받은 기출 회차 정보
	public ArrayList<ArchiveDTO> selectArchiveList(int year, int cnt, int subject_cd) {
		ArrayList<ArchiveDTO> archiveList = null;
		con = getConnection();
//		서브쿼리문을 이용하여 sub_table에 있는 과목명도 함께 검색
//		ArrayList에 같이 담아가기 위해 ArchiveDTO에도 과목명 name 멤버변수를 추가로 선언해줌
		try {
			String sql = "SELECT  q_num, q_subject, q_content, a_1, a_2, a_3, a_4, answer, (SELECT name FROM sub_table WHERE cd=subject_cd) as name "
					+ "FROM archive  WHERE year=? AND cnt=? AND subject_cd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, year);
			pstmt.setInt(2, cnt);
			pstmt.setInt(3, subject_cd);
			rs = pstmt.executeQuery();
			archiveList = new ArrayList<ArchiveDTO>();
			while(rs.next()) {
				ArchiveDTO dto = new ArchiveDTO();
				dto.setQ_num(rs.getInt("q_num"));
				dto.setQ_subject(rs.getString("q_subject"));
				dto.setQ_content(rs.getString("q_content"));
				dto.setA_1(rs.getString("a_1"));
				dto.setA_2(rs.getString("a_2"));
				dto.setA_3(rs.getString("a_3"));
				dto.setA_4(rs.getString("a_4"));
				dto.setAnswer(rs.getInt("answer"));
				dto.setName(rs.getString("name"));
				archiveList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return archiveList;
		
	}
}
