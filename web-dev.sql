CREATE DATABASE web_dev_portfolio;

CREATE TABLE users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(20) UNIQUE NOT NULL,
	email VARCHAR(75) UNIQUE NOT NULL,
	password_hash VARCHAR(50) NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	profile_image VARCHAR(75),
    bio VARCHAR(100),
    location VARCHAR(75),
	created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Skills Table
CREATE TABLE skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    category ENUM('Frontend', 'Backend', 'DevOps', 'Design', 'Other') NOT NULL,
    icon VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category)
);

-- Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    thumbnail VARCHAR(255),
    github_url VARCHAR(255),
    live_url VARCHAR(255),
    start_date DATE,
    end_date DATE,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user_projects (user_id, is_featured)
);


-- Project_Skills Junction Table
CREATE TABLE project_skills (
    project_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    skill_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY unique_project_skill (project_id, skill_id)
);

-- User_Skills Junction Table
CREATE TABLE user_skills (
    user_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_skill (user_id, skill_id)
);

-- Education Table
CREATE TABLE education (
    education_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    institution VARCHAR(100) NOT NULL,
    degree VARCHAR(100) NOT NULL,
    field_of_study VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user_education (user_id)
);

-- Experience Table
CREATE TABLE experience (
    experience_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    company VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    description TEXT,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user_experience (user_id, is_current)
);

-- Project_Images Table
CREATE TABLE project_images (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    caption TEXT,
    display_order INT NOT NULL DEFAULT 0,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    INDEX idx_project_images (project_id, display_order)
);

-- Certifications Table
CREATE TABLE certifications (
    certification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    issuing_organization VARCHAR(100) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE,
    credential_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user_certs (user_id)
);

-- Social_Links Table
CREATE TABLE social_links (
    link_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    platform ENUM('GitHub', 'LinkedIn', 'Twitter', 'Instagram', 'Other') NOT NULL,
    url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    UNIQUE KEY unique_user_platform (user_id, platform)
);

SELECT
	p.title AS project_title,
    p.description,
	GROUP_CONCAT (s.name) AS skills_used
FROM projects p
INNER JOIN project_skills ps ON p.project_id = ps.project_id
INNER JOIN skills s on ps.skill_id = s.skill_id
GROUP BY p.project_id
ORDER BY p.title;

