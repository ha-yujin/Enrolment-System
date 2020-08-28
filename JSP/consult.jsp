<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:useBean id="DB" class="enrollBean.EnrollCons" scope="page"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>교수 상담 신청</title><head>
<style>
	form{
		margin:0 auto;
		width:100%;
		padding-left:40%;
	}
</style>
<body>

<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>
<% 
	String p_id="";
	int year=DB.getCurrentYear();
	int semester=DB.getCurrentSemester();
	ArrayList<String> prof=new ArrayList<>();
	prof=DB.getProfList();
%>
<h3 align="center"> <%=year %>년도 <%=semester %>학기 상담신청</h3>
<form method="post" action="consult_verify.jsp" align="center">
	<select name="p_name">
		<% for(int i=0;i<prof.size();i++){ %>
		<option value="<%=prof.get(i) %>"><%=prof.get(i) %></option>
		<%} %>
	</select>
	<select name="t_time">
		<% for(int i=1;i<=10;i++){ %>
		<option value="<%=i %>"><%=i %>교시</option>
		<%} %>
	</select>
	<input type="hidden" name="year" value=<%= year %>>
	<input type="hidden" name="semester" value=<%= semester %>>
	<input type="submit" value="신청">
</form>

<hr width="75%" align="center">

<h3 align="center">상담 내역</h3>
<table width="75%" align="center" border><br>
	<tr>
		<th> 교수명 </th>
		<th> 년도/학기 </th>
	</tr>
<%
	Connection myConn = null;
	ResultSet rs = null;
	String mySQL = "";
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
	mySQL="select c.*, p_name from consult c, professor p where p.p_id=c.p_id and s_id='"+session_id+"'";
	Statement stmt=myConn.createStatement();
	rs=stmt.executeQuery(mySQL);
	
	if(rs!=null){
		while(rs.next()){
			String p_name=rs.getString("p_name");
    		int y=rs.getInt("co_year");
    		int s=rs.getInt("co_semester");
%>
	<tr>
		<td align="center"><%=p_name%></td>
		<td align="center"><%=y%>년도 <%=s %>학기</td>
	</tr>
<%		}
	}
	stmt.close();
	myConn.close();
%>
</table>
</body>
</html>