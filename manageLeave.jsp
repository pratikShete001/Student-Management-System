<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/demo";
String uname = "root";
String pass = "Pass@123";

String status = request.getParameter("status");
String id = request.getParameter("id");
Connection conn = null;
PreparedStatement st = null;
ResultSet rs = null;

try
{
	String query = "update leave_request set status=? where stud_id = ?;";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url,uname,pass);
	st = conn.prepareStatement(query);
	st.setString(1,status);
	st.setString(2,id);
	int rows=st.executeUpdate();
	if(rows>0)
	{
		response.sendRedirect("admin.jsp");
	}
	else
	{
		out.print("Error Occures");
	}
}catch(Exception e)
{
	
}
%>
</body>
</html>