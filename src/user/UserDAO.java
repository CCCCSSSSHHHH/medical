package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {//실질적으로 데이터베이스에서 회원정보를 불러오거나 데이터베이스에 회원정보를 넣고자할때 사용
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //나중에 DB에러나면 확인해보기
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
	
	public int login(String userID, String userPassword) { //여기가문제인거같음
		String SQL="SELECT userPassword FROM USER WHERE userID = ?"; 
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString( 1,userID); //SQL injection같은 해킹기법을 방어하기 위한 수단  
										//위에 String SQL에 마지막에 ?부분에다가 userID를 넣어주는 방법 
			rs =pstmt.executeQuery(); //결과를 담을수있는 객체 rs 실행한 결과를 넣어줌.
			if(rs.next()) { //결과가 존재한다면 이문구 실행.
					
					if(rs.getString(1).equals(userPassword)) 
						return 1;//로그인 성공.
					else
						return 0;			
			}
			return -1; //결과가 존재하지 않는다면 아이디가 없다고 알려줌.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류 			
		}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
		
	}
	
}
