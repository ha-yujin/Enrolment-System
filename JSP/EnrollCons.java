package enrollBean;

import java.sql.*;
import java.util.*;

public class EnrollCons {

	private Connection myconn=null;
	private Statement stmt=null;
	private ResultSet rs=null;
	
	public EnrollCons() {
		
		String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
		String user="ST2017112142";     // 본인 아이디(ex.ST0000000000)
		String passwd="ST2017112142";   // 본인 패스워드(ex.ST0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver";    

		try {
			Class.forName(dbdriver);
			myconn=DriverManager.getConnection(dburl,user,passwd);
			stmt=myconn.createStatement();
		}catch(Exception e) {
			System.out.println("DB 연동 오류입니다. : "+e.getMessage());
		}
	}

	public int getCurrentYear() {
		int nYear = 0;
		CallableStatement cstmt = null;
		try {

			cstmt = myconn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nYear = cstmt.getInt(1);

			cstmt.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return nYear;
	}

	public int getCurrentSemester() {
		int nSemester = 0;
		CallableStatement cstmt = null;

		try {
			cstmt = myconn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nSemester = cstmt.getInt(1);

			cstmt.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return nSemester;
	}
	
	public ArrayList getProfList() {
		
		ArrayList<String> prof=new ArrayList<>();
	    String mySQL = "select p_name from professor";
        try {
        	this.rs=this.stmt.executeQuery(mySQL);
        	while(this.rs.next()) {
        		String p_name = this.rs.getString("p_name");
        		prof.add(p_name);
        	}
        	
        	this.stmt.close();
        	this.myconn.close();
        }catch(Exception ex) {
        	System.out.println("Exception "+ex);
        }
        return prof;
	}
}