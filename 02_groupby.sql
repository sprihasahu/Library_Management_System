USE LibraTrack;

SELECT Genre, COUNT(*) AS Book_Count, SUM(Total_Copies) AS Total_Copies
FROM Books GROUP BY Genre ORDER BY Book_Count DESC;

SELECT City, COUNT(*) AS Member_Count
FROM Members GROUP BY City ORDER BY Member_Count DESC;

SELECT DATE_FORMAT(Issue_Date, '%Y-%m') AS Issue_Month, COUNT(*) AS Issues_Made
FROM Issues GROUP BY Issue_Month ORDER BY Issue_Month;

SELECT Payment_Status, COUNT(*) AS Fine_Count,
       SUM(Fine_Amount) AS Total_Amount, AVG(Fine_Amount) AS Avg_Amount
FROM Fines GROUP BY Payment_Status;

SELECT Member_ID, COUNT(*) AS Books_Borrowed
FROM Issues GROUP BY Member_ID
HAVING COUNT(*) >= 4
ORDER BY Books_Borrowed DESC;