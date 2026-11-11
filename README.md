# Railway Management System

A 5th-semester B.Tech CSE college project using Java, JSP, Servlets, JDBC and MySQL.

## Requirements
- JDK 17
- Apache Maven
- MySQL 8
- Apache Tomcat 10.1
- IntelliJ IDEA (or Eclipse)

## 1. Database setup
1. Open MySQL Workbench.
2. Open `database/railway.sql`.
3. Run the complete SQL script.
4. Open `src/main/java/com/railway/util/DBConnection.java`.
5. Change `YOUR_MYSQL_PASSWORD` to your local MySQL password.

## 2. Run the project
1. Open the project folder in IntelliJ IDEA as a Maven project.
2. Wait for Maven dependencies to download.
3. Build using `mvn clean package`.
4. Deploy `target/RailwayManagementSystem.war` on Tomcat 10.1.
5. Open `http://localhost:8080/RailwayManagementSystem/`.

## 3. Create an admin
1. Register normally from the website.
2. Run this query in MySQL Workbench (replace the email):
   `UPDATE users SET role='ADMIN' WHERE email='your-email@example.com';`
3. Log out and log in again. The admin menu will appear.

## 4. Modules included
- Authentication: registration, login, logout and session handling.
- Train booking: search trains, passenger details and booking confirmation.
- Cancellation: booking history, booking-ID search, cancellation and seat restoration.
- Admin: dashboard, users, bookings and cancellation records.
- Train management: add, view, update and delete trains; station management.

## 5. Team Git workflow
Each member should create a separate branch:
- `feature/authentication`
- `feature/booking`
- `feature/cancellation`
- `feature/admin`
- `feature/train-management`

Do not edit shared database/configuration files independently. Discuss shared changes before merging.

## Notes
- This is an academic demonstration project, not a production railway reservation platform.
- Seat availability is maintained at train level in this basic version, not separately for every journey date.
- Passwords are SHA-256 hashed for this academic implementation. A production system should use a password-specific hashing algorithm such as BCrypt or Argon2.
- Train deletion can be blocked by MySQL if bookings already reference that train. This protects booking history.
- Tomcat 10.1 uses `jakarta.servlet` imports. Do not deploy this version on Tomcat 9.
