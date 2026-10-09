<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>

body{
    background:#f4f7fc;
    font-family:'Segoe UI',sans-serif;
}

/* Sidebar */

.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    background:#1e3a8a;
    color:white;
}

.logo{
    padding:25px;
    text-align:center;
    border-bottom:1px solid rgba(255,255,255,.15);
}

.logo i{
    font-size:45px;
}

.logo h4{
    margin-top:10px;
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
    background:rgba(255,255,255,.15);
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

.welcome-card{
    background:white;
    border-radius:15px;
    padding:25px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
}

.stat-card{
    border:none;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
}

.stat-card i{
    font-size:35px;
}

.profile-card,
.notice-card,
.attendance-card{
    background:white;
    border-radius:15px;
    padding:20px;
    box-shadow:0 5px 20px rgba(0,0,0,.08);
}

.table{
    margin-bottom:0;
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
<title>Student dashbord</title>
</head>
<body>
<%
String email = (String)session.getAttribute("email");
String role = (String)session.getAttribute("role");
String password = (String)session.getAttribute("password");

int id =0;
String Studentname = null;
String department = null;
String mobile = null;
if(role== null || !role.equalsIgnoreCase("student"))
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
    if(rs.next())
    {
    	 id=rs.getInt(1);
    	 Studentname = rs.getString(2);
    	 department = rs.getString(6);
    	 mobile = rs.getString(4);
    }
    session.setAttribute("id", id);
    String getCount= "select count(*) from attendance where student_id=?";
    PreparedStatement astat = con.prepareStatement(getCount);
    astat.setInt(1,id);
    ResultSet rs3 = astat.executeQuery();
    int rowCount=0;
    if(rs3.next())
    {
    	rowCount = rs3.getInt(1);
    }
    
    String present= "select count(*) from attendance where student_id=? and status = 'present'";
    PreparedStatement pstat = con.prepareStatement(present);
    pstat.setInt(1,id);
    ResultSet rs4 = pstat.executeQuery();
    int presentCount=0;
    if(rs4.next())
    {
    	presentCount = rs4.getInt(1);
    }
    
    float percentage = 0;
    if(rowCount > 0) {
        percentage = (presentCount * 100) / rowCount;
    }
    
    
    // attendance history
    String history = "select attendance_date,status from attendance where student_id = ? limit 3;";

    PreparedStatement historyst = con.prepareStatement(history);
    historyst.setInt(1,id);
    ResultSet rs5 = historyst.executeQuery();
	
    //publish notice
    String notices = "select * from notice where to_date>=curdate() or student_id=?;";
    PreparedStatement st3 = con.prepareStatement(notices);
    st3.setInt(1, id);
    ResultSet rs6=st3.executeQuery();
    
    String count_notices = "select count(*) from notice where to_date>=curdate();";
    st3 = con.prepareStatement(count_notices);
    ResultSet rs7 = st3.executeQuery();
    int i=0;
    if(rs7.next())
    {
    	i=rs7.getInt(1);
    }

%>
<!-- Sidebar -->
			
			<div class="sidebar">
			
			    <div class="logo">
			        <i class="bi bi-mortarboard-fill"></i>
			        <h4>University Portal</h4>
			    </div>
			
			    <ul>
			        <li><i class="bi bi-speedometer2"></i> Dashboard </li>
			        <li><i class="bi bi-person-circle"></i> My Profile</li>
			        <li>
				    <a href="apply_leave.jsp" class="text-white text-decoration-none">
				        <i class="bi bi-calendar-check"></i> Apply For Leave
				    </a>
					</li>
			        <li><i class="bi bi-megaphone"></i> Notices</li>
			        <li><i class="bi bi-key"></i> Change Password</li>
			        <li>
			        <a href="login.html">
			        <i class="bi bi-box-arrow-right"></i>Logout
			        </a>  
			         </li>         
			    </ul>
			
			</div>
			
			<!-- Main Content -->
			
			<div class="main-content">
			
			    <!-- Welcome -->
			
			    <div class="welcome-card mb-4">
			
			        <h3>Welcome, <%=Studentname%> 👋</h3>
			
			        <p class="text-muted mb-0">
			            <%=department%> 
			        </p>
			
			    </div>
			
			    <!-- Statistics -->
			
			    <div class="row mb-4">
			
			        <div class="col-md-4 mb-3">
			            <div class="card stat-card">
			                <div class="card-body text-center">
			                    <i class="bi bi-calendar-check text-success"></i>
			                    <h5 class="mt-2">Attendance</h5>
			                    <h2><%=percentage %>%</h2>
			                </div>
			            </div>
			        </div>
			
			        <div class="col-md-4 mb-3">
			            <div class="card stat-card">
			                <div class="card-body text-center">
			                    <i class="bi bi-book text-primary"></i>
			                    <h5 class="mt-2">Courses</h5>
			                    <h2><%=department%> </h2>
			                </div>
			            </div>
			        </div>
			
			        <div class="col-md-4 mb-3">
			            <div class="card stat-card">
			                <div class="card-body text-center">
			                    <i class="bi bi-bell text-warning"></i>
			                    <h5 class="mt-2">Notices</h5>
			                    <h2><%=i%></h2>
			                </div>
			            </div>
			        </div>
			
			    </div>
			
			    <!-- Profile + Attendance -->
			
			    <div class="row">
			
			        <div class="col-lg-4 mb-4">
			
			            <div class="profile-card">
			
			                <h5 class="mb-3">My Profile</h5>
			
			                <hr>
			
			                <p><strong>ID:</strong> <%=id%> </p>
			                <p><strong>Name:</strong> <%=Studentname%> </p>
			                <p><strong>Email:</strong> <%=email%> </p>
			                <p><strong>Mobile:</strong> <%=mobile%> </p>
			                <p><strong>Department:</strong> <%=department%> </p>
			                <p><strong>Role:</strong> Student</p>
			
			            </div>
			
			        </div>
			
			        <div class="col-lg-8 mb-4">
			
			            <div class="attendance-card">
			
			                <h5 class="mb-3">Attendance History</h5>
			
			                <table class="table table-hover">
			
			                    <thead class="table-primary">
			                        <tr>
			                            <th>Date</th>
			                            <th>Status</th>
			                        </tr>
			                    </thead>
			
			                    <tbody>
		<%while(rs5.next()) {
		
		String status = rs5.getString(2);
		String s = null;
		if(status.equals("present"))
			{
				s="primary";
			}
		else
		{
			s="danger";
		}
		%>
			                        <tr>
			                            <td><%=rs5.getString(1) %></td>
			                            <td>
			                                <span class="badge bg-<%=s%>">
			                                    <%=status%>
			                                </span>
			                            </td>
			                        </tr>

			     <%} %>               </tbody>
			
			                </table>
			
			            </div>
			
			        </div>
			
			    </div>
			
			    <!-- Notices -->
			
			    <div class="notice-card">
			
			        <h5 class="mb-3">Recent Notices</h5>
			
			        <ul class="list-group">
			<%while(rs6.next()) 
			{%>
			            <li class="list-group-item">
			                <%=rs6.getString(4) %>
			            </li>
			<%} %>
			
			        </ul>
			
			    </div>
			
		
			
		</div>
<%
   con.close(); // connection बंद कर
} catch(Exception e) {
   e.printStackTrace();
}
%>
    

</body>
</html>