<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int id = (Integer)session.getAttribute("id");
String leave_reason = request.getParameter("leave_reason");
String to_date = request.getParameter("to_date");
String from_date = request.getParameter("from_date");

String url = "jdbc:mysql://localhost:3306/demo";
String username = "root";
String password = "Pass@123";
String error = null;
String query = "insert into leave_request(stud_id,leave_reason,from_date,to_date) values(?,?,?,?)";
try{
	PreparedStatement pst = null;
	ResultSet rs = null;
	Connection con = null;
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection(url,username,password);
	pst=con.prepareStatement(query);
	pst.setInt(1, id);
	pst.setString(2,leave_reason);
	pst.setString(3,from_date);
	pst.setString(4,to_date);
	int rows = pst.executeUpdate();
	if(rows>0)
	{
		response.sendRedirect("student_dashbord.jsp");
	}
	else
	{
		 error ="something is wrong";
	}
}
catch(Exception e)
{
	out.print(e.getMessage());
}
%>
<h1><%=error %></h1>
</body>
</html>