USE LibraTrack;

SELECT * FROM Members;
SELECT * FROM Books;

SELECT Full_Name, City FROM Members
WHERE City = 'Kolkata' AND Status = 'Active';

SELECT Title, Publication_Year FROM Books
WHERE Genre = 'Fiction'
ORDER BY Publication_Year;

SELECT Title, Available_Copies FROM Books
WHERE Available_Copies = 0;

SELECT Title, Publication_Year FROM Books
WHERE Publication_Year < 1950;