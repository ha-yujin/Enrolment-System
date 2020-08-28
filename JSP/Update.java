package enrollBean;
import java.sql.*;

import enrollBean.student_Info;
public class Update {

	private Connection myconn=null;
	private Statement stmt=null;
	private ResultSet rs=null;
	
	public Update() {
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
	
	public student_Info getStuInfo(String s_id) {
		
		student_Info stu=new student_Info();
	    String mySQL = "select s_addr, s_pwd, s_name, s_college, s_major from student where s_id='" + s_id + "'" ;
        try {
        	this.rs=this.stmt.executeQuery(mySQL);
        	while(this.rs.next()) {
        		String s_addr = this.rs.getString("s_addr");
        		String s_pwd = this.rs.getString("s_pwd");	
        		String s_name = this.rs.getString("s_name");
        		String s_college =this.rs.getString("s_college");
        		String s_major = this.rs.getString("s_major");	
        		stu.setAddr(s_addr);
        		stu.setPwd(s_pwd);
        		stu.setName(s_name);
        		stu.setCollege(s_college);
        		stu.setMajor(s_major);
        	}
        	this.stmt.close();
        	this.myconn.close();
        }catch(Exception ex) {
        	System.out.println("Exception "+ex);
        }
		return stu;
	}
	
	public String updateStuInfo(String s_id, String s_addr,String s_pwd, String s_name,
			String s_college, String s_major) {
		
		String mySQL="";
		String sMessage=null;
		mySQL="update student ";
		mySQL=mySQL+" set s_addr='"+s_addr+"',";
		mySQL=mySQL+" s_name='"+s_name+"',";
		mySQL=mySQL+" s_college='"+s_college+"',";
		mySQL=mySQL+" s_major='"+s_major+"',";
		mySQL=mySQL+" s_pwd='"+s_pwd+"' where s_id='"+s_id+"' ";
		
		try {
			this.stmt.executeUpdate(mySQL);
			this.stmt.close();
			this.myconn.close();
		}
		catch(SQLException ex) {
			if(ex.getErrorCode()==20002) sMessage="암호는 4자리 이상이어야 합니다.";
			else if(ex.getErrorCode()==20003) sMessage="암호에 공란은 입력되지 않습니다.";
			else sMessage="잠시 후 다시 시도하십시오.";
		}
		return sMessage;
	}
}
