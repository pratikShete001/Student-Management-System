<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leave Application</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
    body {
      background-color: #f0f4f8; /* soft light background */
    }
    .card {
      border: none;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .card-header {
      background: #0d6efd; /* Bootstrap primary blue */
      color: #fff;
      font-weight: 600;
      border-radius: 12px 12px 0 0;
      text-align: center;
    }
    h2 {
      color: #0d6efd;
      font-weight: 700;
    }
    .btn-primary {
      background-color: #0d6efd;
      border: none;
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 500;
    }
    .btn-primary:hover {
      background-color: #0b5ed7;
    }
    textarea, input[type="date"] {
      border-radius: 8px;
    }
    table {
      border-radius: 8px;
      overflow: hidden;
    }
    thead {
      background-color: #0d6efd;
      color: #fff;
    }
    .container {
      max-width: 800px; /* center and limit width */
    }
  </style>
</head>

<body class="bg-light">
<%
int id = (Integer)session.getAttribute("id");
%>
<div class="container mt-5">
  <h2 class="text-center mb-4">Student Leave Application</h2>

  <!-- Leave Application Form -->
  <div class="card shadow-sm mb-4">
    <div class="card-header">Apply for Leave</div>
    <div class="card-body">
      <form action="submitLeave.jsp" method="post">
        <div class="mb-3">
          <label for="leaveReason" class="form-label">Reason for Leave</label>
          <textarea class="form-control" id="leaveReason" name="leave_reason" rows="3" required></textarea>
        </div>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="fromDate" class="form-label">From Date</label>
            <input type="date" class="form-control" id="fromDate" name="from_date" required>
          </div>
          <div class="col-md-6 mb-3">
            <label for="toDate" class="form-label">To Date</label>
            <input type="date" class="form-control" id="toDate" name="to_date" required>
          </div>
        </div>
        <button type="submit" class="btn btn-primary w-100">Apply Leave</button>
      </form>
    </div>
  </div>
  
 <!-- Previous Leave Applications -->
  <div class="card shadow-sm">
    <div class="card-header">Previous Leave Applications</div>
    <div class="card-body">
      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>Leave ID</th>
            <th>Reason</th>
            <th>From Date</th>
            <th>To Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <%
            String url = "jdbc:mysql://localhost:3306/demo";
            String uname = "root";
            String pass = "Pass@123";

            try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con = DriverManager.getConnection(url, uname, pass);
              String query = "SELECT * FROM leave_request WHERE stud_id = ?";
              PreparedStatement ps = con.prepareStatement(query);
              ps.setInt(1, id);
              ResultSet rs = ps.executeQuery();

              while(rs.next()) {
          %>
          <tr>
            <td><%= rs.getInt("leave_id") %></td>
            <td><%= rs.getString("leave_reason") %></td>
            <td><%= rs.getDate("from_date") %></td>
            <td><%= rs.getDate("to_date") %></td>
            <td>
              <% String status = rs.getString("status"); %>
              <span class="badge 
                <%= status.equalsIgnoreCase("approved") ? "bg-success" : 
                    status.equalsIgnoreCase("rejected") ? "bg-danger" : "bg-warning text-dark" %>">
                <%= status %>
              </span>
            </td>
          </tr>
          <%
              }
              con.close();
            } catch(Exception e) {
              out.print(e.getMessage());
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
