USE LibraTrack;

SELECT i.Issue_ID, m.Full_Name, b.Title, i.Issue_Date, i.Due_Date, i.Return_Date
FROM Issues i
JOIN Members m ON i.Member_ID = m.Member_ID
JOIN Books b   ON i.Book_ID   = b.Book_ID
ORDER BY i.Issue_Date;

SELECT b.Title, GROUP_CONCAT(a.Author_Name ORDER BY a.Author_Name SEPARATOR ', ') AS Authors
FROM Books b
JOIN Book_Authors ba ON b.Book_ID = ba.Book_ID
JOIN Authors a       ON ba.Author_ID = a.Author_ID
GROUP BY b.Book_ID, b.Title;

SELECT a.Author_Name, COUNT(ba.Book_ID) AS Books_In_Library
FROM Authors a
LEFT JOIN Book_Authors ba ON a.Author_ID = ba.Author_ID
GROUP BY a.Author_ID, a.Author_Name
ORDER BY Books_In_Library DESC;

SELECT b.Title
FROM Books b
LEFT JOIN Issues i ON b.Book_ID = i.Book_ID
WHERE i.Issue_ID IS NULL;

SELECT i.Issue_ID, m.Full_Name, b.Title, f.Fine_Amount, f.Payment_Status
FROM Fines f
JOIN Issues i  ON f.Issue_ID  = i.Issue_ID
JOIN Members m ON i.Member_ID = m.Member_ID
JOIN Books b   ON i.Book_ID   = b.Book_ID
ORDER BY f.Fine_Amount DESC;