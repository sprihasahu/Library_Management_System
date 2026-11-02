USE LibraTrack;

CREATE INDEX idx_books_genre      ON Books(Genre);
CREATE INDEX idx_issues_issue_dt  ON Issues(Issue_Date);
CREATE INDEX idx_issues_overdue   ON Issues(Return_Date, Due_Date);
CREATE INDEX idx_fines_status     ON Fines(Payment_Status);

CREATE OR REPLACE VIEW Issue_Details AS
SELECT
    i.Issue_ID,
    m.Full_Name AS Member_Name,
    b.Title     AS Book_Title,
    i.Issue_Date,
    i.Due_Date,
    i.Return_Date,
    CASE
        WHEN i.Return_Date IS NOT NULL THEN 'Returned'
        WHEN i.Due_Date < CURDATE()    THEN 'Overdue'
        ELSE 'Issued'
    END AS Issue_Status,
    COALESCE(f.Fine_Amount, 0) AS Fine_Amount
FROM Issues i
JOIN Members m ON i.Member_ID = m.Member_ID
JOIN Books b   ON i.Book_ID   = b.Book_ID
LEFT JOIN Fines f ON i.Issue_ID = f.Issue_ID;

CREATE OR REPLACE VIEW Overdue_Books AS
SELECT
    i.Issue_ID,
    m.Full_Name AS Member_Name,
    m.Phone,
    b.Title     AS Book_Title,
    i.Issue_Date,
    i.Due_Date,
    DATEDIFF(CURDATE(), i.Due_Date)        AS Days_Overdue,
    DATEDIFF(CURDATE(), i.Due_Date) * 5.00 AS Estimated_Fine
FROM Issues i
JOIN Members m ON i.Member_ID = m.Member_ID
JOIN Books b   ON i.Book_ID   = b.Book_ID
WHERE i.Return_Date IS NULL AND i.Due_Date < CURDATE();