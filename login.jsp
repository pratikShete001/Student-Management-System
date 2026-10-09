<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Validation</title>
</head>
<body>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
	int id=0;
    String url = "jdbc:mysql://localhost:3306/demo";
    String uname = "root";
    String pass = "Pass@123";

    String query = "SELECT * FROM registration WHERE email=? AND password=? AND role=?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, uname, pass);
        PreparedStatement stat = con.prepareStatement(query);
        stat.setString(1, email);
        stat.setString(2, password);
        stat.setString(3, role);

        ResultSet rs = stat.executeQuery();

        if(rs.next()) {
            session.setAttribute("email", email);
            session.setAttribute("role", role);
            session.setAttribute("password",password);
            if("student".equalsIgnoreCase(role)) {
                response.sendRedirect("student_dashbord.jsp");
            } else {
                response.sendRedirect("admin.jsp");
            }
        } else {
            out.print("Invalid login credentials!");
            response.sendRedirect("login.html");
        }

    } catch(Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
