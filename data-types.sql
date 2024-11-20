CREATE DATABASE Just_a_collage;

CREATE TABLE students(
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    age TINYINT,
    enrollment_date DATE,
    is_active BOOLEAN
)
    
    