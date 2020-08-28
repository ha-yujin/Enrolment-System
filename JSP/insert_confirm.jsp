<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<html><head><title> CallableStatement Test </title></head>
<body>
<%
	Connection myConn = null;
	int result1, result2;
	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
	String user = "ST2017112142";   // 본인 아이디(ex.ST0000000000)
	String passwd = "ST2017112142";  // 본인 비밀번호(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String c_id = request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
	
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	} catch (SQLException ex) {
		System.err.println("SQLException : " + ex.getMessage());
	}
	
	CallableStatement cstmt = myConn.prepareCall("{call getCount(?, ?, ?, ?)}");
	cstmt.setString(1, c_id);
	cstmt.setInt(2, c_id_no);
	cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
	cstmt.registerOutParameter(4, java.sql.Types.INTEGER);	
	try {
		cstmt.execute();
		result1 = cstmt.getInt(3);
		result2 = cstmt.getInt(4);
%>
<script>
	alert("모집인원은 <%=result1%>명이며, 현재 수강 신청을 할 수 있는 인원은 <%= result2 %>명 입니다.");
	location.href="insert.jsp";
</script>
<%
	} catch (SQLException ex) {
		System.err.println("SQLException : " + ex.getMessage());
	} finally {
		if (cstmt != null)
			try {
				myConn.commit();
				cstmt.close();
				myConn.close();
			}catch (SQLException ex) {
			}
	}
%>
</body></html>