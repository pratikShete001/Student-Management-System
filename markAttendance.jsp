<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
				integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
				crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
				integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
				crossorigin="anonymous"></script>
<script>
function present(id, department, status) {

    window.location.href = "updateAttendance.jsp?id=" + id + "&department=" + department + "&status=" + status;
}

</script>
<meta charset="UTF-8">
<title>mark attendance</title>
</head>
<body>
	<%
	int flag = 0;
 	String role = "Student";
 	
 	String department = request.getParameter("department");
 	
    String url = "jdbc:mysql://localhost:3306/demo";
    String uname = "root";
    String pass = "Pass@123";

    String query = "SELECT * FROM registration where role = ? and department = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, uname, pass);
        PreparedStatement stat = con.prepareStatement(query);
        stat.setString(1,role);
        stat.setString(2,department);
        ResultSet rs = stat.executeQuery();
        %>
        <table class="table table-light table-hover">
        <tr>
		<th>Id</th>
		<th>name</th>
		<th>Email</th>
		<th>Mobile</th>
		<th>Department</th>
		<th>Action</th>
		<tr>
		<% while(rs.next()){ %>

			<tr>
				<td>
					<%=rs.getInt(1) %>
				</td>
				<td>
					<%=rs.getString(2) %>
				</td>
				<td>
					<%=rs.getString(3) %>
				</td>
				<td>
					<%=rs.getString(4) %>
				</td>
				<td>
					<%=rs.getString(6) %>
				</td>
				<td><button type="check box" class="btn btn-primary" onclick="present(<%= rs.getInt(1) %>,'<%=rs.getString(6) %>', 'present')"
>Present</button>
					<button type="button" class="btn btn-warning" onclick="present(<%= rs.getInt(1)%>,'<%=rs.getString(6) %>', 'absent')">Absent</button>
				</td>
			</tr>
			<% } %>
	
	</table>
	<button type="button" class="btn btn-warning" onclick="window.location.href='admin.jsp'">Home page</button>			
	<% 
    }catch(Exception e)
    {
    	out.print(e.getMessage());
    }
      %>
</body>
</html>