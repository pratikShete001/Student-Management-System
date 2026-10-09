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

String url = "jdbc:mysql://localhost:3306/demo";
String uname = "root";
String pass = "Pass@123";

String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String role = request.getParameter("role");
String department = request.getParameter("department");
String password = request.getParameter("password");
//out.print(name+" "+email+" "+" "+mobile+" "+role+" "+department+" "+password+" ");
String query = "INSERT INTO registration(name, email, mobile, role, department, password) VALUES(?,?,?,?,?,?)";
int rows;

Connection con = null;
PreparedStatement st = null;
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	con =DriverManager.getConnection(url,uname,pass);
	st = con.prepareStatement(query);
	out.print("connection successful");
	st.setString(1,name);
	st.setString(2,email);
	st.setString(3,mobile);
	st.setString(4,role);
	st.setString(5,department);
	st.setString(6,password);
	
	rows = st.executeUpdate();
	if(rows>0)
	{
		response.sendRedirect("login.html");
	}
	else
	{
		out.print("failed");
	}
}
catch(Exception e)
{
	out.print("Error: " + e.getMessage());
    e.printStackTrace();

}

%>

</body>
</html>