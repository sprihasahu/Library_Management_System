USE LibraTrack;

-- REQUIRED 1: Overdue books
SELECT i.Issue_ID, m.Full_Name, m.Phone, b.Title,
       i.Issue_Date, i.Due_Date,
       DATEDIFF(CURDATE(), i.Due_Date)        AS Days_Overdue,
       DATEDIFF(CURDATE(), i.Due_Date) * 5.00 AS Estimated_Fine
FROM Issues i
JOIN Members m ON i.Member_ID = m.Member_ID
JOIN Books b   ON i.Book_ID   = b.Book_ID
WHERE i.Return_Date IS NULL AND i.Due_Date < CURDATE()
ORDER BY Days_Overdue DESC;

-- REQUIRED 2: Most borrowed books
SELECT b.Book_ID, b.Title, COUNT(i.Issue_ID) AS Times_Borrowed
FROM Books b
LEFT JOIN Issues i ON b.Book_ID = i.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Times_Borrowed DESC, b.Title
LIMIT 5;

-- REQUIRED 3: Total fines per member (members with no fines show 0)
SELECT m.Member_ID, m.Full_Name,
       COUNT(f.Fine_ID)                  AS Fines_Count,
       COALESCE(SUM(f.Fine_Amount), 0)   AS Total_Fines,
       COALESCE(SUM(CASE WHEN f.Payment_Status = 'Unpaid'
                         THEN f.Fine_Amount END), 0) AS Unpaid_Fines
FROM Members m
LEFT JOIN Issues i ON m.Member_ID = i.Member_ID
LEFT JOIN Fines f  ON i.Issue_ID  = f.Issue_ID
GROUP BY m.Member_ID, m.Full_Name
ORDER BY Total_Fines DESC;

-- SUBQUERY: fines above the average fine
SELECT f.Fine_ID, f.Issue_ID, f.Fine_Amount
FROM Fines f
WHERE f.Fine_Amount > (SELECT AVG(Fine_Amount) FROM Fines)
ORDER BY f.Fine_Amount DESC;

-- SUBQUERY: members who currently hold an overdue book
SELECT Full_Name, Email
FROM Members
WHERE Member_ID IN (
    SELECT Member_ID FROM Issues
    WHERE Return_Date IS NULL AND Due_Date < CURDATE()
);

-- WINDOW: rank members by total fines
SELECT Full_Name, Total_Fines,
       RANK() OVER (ORDER BY Total_Fines DESC) AS Fine_Rank
FROM (
    SELECT m.Full_Name, COALESCE(SUM(f.Fine_Amount), 0) AS Total_Fines
    FROM Members m
    LEFT JOIN Issues i ON m.Member_ID = i.Member_ID
    LEFT JOIN Fines f  ON i.Issue_ID  = f.Issue_ID
    GROUP BY m.Member_ID, m.Full_Name
) AS member_fines;

-- WINDOW: running total of fines collected over time
SELECT Fine_ID, Fine_Date, Fine_Amount,
       SUM(Fine_Amount) OVER (ORDER BY Fine_Date, Fine_ID) AS Running_Total
FROM Fines;

-- WINDOW: most borrowed book in each genre
SELECT Genre, Title, Times_Borrowed
FROM (
    SELECT b.Genre, b.Title, COUNT(i.Issue_ID) AS Times_Borrowed,
           ROW_NUMBER() OVER (
               PARTITION BY b.Genre
               ORDER BY COUNT(i.Issue_ID) DESC, b.Title
           ) AS rn
    FROM Books b
    LEFT JOIN Issues i ON b.Book_ID = i.Book_ID
    GROUP BY b.Book_ID, b.Genre, b.Title
) AS ranked
WHERE rn = 1;

-- VIEWS
SELECT * FROM Issue_Details;
SELECT * FROM Overdue_Books;