-- 步骤1：在 world 库中创建学生表扩展字段
ALTER TABLE world.city ADD COLUMN student_ratio DECIMAL(5,2) COMMENT '学生占比';

-- 步骤2：修改关联逻辑（直接使用 world 数据）
SELECT 
  c.Name AS city_name,
  c.Population,
  FLOOR(c.Population * c.student_ratio / 100) AS estimated_students, -- 新增计算字段
  RANK() OVER (ORDER BY c.Population DESC) AS pop_rank
FROM world.city c
WHERE c.CountryCode = 'CHN'
  AND c.Population > 1000000;
