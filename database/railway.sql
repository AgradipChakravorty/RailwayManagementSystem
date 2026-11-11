CREATE DATABASE IF NOT EXISTS railway_college_db;
USE railway_college_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
    phone VARCHAR(20),
    role ENUM('USER','ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    fare DECIMAL(10,2) NOT NULL
);

CREATE TABLE stations (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    train_id INT NOT NULL,
    journey_date DATE NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_age INT NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    status ENUM('CONFIRMED','CANCELLED') DEFAULT 'CONFIRMED',
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

CREATE TABLE cancellations (
    cancellation_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    cancelled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(255),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Sample train data for testing
INSERT INTO trains(train_name,source,destination,departure_time,arrival_time,total_seats,available_seats,fare)
VALUES
('Howrah Rajdhani','Kolkata','Delhi','16:50:00','10:00:00',100,100,1800.00),
('Duronto Express','Kolkata','Mumbai','08:20:00','21:30:00',80,80,1500.00),
('Shatabdi Express','Kolkata','Bhubaneswar','06:00:00','13:00:00',60,60,750.00);

-- After registering your account, make it admin using:
-- UPDATE users SET role='ADMIN' WHERE email='your-email@example.com';

-- Sample stations
INSERT INTO stations(station_name,city) VALUES
('Howrah Junction','Kolkata'),
('Sealdah','Kolkata'),
('New Delhi','Delhi'),
('Mumbai Central','Mumbai'),
('Bhubaneswar','Bhubaneswar');
