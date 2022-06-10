package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class content_replyDAO {
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
	
//	댓글입력 메서드. 리턴값 : int / 파라미터값 : content_replyDTO
	public int insertComment(content_replyDTO dto) {
		int insertCount =0;
		con = getConnection();
		try {
			String sql = "SELECT MAX(index_comment) FROM content_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int num = 1; // 레코드가 0일 경우 첫 글의 번호는 1로 기본값 저장
			if (rs.next()) {
				num = rs.getInt("Max(index_comment)") + 1; // 조회할때 그냥 num을 쓰면 'Column 'num' not found' 오류 발생

			}
			
			sql = "INSERT INTO content_reply VALUES (?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, dto.getPost_num());
			pstmt.setString(3, dto.getComment_id());
			pstmt.setString(4, dto.getComment());
			pstmt.setInt(5, dto.getComment_class());
//			comment_class가 0일 경우(댓글) -> group_num에 index번호 저장
			if(dto.getComment_class()==0) {
				pstmt.setInt(6, num);
			} else {
//				comment_class가 1일 경우(대댓글) -> group_num에 부모댓글의 index번호 저장
//				이를 위해서 notice_content.jsp에서 링크 파라미터로 group_num으로 값을 보냄
				pstmt.setInt(6, dto.getGroup_num());
			}
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return insertCount;
	}
	
//	게시물의 댓글을 조회하는 메서드. 리턴값 : ArrayList / 파라미터값 : 글번호
	public ArrayList<content_replyDTO> select_content_reply(int num) {
		ArrayList<content_replyDTO> replyList = null;
		con = getConnection();
		try {
//			부모댓글의 최신순에 따라 댓글 정렬
			String sql = "SELECT * FROM content_reply WHERE post_num=? ORDER BY group_num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			replyList = new ArrayList<content_replyDTO>();
			while(rs.next()) {
				content_replyDTO dto = new content_replyDTO();
				dto.setIndex_comment(rs.getInt("index_comment"));
				dto.setComment_id(rs.getString("comment_id"));
				dto.setComment(rs.getString("comment"));
				dto.setDate(rs.getDate("date"));
				dto.setComment_class(rs.getInt("comment_class"));
				replyList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return replyList;
	}
	
//	댓글 삭제 메서드. 리턴값 : int / 파라미터값 : 댓글 index번호, 댓글-대댓글 구분 번호(댓글은 0/ 대댓글은 1)
	public int delete_content_reply(int index_comment, int comment_class) {
		int deleteCount = 0;
		con = getConnection();
		
		try {
			String sql = null;
//			댓글일 경우
			if(comment_class == 1) {
//				해당 댓글의 group_num에 해당하는 글들을 모두 삭제
				sql = "DELETE FROM content_reply WHERE group_num = ?";
			} else {
//				대댓글일 경우, 본인 글만 삭제
				sql = "DELETE FROM content_reply WHERE index_comment = ?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index_comment);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return deleteCount;
	}
	
}
