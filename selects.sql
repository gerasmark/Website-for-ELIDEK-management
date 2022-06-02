





--3.3
SELECT f.name, f.title, r.first_name, r.last_name  FROM fieldthatdescribes f
INNER JOIN project p ON f.title = p.title
INNER JOIN researcher r ON p.evaluated_from = r.id
WHERE r.works_since >= '2021-06-06'
AND p.end_date > '2022-06-06'
GROUP BY f.name;

--3.4
SELECT o1.name as organization_1,
       o2.name as organization_2
FROM organization o1
INNER JOIN project p1 ON o1.from_org = p1.name 
INNER JOIN project p2 ON COUNT(p1.from_org) = COUNT(p2.from_org)
INNER JOIN organization o2 ON p2.from_org = o2.name 
WHERE p1.start_date < (p2.start_date + '2-01-01')
AND p1.start_date > (p2.start_date - '2-01-01')
AND COUNT(p1.from_org) >= 20
AND COUNT(p2.from_org) >= 20;

--3.5
SELECT s1.name, s2.name
FROM scientific_field s1 
INNER JOIN fieldthatdescribes f1 ON s1.name = f1.name
INNER JOIN fieldthatdescribes f2 ON f1.title = f2.title
INNER JOIN scientific_field s2 ON f2.name = s2.name
GROUP BY s1.name, s2.name
SORT BY s1.name, s2.name
LIMIT 3;


--3.6
SELECT r.first_name, r.last_name, COUNT(w.id)
FROM researcher r
INNER JOIN worksfor w ON r.id = w.id
INNER JOIN project p ON w.title = p.title
WHERE r.age < 40 
AND p.end_date > '2022-06-06'
ORDER BY COUNT(w.id) DESC

--3.7
SELECT p.exec, c.name, SUM(p.amount)
FROM project p 
INNER JOIN organization o ON p.from_org = o.name
INNER JOIN company c ON o.name = c.name
GROUP BY p.exec
ORDER BY SUM(p.amount) DESC
LIMIT 5;

--3.8
SELECT r.first_name, r.last_name, COUNT(w.id) FROM researcher r
INNER JOIN worksfor w ON r.id = w.id
INNER JOIN project p ON w.title = p.title
WHERE COUNT(w.id) >= 5
AND p.title <> (SELECT d.title FROM deliverable d);