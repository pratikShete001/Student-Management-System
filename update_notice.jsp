<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
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
<title>Insert title here</title>
</head>
<body>
<%
String flag = request.getParameter("flag");
String id=request.getParameter("id");
session.setAttribute("notice_id", id);
if(flag.equals("1"))
{
	String url = "jdbc:mysql://localhost:3306/demo";
	String uname = "root";
	String pass = "Pass@123";

	String query = "SELECT * FROM notice where id=?";
	String from_date=null;
	String to_date=null;
	String department=null;
	String stud_id=null;
	String description=null;
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection(url, uname, pass);
	    PreparedStatement stat = con.prepareStatement(query);
	    stat.setString(1,id);
	    ResultSet rs = stat.executeQuery();
	    while(rs.next())
	    {
	    	from_date=rs.getString(2);
	    	to_date=rs.getString(3);
	    	description=rs.getString(4);
	    	department=rs.getString(5);
	    	stud_id=rs.getString(6);
	    }
	    %>
	    
    <div class="card mb-4">

        <div class="header">
            <h3>Publish Notice</h3>
        </div>

        <div class="card-body">

            <form action="notice_update_query.jsp" method="post">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label>From Date</label>
                        <input type="date"
                               name="from_date"
                               class="form-control"
                               value=<%=from_date %>
                               required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>To Date</label>
                        <input type="date"
                               name="to_date"
                               class="form-control"
                               value=<%=to_date %>
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
                    <select 
                    class="form-select" name = "department">
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
                        value=<%=description %>
                        class="form-control"
                        required>
                    

                </div>

                <button type="submit"
                
                        class="btn btn-warning">
                    Update
                </button>

            </form>

        </div>

    </div>
	  <%
	}catch(Exception e)
	{
		out.print(e.getMessage());
	}
}
%>
</body>
</html>