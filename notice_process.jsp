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
String url = "jdbc:mysql://localhost:3306/demo";
String username = "root";
String password = "Pass@123";
String error = null;

String flag= request.getParameter("flag");
String notice_id=request.getParameter("id");
String stud_id = request.getParameter("student_id");
String query=null;
String from_date = request.getParameter("from_date");
String to_date = request.getParameter("to_date");
String description = request.getParameter("info");
String department = request.getParameter("department");


try{
	PreparedStatement pst = null;
	ResultSet rs = null;
	Connection con = null;
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection(url,username,password);
	
	if(stud_id.equals("null"))
	{
		query = "insert into notice(from_date,to_date,description,department) values(?,?,?,?)";
		pst=con.prepareStatement(query);
		pst.setString(1, from_date);
		pst.setString(2,to_date);
		pst.setString(3,description);
		pst.setString(4,department);
	}
	else
	{
		query = "insert into notice(from_date,to_date,description,department,student_id) values(?,?,?,?,?)";
		pst=con.prepareStatement(query);
		pst.setString(1, from_date);
		pst.setString(2,to_date);
		pst.setString(3,description);
		pst.setString(4,department);
		pst.setString(5,stud_id);
	}
	int rows = pst.executeUpdate();
	if(rows>0)
	{
		response.sendRedirect("notice.jsp");
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
</body>
</html>