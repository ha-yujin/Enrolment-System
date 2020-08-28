<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>교수 상담 신청</title></head>
<body>

	<%
		String s_id = (String) session.getAttribute("user");
		String p_name = new String(request.getParameter("p_name").getBytes("8859_1"),"utf-8");
		//int year=Integer.parseInt(request.getParameter("year"));
		//int semester = Integer.parseInt(request.getParameter("semester"));
		int t_time = Integer.parseInt(request.getParameter("t_time"));

		Connection myConn = null;
		String result = null;
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
		String user = "ST2017112142"; 
		String passwd = "ST2017112142";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";

		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}

		CallableStatement cstmt = myConn.prepareCall("{call InsertConsult(?, ?, ?, ?)}");
		cstmt.setString(1, s_id);
		cstmt.setString(2, p_name);
		cstmt.setInt(3,t_time);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
		try {
			cstmt.execute();
			result = cstmt.getString(4);
			System.out.println(result);
	%>
	<script>	
	alert("<%=result%>");
		location.href = "consult.jsp";
	</script>
	<%
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		} finally {
			if (cstmt != null)
				try {
					myConn.commit();
					cstmt.close();
					myConn.close();
				} catch (SQLException ex) {

				}
		}
	%>
</body></html>