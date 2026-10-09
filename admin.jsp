<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script>
function mark(department) {
    window.location.href = "markAttendance.jsp?department=" + department;
}
function leave(id,status)
{
	window.location.href = "manageLeave.jsp?id="+id+"&status="+status;
}
</script>
<style>

body{
    background:#f4f7fc;
    font-family:'Segoe UI',sans-serif;
}

/* Sidebar */

.sidebar{
    position:fixed;
    width:260px;
    height:100vh;
    background:#0f172a;
    color:white;
    overflow-y:auto;
}

.logo{
    padding:25px;
    text-align:center;
    border-bottom:1px solid rgba(255,255,255,.1);
}

.logo i{
    font-size:50px;
}

.logo h4{
    margin-top:10px;
    font-weight:600;
}

.sidebar ul{
    list-style:none;
    padding:0;
    margin-top:20px;
}

.sidebar ul li{
    padding:15px 25px;
    transition:.3s;
}

.sidebar ul li:hover{
    background:#1e3a8a;
    cursor:pointer;
}

.sidebar ul li i{
    margin-right:12px;
}

/* Main Content */

.main-content{
    margin-left:260px;
    padding:30px;
}

.header-card{
    background:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
}

/* Statistics */

.stat-card{
    border:none;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
    transition:.3s;
}

.stat-card:hover{
    transform:translateY(-5px);
}

.stat-icon{
    font-size:35px;
}

/* Sections */

.dashboard-section{
    background:white;
    border-radius:15px;
    padding:20px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
}

/* Quick Actions */

.action-btn{
    height:90px;
    border-radius:15px;
    font-weight:600;
}

.action-btn i{
    font-size:30px;
    display:block;
    margin-bottom:8px;
}

@media(max-width:992px){

.sidebar{
    width:100%;
    height:auto;
    position:relative;
}

.main-content{
    margin-left:0;
}

}

</style>
<meta charset="UTF-8">
<title>Admin page</title>
</head>
<body>
<%
String email = (String)session.getAttribute("email");
String role = (String)session.getAttribute("role");
String password = (String)session.getAttribute("password");

if(role== null || !role.equalsIgnoreCase("admin"))
{
	response.sendRedirect("login.html");
}

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
	String department = null;
	String name = null;
	String mobile = null;
	int id = 0;
    if(rs.next()) {
    	department = rs.getString(6);
    	name = rs.getString(2);
    	mobile = rs.getString(4);
    }
    
    String count = "select count(*) from registration where role='Student' and department=?;";
    PreparedStatement pst = con.prepareStatement(count);
    pst.setString(1,department);
    ResultSet rs2 = pst.executeQuery();
    float countStudent=0;
    if(rs2.next())
    {
    	countStudent = rs2.getInt(1);
    }
    
    String present_stud_count = "SELECT COUNT(*) AS total_present FROM registration r JOIN attendance a ON r.id = a.student_id WHERE r.department = ? AND a.status = 'present'AND a.attendance_date = CURDATE();";
    PreparedStatement pst2 = con.prepareStatement(present_stud_count);
    pst2.setString(1,department);
    ResultSet rs3 = pst2.executeQuery();
    float present_stud_cout=0;
    if(rs3.next())
    {
    	present_stud_cout = rs3.getInt(1);
    }
    float percent_present = (present_stud_cout/countStudent)*100;
    
    String leave_request = "select id,name,leave_reason from registration inner join leave_request on registration.id =leave_request.stud_id where status = 'pending';";
    PreparedStatement pst3 = con.prepareStatement(leave_request);
    ResultSet rs4  = pst3.executeQuery();
    
    
    String leave_count = "select count(*) from leave_request where status='pending';";
    PreparedStatement pst4 = con.prepareStatement(leave_count);
   	ResultSet rs5 = pst4.executeQuery();
   	int leaveCount=0;
  	if(rs5.next())
  	{
  		leaveCount=rs5.getInt(1);
  	}
  	
  	String count_notices = "select count(*) from notice where to_date>=curdate();";
    pst = con.prepareStatement(count_notices);
    ResultSet rs7 = pst.executeQuery();
    int notice_count=0;
    if(rs7.next())
    {
    	notice_count = rs7.getInt(1);
    }
%>	
  <!-- Sidebar -->

