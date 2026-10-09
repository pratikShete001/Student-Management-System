<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>
<%
int id = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String department = request.getParameter("department");

Connection con = null;
PreparedStatement stat = null;

String url = "jdbc:mysql://localhost:3306/demo";
String username = "root";
String password = "Pass@123";



String query = "update registration set name=?,email=?,mobile=?,department=? where id = "+id;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(url, username, password);
    stat = con.prepareStatement(query);

    stat.setString(1, name);
    stat.setString(2, email);
    stat.setString(3, mobile);
    stat.setString(4, department);
    

    int rows = stat.executeUpdate();
    if(rows > 0){  
        response.sendRedirect("viewStudent.jsp");
    } else {
        out.println("Record not inserted.");
    }
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(stat != null) stat.close();
    if(con != null) con.close();
}
%>
</body>
</html>