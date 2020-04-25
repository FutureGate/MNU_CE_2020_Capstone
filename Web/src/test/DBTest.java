package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConnector;

public class DBTest {
	public static void main(String args[]) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from test";
		
		try {
			
			conn = DBConnector.getInstance().getConnector();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			System.out.println("숫자 리스트가 나오면 성공한 것 >>>>");
			
			while(rs.next()) {
				System.out.println(rs.getInt(1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
