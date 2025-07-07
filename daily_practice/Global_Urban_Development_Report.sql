select * from city;
-- 直接使用 world 库中的 city/country 表
WITH city_stats AS (
   SELECT
      c.CountryCode,
      co.Name AS CountryName,
      co.Continent,
      COUNT(*) AS city_count,
      ROUND(AVG(c.Population)) AS avg_population,
      -- 修正：先在子查询中计算MAX人口，再在窗口函数中使用
      MAX(c.Population) AS max_population
   FROM world.city c
   JOIN world.country co ON c.CountryCode = co.Code
   WHERE co.Continent IN ('Asia', 'Europe', 'North America')
   GROUP BY c.CountryCode
)
-- 主查询：使用CTE并添加窗口函数
SELECT
   CountryCode,
   CountryName,
   Continent,
   city_count,
   avg_population,
   RANK() OVER (PARTITION BY Continent ORDER BY max_population DESC) AS max_pop_rank
FROM city_stats;
