<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"  %>
<jsp:useBean id="DB" class="enrollBean.Update" scope="page"/>
<%@ page import="enrollBean.student_Info" %>
<html>
<head><title>수강신청 사용자 정보 수정</title></head>
<body>
<%@ include file="top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("login.jsp");
	
    student_Info stu = new student_Info();
    stu=DB.getStuInfo(session_id);
%>

<form method="post" action="update_verify.jsp">
  <input type="hidden" name="s_id" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
     <tr><th>이름</th>
	<td><input type="text" name="s_name" size="50" value="<%=stu.getName()%>"></td>
     </tr>
     <tr><th>주소</th>
         <td><input type="text" name="s_addr" size="50" value="<%= stu.getAddr() %>"> </td>
     </tr>
     <tr><th>패스워드</th>
         <td><input type="password" name="s_pwd" size="20"  value="<%= stu.getPwd() %>"></td>
     </tr>
     <tr><th>학부</th>
	<td><input type="text" name="s_college" size="50" value="<%=stu.getCollege()%>"></td>   
     </tr>
     <tr><th>전공</th>
         <td><input type="text" name="s_major" size="50" value="<%= stu.getMajor()%>"> </td>
     </tr>			   
<tr>
	<td colspan="2" align="center">
	<input type="submit" value="수정">
	</td> 
</tr>
</table></form></body></html>

