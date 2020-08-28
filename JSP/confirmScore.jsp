<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>

<html><head><title>수강신청 입력</title></head>
<body>

	<%@ include file="top.jsp"%>
	<% if (session_id == null)	response.sendRedirect("login.jsp");	%>
	
	<table width="75%" align="center" border>	<br>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>학점</th>
			<th>수강학기</th>
			<th>점수</th>
		</tr>
		<%
			Connection myConn = null;
			ResultSet myResultSet = null;
			String mySQL = "";
			String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
			String user = "ST2017112142"; 
			String passwd = "ST2017112142";
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			int totalUnit=0;
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
		                          
			mySQL = "select e.c_id, e.c_id_no, c_name,c_unit, e_year, e_semester, e_score from course c, enroll e where e.c_id=c.c_id and e.s_id='" 
				    + session_id + "' and (e_year != 2020 and e_semester!=1)";

			Statement stmt = myConn.createStatement();
			myResultSet = stmt.executeQuery(mySQL);

			if (myResultSet != null) {
				while (myResultSet.next()) {
					String c_id = myResultSet.getString("c_id");
					int c_id_no = myResultSet.getInt("c_id_no");
					String c_name = myResultSet.getString("c_name");
					int c_unit = myResultSet.getInt("c_unit");
					int e_year=myResultSet.getInt("e_year");
					int e_semester=myResultSet.getInt("e_semester");
					int e_score = myResultSet.getInt("e_score");
					totalUnit +=c_unit;
		%>
		<tr>
			<td align="center"><%=c_id%></td>
			<td align="center"><%=c_id_no%></td>
			<td align="center"><%=c_name%></td>
			<td align="center"><%=c_unit%></td>
			<td align="center"><%=e_year %>학년도 &nbsp <%=e_semester %>학기</td>
			<td align="center"><%=e_score%></td>
		</tr>
		<%
			  }
			}
			stmt.close();
			myConn.close();
		%>
	</table>
	<table width="75%" align="center" border>
		<tr> <td align="center">총 취득학점 수 : <%=totalUnit %></td></tr>
	</table>
</body>
</html>