<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


<style>
body{
    background:#f4f7fc;
    font-family:'Segoe UI',sans-serif;
}

.form-container{
    max-width:850px;
    margin:40px auto;
}

.card{
    border:none;
    border-radius:20px;
    box-shadow:0 8px 25px rgba(0,0,0,.08);
}

.card-header{
    background:blue;
    color:white;
    border-radius:20px 20px 0 0 !important;
    padding:20px;
}

.form-control,
.form-select{
    border-radius:10px;
    padding:12px;
}

.btn-update{
    
    color:white;
    border:none;
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

.btn-update:hover{
    
    color:white;
}
</style>
<meta charset="UTF-8">
<title>crud operations details</title>
</head>
<body>
<% 
String id = request.getParameter("id");
int flag = Integer.parseInt(request.getParameter("flag"));


String url = "jdbc:mysql://localhost:3306/demo";
String username = "root";
String password = "Pass@123";
try{
	PreparedStatement pst = null;
	ResultSet rs = null;
    String query = null;
	Connection con = null;
	con=DriverManager.getConnection(url,username,password);
if(flag==0)
{
		
	 	query = "delete from registration where id= ?";
		pst=con.prepareStatement(query);
		pst.setString(1,id);
		int rows = pst.executeUpdate();
		if(rows > 0)
		{
			response.sendRedirect("viewStudent.jsp");
		}
}
else
{
	PreparedStatement st = null;
	ResultSet rs1 = null;
	query = "select * from registration where id = ?";
	st=con.prepareStatement(query);
	st.setString(1,id);
	rs1 = st.executeQuery();
	String name = null;
	String email = null;
	String mobile = null;
	String department = null;
	
	while(rs1.next())
	{
		name = rs1.getString(2);
		email = rs1.getString(3);
		mobile = rs1.getString(4);
		department = rs1.getString(6);
	}
	
%>
	<div class="container py-5">

    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-lg border-0">

                <!-- Header -->
                <div class="card-header text-center bg-primary text-white py-4">
                    <i class="bi bi-person-lines-fill display-4"></i>
                    <h2 class="fw-bold mt-2 mb-1">Update Student</h2>
                    <p class="mb-0">Manage and update student details</p>
                </div>

                <!-- Body -->
                <div class="card-body p-5">

                    <form action="update.jsp" method="post">

                        <h5 class="text-primary mb-4">
                            <i class="bi bi-person-circle"></i>
                            Personal Information
                        </h5>

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-hash"></i>
                                    Student ID
                                </label>
                                <input type="text"
                                       name="id"
                                       class="form-control"
                                       value="<%=id%>"
                                       readonly>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-fill"></i>
                                    Full Name
                                </label>
                                <input type="text"
                                       name="name"
                                       class="form-control"
                                       value="<%=name%>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-envelope-fill"></i>
                                    Email Address
                                </label>
                                <input type="email"
                                       name="email"
                                       class="form-control"
                                       value="<%=email%>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-telephone-fill"></i>
                                    Mobile Number
                                </label>
                                <input type="text"
                                       name="mobile"
                                       class="form-control"
                                       value="<%=mobile%>">
                            </div>

                        </div>

                        <hr class="my-4">

                        <h5 class="text-primary mb-4">
                            <i class="bi bi-building"></i>
                            Additional Information
                        </h5>

                        <div class="row g-3">

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-calendar2-event"></i>
                                    Age
                                </label>
                                <input type="number"
                                       name="age"
                                       class="form-control">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-geo-alt-fill"></i>
                                    City
                                </label>
                                <input type="text"
                                       name="city"
                                       class="form-control">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-calendar-date-fill"></i>
                                    Date of Birth
                                </label>
                                <input type="date"
                                       name="dob"
                                       class="form-control">
                            </div>

                            <div class="col-md-12">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-diagram-3-fill"></i>
                                    Department
                                </label>
                                <input type="text"
                                       name="department"
                                       class="form-control"
                                       value="<%=department%>">
                            </div>

                        </div>

                        <div class="d-grid mt-5">
                            <button type="submit"
                                    class="btn btn-primary btn-lg">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                Update Student
                            </button>
                        </div>

                    </form>

                </div>

            </div>

        </div>
    </div>

</div>
	
<% 
}
}
catch(Exception e)
{
	out.print(e.getMessage());
}
%>
</body>
</html>