-- Beginner Exercises
CREATE DATABASE clinic;
USE clinic;

CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    gender VARCHAR(10),
    diagnosis VARCHAR(50),
    bill_amount DECIMAL(10,2),
    visits INT
);

INSERT INTO patients VALUES
(1, 'Yasmine', 28, 'Rabat', 'Female', 'Diabetes', 1500, 3),
(2, 'Omar', 45, 'Casablanca', 'Male', 'Hypertension', 2200, 5),
(3, 'Sara', 32, 'Rabat', 'Female', 'Asthma', 1800, 2),
(4, 'Khalid', 55, 'Fes', 'Male', 'Diabetes', 3100, 7),
(5, 'Imane', 24, 'Marrakech', 'Female', 'Asthma', 900, 1),
(6, 'Hamza', 38, 'Casablanca', 'Male', 'Hypertension', 2800, 4),
(7, 'Lina', 29, 'Rabat', 'Female', 'Diabetes', 1600, 3),
(8, 'Youssef', 61, 'Fes', 'Male', 'Hypertension', 3500, 8),
(9, 'Nour', 35, 'Casablanca', 'Female', 'Asthma', 1200, 2),
(10, 'Tariq', 42, 'Rabat', 'Male', 'Diabetes', 2100, 4);