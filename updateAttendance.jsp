<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Attendance</title>
</head>
<body>
<%
String id = request.getParameter("id");
String status = request.getParameter("status");
String department = request.getParameter("department");

String url = "jdbc:mysql://localhost:3306/demo";
String uname = "root";
String pass = "Pass@123";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, uname, pass);

    // Step 1: Check if record exists for student_id + today
    String checkQuery = "SELECT * FROM attendance WHERE student_id=? AND attendance_date=CURDATE() and status='null'";
    PreparedStatement checkPst = con.prepareStatement(checkQuery);
    checkPst.setString(1, id);
    ResultSet rs = checkPst.executeQuery();

    if (rs.next()) {
        // Step 2: If exists → Update
        String updateQuery = "UPDATE attendance SET status=? WHERE student_id=? AND attendance_date=CURDATE()";
        PreparedStatement updatePst = con.prepareStatement(updateQuery);
        updatePst.setString(1, status);
        updatePst.setString(2, id);
        updatePst.executeUpdate();
        updatePst.close();
        response.sendRedirect("markAttendance.jsp?department="+department);
    } else {
        // Step 3: If not exists → Insert
        String insertQuery = "INSERT INTO attendance(student_id, status, attendance_date) VALUES (?, ?, CURDATE())";
        PreparedStatement insertPst = con.prepareStatement(insertQuery);
        insertPst.setString(1, id);
        insertPst.setString(2, status);
        insertPst.executeUpdate();
        insertPst.close();
        response.sendRedirect("markAttendance.jsp?department="+department);
    }

    rs.close();
    checkPst.close();
    con.close();

      
} catch(Exception e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
}
%>

</body>
</html>
