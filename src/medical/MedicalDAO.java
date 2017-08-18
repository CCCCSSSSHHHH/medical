package medical;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MedicalDAO {
	private Connection conn;
	
	private ResultSet rs;
	
	public MedicalDAO() { //나중에 DB에러나면 확인해보기
		try {
			String dbURL ="jdbc:mysql://localhost:3306/MEDICAL? autoReconnect=true&useSSL=false";
			String dbID ="root";
			String dbPassword ="Tmdgus12@";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() { //현재시간을 가져오는 함수 
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우
				return rs.getString(1);//현재의 날씨반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//데이터베이스 오류
	}
	
	public int getNext() { 
		String SQL = "SELECT medicalID FROM MEDICAL ORDER BY medicalID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우
				return rs.getInt(1) + 1; //
			}
			return 1;//첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int write(String medicalTitle,String userID, String medicalContent) {
		String SQL = "INSERT INTO MEDICAL VALUES(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, medicalTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, medicalContent);  
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<Medical> getList(int pageNumber){//특정한페이지에 맞는 게시글 보여주기
		String SQL = "SELECT * FROM MEDICAL WHERE medicalID < ? AND medicalAvailable = 1 ORDER BY medicalID DESC LIMIT 10";
		ArrayList<Medical> list = new ArrayList<Medical>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); //위에 SQL문의 ? 안에 들어갈 구문 getNext()는 그다음으로 작성될 글을 의미 		
			rs = pstmt.executeQuery();
			while(rs.next()) {//결과가 있는경우
				Medical medical = new Medical();				
				medical.setMedicalID(rs.getInt(1));
				medical.setMedicalTitle(rs.getString(2));
				medical.setUserID(rs.getString(3));
				medical.setMedicalDate(rs.getString(4));
				medical.setMedicalContent(rs.getString(5));
				medical.setMedicalAvailable(rs.getInt(6));	
				medical.setMedicalhit(rs.getInt(7));
				list.add(medical);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	public boolean nextPage(int pageNumber) { //페이징처리를위해서 존재하는 함수
		String SQL = "SELECT * FROM MEDICAL WHERE medicalID < ? AND medicalAvailable = 1  ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10); //위에 SQL문의 ? 안에 들어갈 구문 getNext()는 그다음으로 작성될 글을 의미 
			
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우			
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}
	public Medical getMedical(int medicalID) { //제목눌렀을시 게시글 보여주는 함수
		String SQL = "SELECT * FROM MEDICAL WHERE medicalID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,medicalID); //위에 SQL문의 ? 안에 들어갈 구문 getNext()는 그다음으로 작성될 글을 의미 
			
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우			
				Medical medical = new Medical();				
				medical.setMedicalID(rs.getInt(1));
				medical.setMedicalTitle(rs.getString(2));
				medical.setUserID(rs.getString(3));
				medical.setMedicalDate(rs.getString(4));
				medical.setMedicalContent(rs.getString(5));
				medical.setMedicalAvailable(rs.getInt(6));
				medical.setMedicalhit(rs.getInt(7));
				
				return medical;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	public int update(int medicalID, String medicalTitle, String medicalContent) {
		String SQL = "UPDATE MEDICAL SET medicalTitle = ?, medicalContent = ? WHERE medicalID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, medicalTitle);
			pstmt.setString(2, medicalContent);
			pstmt.setInt(3, medicalID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//데이터베이스 오류
	}
	
	public int delete(int medicalID) {
		String SQL = "UPDATE MEDICAL SET medicalAvailable = 0 WHERE medicalID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, medicalID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//데이터베이스 오류		
	}
	
}
