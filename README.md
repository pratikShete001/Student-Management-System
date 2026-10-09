# 🎓 Student Management Portal

A web-based University Management Portal developed using Java, JSP, MySQL, HTML, CSS, and Bootstrap. The application provides a centralized platform for managing student information, attendance, notices, and leave requests.

## 📌 Project Overview

The Student Management Portal simplifies common university administration tasks through separate interfaces for administrators and students.

Administrators can manage student-related information, publish notices, monitor attendance, and handle leave requests. Students can access their dashboards, view attendance information, read notices, and manage leave requests.

## ✨ Features

### 👨‍💼 Admin Module
- Admin login and dashboard.
- Manage student information.
- View student records.
- Publish and update notices.
- Publish department-specific notices.
- Send notices to specific students.
- Monitor student attendance.
- View and manage student leave requests.
- Access department-related information.

### 👨‍🎓 Student Module
- Student login and dashboard.
- View personal profile information.
- Check attendance percentage.
- View attendance history.
- Read department notices.
- Receive notices targeted to specific students.
- Submit leave requests.
- Track leave request status.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application logic |
| JSP (JavaServer Pages) | Dynamic web pages |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML5 | Web page structure |
| CSS3 | Styling |
| Bootstrap 5 | Responsive user interface |
| Apache Tomcat | Web application server |
| Eclipse IDE | Development environment |

## 🗄️ Database Structure

The application uses a MySQL database named `demo`.

### Main Tables

**1. registration**
- Student and administrator details.
- Name, email, mobile number, role, department, and password.

**2. attendance**
- Student attendance records.
- Attendance date and status.

**3. notice**
- Notice start and expiry dates.
- Notice description and department.
- Optional student ID for student-specific notices.

**4. leave_request**
- Leave reason.
- Leave start and end dates.
- Leave request status.

## ⚙️ Installation and Setup

### Prerequisites

Install the following software:

- Java JDK
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 10.1
- MySQL Server
- MySQL Connector/J

### Step 1: Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
