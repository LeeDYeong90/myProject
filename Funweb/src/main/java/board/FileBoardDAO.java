package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class FileBoardDAO {


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

	public int insertFileBoard(FileBoardDTO fileBoard) {
		
	int insertFileCount = 0;
	con = getConnection();
	
	try {
		String sql = "SELECT MAX(num) FROM file_board";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		int num = 1;
		if(rs.next()) {
			num = rs.getInt("MAX(num)") +1;
			}
		sql = "INSERT INTO file_board VALUES (?,?,?,?,?,?,?,now(),0)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, fileBoard.getName());
		pstmt.setString(3, fileBoard.getPass());
		pstmt.setString(4, fileBoard.getSubject());
		pstmt.setString(5, fileBoard.getContent());
		pstmt.setString(6, fileBoard.getFile());
		pstmt.setString(7, fileBoard.getOriginal_file());
		insertFileCount = pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("SQL 구문 오류 발생!");
		e.printStackTrace();
	} finally {
		close(rs);
		close(pstmt);
		close(con);
	}
	return insertFileCount;
	}
	
	//게시물 전체 갯수 조회를 위한 getListCount()메서드 정의
	public int getListCount() {
		int listCount = 0;
		con = getConnection();
		
		try {
			String sql = "SELECT COUNT(*) FROM file_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1); //또는 getInt("COUNT(*)") 그대로 저장 
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
	
	public ArrayList<FileBoardDTO> selectFileBoardList() {
		ArrayList<FileBoardDTO> fileBoardList = null;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM file_board ORDER BY date DESC LIMIT 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			fileBoardList = new ArrayList<FileBoardDTO>();
			while(rs.next()) {
				FileBoardDTO dto = new FileBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				
				fileBoardList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return fileBoardList;
	}
//	게시물 목록 조회를 위한 selectFileBoardList() 메서드 정의 => 페이징 처리 추가
	public ArrayList<FileBoardDTO> selectFileBoardList(int pageNum, int listLimit) {
		ArrayList<FileBoardDTO> fileBoardList = null;
		
		con = getConnection();
		
		try {
//			현재 페이지에서 조회할 레코드의 첫번째 행번호 계산
//			=> 1페이지일 때 0, 2페이지일 때 10, 3페이지일 때, 20
			int startRow = (pageNum - 1) * listLimit;
			String sql = "SELECT * FROM file_board ORDER BY num DESC LIMIT ?,?";
//			LIMIT(시작 행번호, 레코드 수)
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();
			
			fileBoardList = new ArrayList<FileBoardDTO>();
			while(rs.next()) {
				FileBoardDTO dto = new FileBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				
				fileBoardList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return fileBoardList;
	}
	public FileBoardDTO selectFileBoard(int num) {
		FileBoardDTO dto = null;
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM file_board WHERE num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new FileBoardDTO();
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setSubject(rs.getString("subject"));
				dto.setOriginal_file(rs.getString("original_file"));
				dto.setContent(rs.getString("content"));
				dto.setFile(rs.getString("file"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return dto;
	}
	
	public void updateFileReadcount(int num) {
		con = getConnection();
		try {
			String sql = "UPDATE file_board SET readcount=readcount+1 WHERE num=?";
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
	
	public int updateFileBoard(FileBoardDTO dto) {
		int updateFileCount = 0;
		con = getConnection();
		try {
			String sql = "UPDATE file_board SET subject=?, content=?, file=?, original_file=?, date=now() WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFile());
			pstmt.setString(4, dto.getOriginal_file());
			pstmt.setInt(5, dto.getNum());
			pstmt.setString(6, dto.getPass());
			
			updateFileCount = pstmt.executeUpdate();
		}  catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return updateFileCount;
	}
	
	public boolean deleteFileBoard(int num, String pass) {
		boolean isDeleteSuccess = false;
		con = getConnection();
		
		try {
			String sql = "DELETE FROM file_board WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			int deleteCount = pstmt.executeUpdate();
			if(deleteCount == 1) {
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
	

	public ArrayList<FileBoardDTO> selectSearch(int pageNum, int listLimit, String keyword, String search) {
		ArrayList<FileBoardDTO> fileBoardList = null;
		con = getConnection();
		try {
			int startRow = (pageNum-1)*listLimit;
			String sql = "SELECT * FROM board WHERE " + keyword + " LIKE ? ORDER BY date DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			rs = pstmt.executeQuery();
			fileBoardList = new ArrayList<FileBoardDTO>();
			while(rs.next()) {
				FileBoardDTO dto = new FileBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setSubject(rs.getString("subject"));
				dto.setReadcount(rs.getInt("readcount"));
				fileBoardList.add(dto);
			}
		}catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return fileBoardList;
	}
	
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
