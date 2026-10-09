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

String notice_id = (String)session.getAttribute("notice_id");
String student_id = request.getParameter("student_id");
String from_date = request.getParameter("from_date");
String to_date = request.getParameter("to_date");
String description = request.getParameter("info");
String department = request.getParameter("department");
out.print(notice_id);
Connection con = null;
PreparedStatement stat = null;
String url = "jdbc:mysql://localhost:3306/demo";
String username = "root";
String password = "Pass@123";




try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(url, username, password);
    

    if(student_id.equals("null"))
    {
    String query = "update notice set from_date=?,to_date=?,description=?,department=? where id=?";
    stat = con.prepareStatement(query);
    stat.setString(1, from_date);
    stat.setString(2, to_date);
    stat.setString(3, description);
    stat.setString(4, department);
    stat.setString(5, notice_id);
    }
    else
    {
    	String query = "update notice set from_date=?,to_date=?,description=?,department=?,student_id=? where id=?";
    	stat = con.prepareStatement(query);
        stat.setString(1, from_date);
        stat.setString(2, to_date);
        stat.setString(3, description);
        stat.setString(4, department);
        stat.setString(5,student_id);
        stat.setString(6,notice_id);
    }
    int rows = stat.executeUpdate();
    if(rows > 0){  
        response.sendRedirect("notice.jsp");
    } else {
        out.println("Record not inserted.");
    }
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
</body>
</html>