<div class="sidebar">

    <div class="logo">
        <i class="bi bi-mortarboard-fill"></i>
        <h4>University ERP</h4>
    </div>

    <ul>
        <li><i class="bi bi-speedometer2"></i> Dashboard</li>

        <li><i class="bi bi-people-fill"></i> Students</li>

        <li><i class="bi bi-calendar-check"></i> Attendance</li>

        <li><i class="bi bi-megaphone-fill"></i> Notices</li>

        <li><i class="bi bi-file-earmark-text"></i> Leave Requests</li>

        <li><i class="bi bi-bar-chart-fill"></i> Reports</li>

        <li><i class="bi bi-person-circle"></i> Profile</li>

        <li>
        <a href="logout.jsp">
        <i class="bi bi-box-arrow-right"></i> Logout</li>
        </a>
    </ul>

</div>

<!-- Main Content -->

<div class="main-content">

    <!-- Welcome -->

    <div class="header-card mb-4">

        <h2>Welcome, <%=name%> 👋</h2>

        <p class="text-muted mb-0">
            Manage students, attendance, notices and reports.
        </p>

    </div>

    <!-- Statistics -->

    <div class="row mb-4">

        <div class="col-md-3 mb-3">
            <div class="card stat-card">
                <div class="card-body text-center">

                    <i class="bi bi-people-fill text-primary stat-icon"></i>

                    <h6 class="mt-2">Total Students</h6>

                    <h2><%= countStudent %></h2>

                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card stat-card">
                <div class="card-body text-center">

                    <i class="bi bi-calendar-check text-success stat-icon"></i>

                    <h6 class="mt-2">Attendance</h6>

                    <h2><%=percent_present%></h2>

                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card stat-card">
                <div class="card-body text-center">

                    <i class="bi bi-megaphone-fill text-warning stat-icon"></i>

                    <h6 class="mt-2">Active Notices</h6>

                    <h2><%=notice_count%></h2>

                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card stat-card">
                <div class="card-body text-center">

                    <i class="bi bi-file-earmark-text text-danger stat-icon"></i>

                    <h6 class="mt-2">Leave Requests</h6>

                    <h2><%=leaveCount%></h2>

                </div>
            </div>
        </div>

    </div>

    <!-- Quick Actions -->

    <div class="dashboard-section mb-4">

        <h5 class="mb-3">Quick Actions</h5>

        <div class="row">

            <div class="col-md-3 mb-3">
                <button onclick="window.location.href='viewStudent.jsp'" class="btn btn-primary w-100 action-btn">
                    <i class="bi bi-person-plus-fill"></i>
                    View Student
                </button>
            </div>

            <div class="col-md-3 mb-3">
                <button onclick="mark('<%=department%>')" class="btn btn-success w-100 action-btn">
                    <i class="bi bi-calendar-plus"></i>
                    Mark Attendance
                </button>
            </div>

            <div class="col-md-3 mb-3">
                <button onclick="window.location.href='notice.jsp'" class="btn btn-warning w-100 action-btn">
                    <i class="bi bi-megaphone"></i>
                    Publish Notice
                </button>
            </div>

            <div class="col-md-3 mb-3">
                <button class="btn btn-info w-100 action-btn">
                    <i class="bi bi-bar-chart-line"></i>
                    View Reports
                </button>
            </div>

        </div>

    </div>

   
        <!-- Leave Requests -->

        <div class="col-lg-6 mb-4">

            <div class="dashboard-section">

                <h5 class="mb-3">Pending Leave Requests</h5>

                <table class="table table-hover">

                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Student</th>
                            <th>Reason</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
<%
while(rs4.next())
{
String status = null;%>
                        <tr>
                            <td><%= rs4.getInt(1)%></td>
                            <td><%=rs4.getString(2)%></td>
                            <td><%=rs4.getString(3)%></td>
                            <td>
                                <button onclick="leave(<%=rs4.getInt(1)%>,'<%=status="Approve"%>')" class="btn btn-success btn-sm">
                                    Approve
                                </button>

                                <button onclick="leave(<%=rs4.getInt(1) %>,'Reject')" class="btn btn-danger btn-sm">
                                    Reject
                                </button>
                            </td>
                     </tr>
<%} %> 
                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>
  
<% 
    con.close();
 } catch(Exception e) {
    out.print(e.getMessage());
 }
 %>


</body>
</html>

