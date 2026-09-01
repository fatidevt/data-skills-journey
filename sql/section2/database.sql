CREATE DATABASE hospital;
USE hospital;

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(50),
    specialty VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_name VARCHAR(50),
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO doctors VALUES
(1, 'Dr. Amrani', 'Cardiology', 'Casablanca'),
(2, 'Dr. Benali', 'Dermatology', 'Rabat'),
(3, 'Dr. Chraibi', 'Pediatrics', 'Fes'),
(4, 'Dr. Darouri', 'Neurology', 'Rabat'),
(5, 'Dr. El Fassi', 'Cardiology', 'Marrakech');

INSERT INTO appointments VALUES
(1, 1, 'Yasmine', 800, 'completed'),
(2, 1, 'Omar', 1200, 'completed'),
(3, 2, 'Sara', 600, 'cancelled'),
(4, 3, 'Khalid', 950, 'completed'),
(5, 3, 'Imane', 750, 'completed'),
(6, 4, 'Hamza', 1100, 'completed'),
(7, NULL, 'Lina', 500, 'completed');