<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
  String userID = request.getParameter("userID");
  String userPassword = request.getParameter("userPassword");
 
  Connection myConn = null;
  Statement stmt = null;	
  String mySQL = null;

  String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
  String user="ST2017112142";    // 본인 아이디(ex.ST0000000000)
  String passwd="ST2017112142";   // 본인 패스워드(ex.ST0000000000)
  String dbdriver = "oracle.jdbc.OracleDriver";

  Class.forName(dbdriver);
  myConn =  DriverManager.getConnection (dburl, user, passwd); 
  stmt = myConn.createStatement();	

  mySQL = "select s_id, s_name from student where s_id='" + userID + "' and  s_pwd='" + userPassword + "'";

  ResultSet myResultSet = stmt.executeQuery(mySQL);
  if (myResultSet.next()) {
      String userName=myResultSet.getString("s_name");
      session.setAttribute("user", userID);
      session.setAttribute("user_name",userName);
      response.sendRedirect("main.jsp");
  } else {
%>
<script>
	alert("사용자아이디 혹은 암호가 틀렸습니다");
    location.href = "login.jsp";
</script>
<%
  }
  stmt.close();
  myConn.close();
%>
  
  
  