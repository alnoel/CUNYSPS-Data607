CREATE DATABASE IF NOT EXISTS movieratings;
USE movieratings; 

CREATE TABLE movies
(movieid INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
title VARCHAR(255) NOT NULL,
length INT NOT NULL, 
prodcompany VARCHAR(255) NOT NULL,
releasedateus date
);

CREATE TABLE reviews (
    reviewid INT NOT NULL,
    reviewer_name VARCHAR(255),
    movieid INT,
    rating INT,
    FOREIGN KEY (movieid)
        REFERENCES movies (movieid)
);

INSERT INTO 
	movies(title, length, prodcompany, releasedateus)
VALUES
  ('Wonder Woman 1984',151,'DC Films','2020-12-25'),
  ('News of the World',118,'Universal','2020-12-25'),
  ('The Little Things',128,'Warner Brothers','2021-01-29'),
  ('Judas and the Black Messiah',126,'Bron Creative','2021-02-01'),
  ('Black Widow',134,'Marvel Studios','2021-06-29'),
  ('Nomad',108,'Highwayman Films','2021-02-19');
  
  INSERT INTO
	reviews(reviewid, reviewer_name, movieid, rating) 
  VALUES
	(3,'Susan', 1, 3),
	(4,'Leo',2,2),
	(5,'Bubba',1,3),
	(6,'Angela',1,1),
	(7,'Joe',2,5),
	(8,'Susan',2,2),
	(9,'Leo',3,NULL),
	(10,'Bubba',2,1),
	(11,'Angela',2,4),
	(12,'Joe',3,NULL),
	(13,'Leo',4,2),
	(14,'Susan',3,NULL),
	(15,'Bubba',3,NULL),
	(16,'Angela',3,2),
	(17,'Joe',4,2),
	(18,'Leo',5,3),
	(19,'Susan',5,1),
	(20,'Bubba',4,3),
	(21,'Angela',4,3),
	(22,'Joe',5,1),
	(23,'Leo',6,2),
	(24,'Susan',6,NULL),
	(25,'Bubba',5,4),
	(26,'Angela',5,2),
	(27,'Joe',6,1),
	(28,'Carl',3,1),
	(29,'Linda',6,3),
	(30,'Bunny',6,3);
  
   
 # Join the tables reviews and movies
 # "flattening" them into one set of
 # rectangular format
 # This SQL code could likely be placed in a scheduled job to produce 
 # output on a regular basis
  DROP TABLE IF EXISTS flatten; 
  CREATE TABLE flatten AS
  SELECT r.reviewid , r.reviewer_name, IFNULL(r.rating,'NA') AS rating, m.title,
		  m.movieid, m.prodcompany,  m.length, m.releasedateus
  FROM reviews r JOIN movies m ON 
  r.movieid = m.movieid
  ORDER BY m.title;
  
   # Add header row to flattened table
   # and place the result into a csv file outside the DBMS 
   
   (SELECT 'reviewid','reviewer_name','rating', 'title','movieid','prodcompany','length', 'releasedateus' )
	UNION 
   SELECT * 
   FROM flatten  INTO OUTFILE 'C:/CUNY/DATA607/Week02/Assignment/moviereviews.csv' 
   FIELDS TERMINATED BY ',';  
  
  
   DROP TABLE IF EXISTS flatten; 
  
 # SQL code shows 6 nulls in rating column
 #  R should find 6 and fix that with some sort of imputation
SELECT  COUNT(*)
FROM reviews
WHERE rating IS NULL

 