package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class BoardDAO {

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

	public int insertBoard(BoardDTO dto) {
		int insertCount = 0;
		con = getConnection();
		
		try {
			// 새 글 작성 시, 부여할 새 글 번호 계산을 위해 기존 레코드 번호 중 가장 큰 번호 조회
			String sql = "SELECT MAX(num) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int num = 1; // 레코드가 0일 경우 첫 글의 번호는 1로 기본값 저장
			if (rs.next()) {
				num = rs.getInt("Max(num)") + 1; // 조회할때 그냥 num을 쓰면 'Column 'num' not found' 오류 발생

			}
			
			sql = "INSERT INTO board VALUES (?,?,?,?,?,now(), 0)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);//select문에서 조회한 num 값 입력
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
			
		}
		return insertCount;
	}
//	notice의 전체글 수를 리턴하는 메서드
	public int getListCount() {
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(*) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
	}
	
//	main페이지 하단의 최근 게시물 조회를 위해 페이징 처리가 안된 메서드
	public ArrayList<BoardDTO> selectBoardList() {
		ArrayList<BoardDTO> boardList = null;
		con = getConnection();
		try {
			String sql = "SELECT * FROM board ORDER BY date DESC LIMIT 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getNString("subject"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				
				boardList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
			
		}
		return boardList;
	}
//	게시물 목록 조회 메서드. 리턴값 : ArrayList 파라미터값 : 현재 페이지 번호와 페이지 당 게시물 수
	public ArrayList<BoardDTO> selectBoardList(int pageNum, int listLimit) {
		ArrayList<BoardDTO> boardList = null;
		con = getConnection();
		try {
			int startRow = (pageNum-1)*listLimit;
			String sql = "SELECT * FROM board ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getNString("subject"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				
				boardList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
			
		}
		return boardList;
	}

//	게시물의 조회수를 올리는 메서드 리턴값 : 없음 / 파라미터값 : 글번호
	public void updateReadcount(int num) {
		con = getConnection();
		try {
			String sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}  catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
			
		}
				
	}
	
//	게시물 상세 내용을 조회하는 메서드. 리턴값 : BoardDTO / 파라미터값 : 글번호
	public BoardDTO selectContent(int num) {
		con = getConnection();
		BoardDTO dto = null;
		try {
			String sql = "SELECT * FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
			}
		}  catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return dto;
	}	
	
//	글삭제 메서드. 리턴값 : boolean / 파라미터값 : 글번호&삭제창에 입력한 패스워드
	public boolean deleteBoard(int num, String pass) {
		boolean isDeleteSuccess = false;
		con = getConnection();
		
		try {
//			글번호와 패스워드가 둘 다 일치하는 글을 삭제
			String sql = "DELETE FROM board WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			int deleteCount = pstmt.executeUpdate();
			if(deleteCount == 1) {
//				삭제성공 시, true값 리턴
				isDeleteSuccess = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return isDeleteSuccess;
	}
	
//	글수정 메서드. 리턴값 : int / 파라미터값 : BoardDTO
	public int updateBoard(BoardDTO dto) {
		int updateCount = 0;
		con = getConnection();
		
		try {
//			글번호와 패스워드가 둘 다 일치하는 경우, 글제목과 글내용을 수정
			String sql = "UPDATE board SET subject=?, content=? WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			pstmt.setString(4, dto.getPass());
			updateCount = pstmt.executeUpdate();	
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return updateCount;
	}
	
	
//	게시물 검색 메서드. 리턴값 : ArrayList / 파라미터값 : 페이지번호, 게시글수, 검색키워드(작성자/제목/내용), 검색창입력값
	public ArrayList<BoardDTO> selectSearch(int pageNum, int listLimit, String keyword, String search) {
		ArrayList<BoardDTO> boardList = null;
		con = getConnection();
		try {
			int startRow = (pageNum-1)*listLimit;
//			키워드의 값들 중, 입력값을 포함하는 게시물을 조회
			String sql = "SELECT * FROM board WHERE " + keyword + " LIKE ? ORDER BY date DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setSubject(rs.getString("subject"));
				dto.setReadcount(rs.getInt("readcount"));
				boardList.add(dto);
			}
		}catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return boardList;
	}
	
//	검색결과 창 상단에 검색결과 갯수를 반환하는 메서드. 리턴값 : int / 파라미터값 : 검색키워드(작성자/제목/내용), 검색창입력값
	public int getSearchListCount(String keyword, String search) {
		int searchListCount = 0;
		con = getConnection();
		
		try {
			String sql = "SELECT COUNT(*) FROM board WHERE " + keyword + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				searchListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return searchListCount;
	}
}
