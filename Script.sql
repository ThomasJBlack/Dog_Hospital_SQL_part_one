# Create a new schema
-- CREATE SCHEMA Thomas_Black
USE Thomas_Black;

# clear schema to prepare for script execution
DROP TABLE dr_table, dog_table, malady_table, breed_table, dr_certification_table;


# ___Table Structure___

# Create doctor table
CREATE TABLE dr_table (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100)
);

# Create dog table
CREATE TABLE dog_table  (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	malady_id VARCHAR(100),
	breed_id VARCHAR(100),
	dogs_doctor_id VARCHAR(100) # must be a doctor who has the certification for the malady
);

# Create malady table
CREATE TABLE malady_table (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	malady VARCHAR(100)
);

# Create breed table
CREATE TABLE breed_table (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	breed VARCHAR(100)
);

# Create doctor's certification table: doctors can have multiple certifications
CREATE TABLE dr_certification_table  (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	dr_id VARCHAR(100),
	malady_id VARCHAR(100)
);

# ___Table Initialization___


INSERT INTO dr_table
  ( name )
VALUES
  ('Dr. House'), 
  ('Dr. Watson'),
  ('Dr. Who'),
  ('Dr. Butters'),
  ('Dr. Jonathan Crane'),
  ('Dr. Blood');

INSERT INTO breed_table
  ( breed )
VALUES
  ('Temple Dog'), 
  ('Mixed Breed'),
  ('English Mastiff'),
  ('German Shepherd'),
  ('Bull Terrier'),
  ('Collie Mix'),
  ('Alaskan Malamute'),
  ('Golden Retriever'),
  ('Pug');

INSERT INTO malady_table
  ( malady )
VALUES
  ('Injured Pads'),
  ('Broken leg'),
  ('Throwing Up'),
  ('Hair Loss'),
  ('Rabies');


INSERT INTO dr_certification_table
  ( dr_id, malady_id )
VALUES
  ('1', '1'),
  ('2', '2'),
  ('3', '3'),
  ('4', '4'),
  ('5', '5'),
  ('6', '2');

INSERT INTO dog_table
  ( name, malady_id, breed_id, dogs_doctor_id )
VALUES
  ('Mouse', '2', '1', '4'), 
  ('Fang', '3', '2', '5'),
  ('Hercules', '5', '3', '2'),
  ('Samantha', '2', '5', '4'),
  ('Scud', '4', '6', '3'),
  ('Bingo', '1', '8', '1'),
  ('Buck', '2', '9', '4'),
  ('Chester', '4', '7', '6'),
  ('BUBBA', '4', '6', '3'),
  ('Gunner', '1', '5', '5');


# ___Queries___

# 1: Gives the doctor_id for a given doctor name
SELECT id FROM dr_table WHERE dr_table.name = 'Dr. Who'

# 2: Shows all dog names for a given doctor name
SELECT name FROM dog_table WHERE dog_table.dogs_doctor_id = '4'

# 3: Shows all dog names and maladies using a given doctor’s name
SELECT dog_table.name, malady_table.malady
FROM dog_table
INNER JOIN dr_table ON dog_table.dogs_doctor_id = dr_table.id AND dr_table.name = 'Dr. Who'
INNER JOIN malady_table ON dog_table.malady_id = malady_table.id

# 4: Shows all possible combinations of dog names and maladies 
# 	ignore the actual malady stored with each dog
SELECT 
    DISTINCT
    dog_table.name,
    malady_table.malady
FROM 
    dog_table,
    malady_table
