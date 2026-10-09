<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String notice_id = request.getParameter("id");

String url = "jdbc:mysql://localhost:3306/demo";
String uname = "root";
String pass = "Pass@123";

String query = "delete from notice where id=?";
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(url,uname,pass);
	PreparedStatement pst=con.prepareStatement(query);
	pst.setString(1,notice_id);
	int rows = pst.executeUpdate();
	if(rows>0)
	{
		response.sendRedirect("notice.jsp");
	}
	else
	{
		out.print("something is wrong");
	}
}
catch(Exception e)
{
	out.print(e.getMessage());
}


%>
</body>
</html>