--Notes

INSERT INTO Employee (employee_id, first_name, last_name, department, hired_date)
VALUES ('21', 'Dana', 'Diedrich', 'Engineering', '2023-10-01');

-- Sort by Column # (birhth_year)
SELECT first_name, last_name, birth_year
FROM Authors
ORDER BY 3
