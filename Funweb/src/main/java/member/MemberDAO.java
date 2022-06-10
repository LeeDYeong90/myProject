package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	// 데이터베이스 작업에 사용되는 객체 타입 변수 미리 선언
	// 참조형 변수는 null로 자동 초기화
	// (기본형 변수는 0으로 자동 초기화)
	public Connection getConnection() {
		// db연동 작업 수행하는 별도의 메서드를 정의 (파라미터:없음/리턴값:Connection객체)
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/funweb";
		String user = "root";
		String password = "1234";

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) { // 각 exception 케이스마다 콘솔창에 해당 예외 경고창 띄움
			System.out.println("드라이버 클래스 로드 실패!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패!");
			e.printStackTrace();
		}
		return con;
	}

	// Connection객체, PreparedStatement객체, ResultSet객체를 자원반환할 메서드를 별도로 정의, 오버로딩
	public void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void close(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void close(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String idCheck(String id) {
		String dupicate_id = null;
		con=getConnection();
		
		String sql = "SELECT * FROM member WHERE id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dupicate_id = "duplicate";
			} else {
				dupicate_id = id;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {// finally 를 이용해 자원반환 메서드 호출
			close(rs);
			close(pstmt);
			close(con);
		}
		return dupicate_id;
	}
	
	
	
	public int insertMember(MemberDTO dto) {
		int insertCount = 0; // 리턴해줄 insertCount을 0으로 초기화
		con = getConnection();// db연동을 위해 getConnection메서드를 호출

		try { // 파라미터로 받은 dto에서 각 데이터값을 꺼내와서 db에 INSERT 작업 수행
			String sql = "INSERT INTO member VALUES (?,?,?,now(),?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getMobile());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getPhone());

			// SQL구문 실행한 적용값을 insertCount로 받기
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {// finally 를 이용해 자원반환 메서드 호출
			close(pstmt);
			close(con);
		}

		return insertCount;
	}

	public boolean checkUser(String id, String pass) {
		//리턴값인 isLoginSuccess를 false값으로 초기화
		boolean isLoginSuccess = false;
		//// db연동을 위해 getConnection메서드를 호출
		con = getConnection();
		//파라미터로 받은 id, pass값과 일치하는 레코드 조회
		try {
			String sql = "SELECT pass FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			//결과값이 있을 경우(id, pass 모두 일치하는 레코드 존재)
			if (rs.next()) {
				isLoginSuccess = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {// finally 를 이용해 자원반환 메서드 호출
			close(rs);
			close(pstmt);
			close(con);
		}
		return isLoginSuccess;
	}

}
