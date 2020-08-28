<%@ page contentType = "text/html; charset =utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="DB" class="enrollBean.Update" scope="page"/>
<html>
<head><title>수강신청 사용자 정보 수정 </title></head>
<body>
<%
	String s_id=request.getParameter("s_id");
	String s_addr = new String(request.getParameter("s_addr").getBytes("8859_1"),"utf-8");
	String s_pwd = new String(request.getParameter("s_pwd").getBytes("8859_1"),"utf-8");
	String s_name = new String(request.getParameter("s_name").getBytes("8859_1"),"utf-8");
	String s_college=new String(request.getParameter("s_college").getBytes("8859_1"),"utf-8");
	String s_major=new String(request.getParameter("s_major").getBytes("8859_1"),"utf-8");

	String sMessage=DB.updateStuInfo(s_id, s_addr, s_pwd, s_name, s_college, s_major);
	if(sMessage==null){
%>
<script>
	alert("학생 정보가 수정되었습니다.");
	location.href="update.jsp";
</script>
<%
	}else{
%>
<script>
	alert("<%= sMessage %>");
	location.href="update.jsp";
</script>
<%	
	}
%>
</body></html>