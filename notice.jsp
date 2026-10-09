<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f4f7fc;
}

.card{
    border:none;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.1);
}

.header{
    background:#1e3a8a;
    color:white;
    padding:15px;
    border-radius:15px 15px 0 0;
}

</style>

</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/demo";
String uname = "root";
String pass = "Pass@123";

String query = "SELECT * FROM notice";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, uname, pass);
    PreparedStatement stat = con.prepareStatement(query);
    ResultSet rs = stat.executeQuery();
%>
<div class="container mt-5">

    <!-- Publish Notice -->

    <div class="card mb-4">

        <div class="header">
            <h3>Publish Notice</h3>
        </div>

        <div class="card-body">

            <form action="notice_process.jsp" method="post">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label>From Date</label>
                        <input type="date"
                               name="from_date"
                               class="form-control"
                               required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>To Date</label>
                        <input type="date"
                               name="to_date"
                               class="form-control"
                               required>
                    </div>
                    
                     <div class="col-md-6 mb-3">
                        <label>Enter specific student id</label>
                        <input type="text"
                               name="student_id"
                               class="form-control"
                               value="null"
                        >
                    </div>
                    
                    <div class="col-md-6 mb-3">
                    <label class="form-label">Department</label>
                    <select class="form-select" name = "department">
                        <option>Select Department</option>
                        <option>Computer Science</option>
                        <option>Information Technology</option>
                        <option>Mechanical</option>
                        <option>Civil</option>
                        <option>Electronics</option>
                    </select>
                </div>

                </div>

                <div class="mb-3">

                    <label>Notice Description</label>

                    <input
                        name="info"
                        class="form-control"
                        required
                    >
                    	

                </div>

                <button type="submit"
                        class="btn btn-primary">
                    Publish Notice
                </button>

            </form>

        </div>

    </div>

    <!-- Previous Notices -->

    <div class="card">

        <div class="header">
            <h3>Previous Notices</h3>
        </div>

        <div class="card-body">

            <table class="table table-bordered table-hover">

                <thead class="table-primary">

                    <tr>
                        <th>ID</th>
                        <th>From Date</th>
                        <th>To Date</th>
                        <th>Notice</th>
                        <th>Action</th>
                    </tr>

                </thead>

                <tbody>

                   <%while(rs.next()){ %>

                    <tr>

                        <td><%=rs.getInt(1) %></td>
                        <td><%=rs.getString(2) %></td>
                        <td><%=rs.getString(3)%></td>
                        <td><%=rs.getString(4)%></td>

                        <td>

						<button onclick="window.location.href='update_notice.jsp?id=<%=rs.getInt(1)%>&flag=1'"
						        class="btn btn-warning btn-sm">
						    Update
						</button>

						<button onclick="window.location.href='delete_notice.jsp?id=<%=rs.getInt(1)%>&flag=0'"
						        class="btn btn-danger btn-sm">
						    Delete
						</button>
                        </td>

                    </tr>
                    <%} %>

                </tbody>

            </table>

        </div>

    </div>

</div>
<%
}
catch(Exception e) {
    e.printStackTrace();
}
%>

</body>
</html>