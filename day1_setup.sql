USE world;
SELECT * FROM city WHERE CountryCode='CHN' LIMIT 5;
CREATE DATABASE db_learning;
USE db_learning;
CREATE TABLE my_students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL COMMENT '学生姓名',
  score DECIMAL(5,2) CHECK (score BETWEEN 0 AND 100)
) ENGINE=InnoDB;
INSERT INTO my_students (name, score) VALUES 
('张三', 89.5),
('李四', 92.3),
('王五', 76.8);
-- 查询所有学生
SELECT * FROM my_students;
-- 查询90分以上学生
SELECT name, score FROM my_students WHERE score >= 90;
