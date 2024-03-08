create database PetPals

create table Pets(
PetID int identity(1,1) primary key,
Name varchar(50),
Age int ,
Breed varchar(20),
Type varchar(10),
AvailableForAdoption BIT)

create table Shelters(
ShelterID int identity(1,1) primary key,
Name varchar(50),
Location varchar(50))

create table Donations(
DonationID int identity(100,1) primary key,
DonarName varchar(50),
Donation_type varchar(50),
Donation_Amount decimal,
Donation_Item varchar(50),
Donation_date datetime)

create table AdoptionEvents(
EventID int identity(50,1) primary key,
EventName varchar(50),
Eventdate datetime,
Location varchar(50))

create table Participants(
ParticipantID int identity(500,1) primary key,
ParticipantName varchar(50),
ParticipantType varchar(50),
EventID int,
foreign key (EventID) references AdoptionEvents(EventID))

-- Insert records into Pets table
Insert into Pets (Name, Age, Breed, Type, AvailableForAdoption)
values
('Buddy', 3, 'Golden Retriever', 'Dog', 1),
('Whiskers', 2, 'Siamese', 'Cat', 1),
('Rocky', 4, 'Labrador', 'Dog', 0),
('Fluffy', 1, 'Persian', 'Cat', 1),
('Max', 5, 'German Shepherd', 'Dog', 1)

-- Insert records into Shelters table
Insert into Shelters (Name, Location)
values
('Paws and Claws Shelter', '123 Main St, Anytown, USA'),
('Safe Haven Animal Rescue', '456 Elm St, Othertown, India'),
('Furry Friends Adoption Center', '789 Oak St, Anycity, France'),
('Second Chance Animal Shelter', '101 Maple St, Anothercity, Tokyo'),
('Hopeful Hearts Pet Sanctuary', '234 Pine St, Somewhere, China')

-- Insert records into Donations table
Insert into Donations (DonarName, Donation_Type, Donation_Amount, Donation_Item, Donation_Date)
values
('John Smith', 'Cash', 100.00, NULL, '2024-03-08 10:00:00'),
('Jane Doe', 'Item', NULL, 'Dog food', '2024-03-09 14:30:00'),
('David Johnson', 'Cash', 50.00, NULL, '2024-03-10 11:45:00'),
('Sarah Brown', 'Item', NULL, 'Cat toys', '2024-03-11 13:15:00'),
('Michael Wilson', 'Cash', 75.00, NULL, '2024-03-12 09:20:00')

-- Insert records into AdoptionEvents table
Insert into AdoptionEvents (EventName, EventDate, Location)
values
('Pet Adoption Day', '2024-04-15 12:00:00', 'City Park Pavilion'),
('Rescue Festival', '2024-05-20 11:00:00', 'Community Center'),
('Furry Friends Fundraiser', '2024-06-25 13:00:00', 'Convention Center'),
('Adopt-a-thon', '2024-07-30 10:00:00', 'Shopping Mall'),
('Stray Love Walk', '2024-08-05 09:30:00', 'Local Park')

-- Insert records into Participants table
Insert into Participants (ParticipantName, ParticipantType, EventID)
values
('Paws and Claws Shelter', 'Shelter', 50),
('Safe Haven Animal Rescue', 'Shelter', 51),
('John Smith', 'Adopter', 52),
('Jane Doe', 'Adopter', 53),
('David Johnson', 'Adopter', 54)

select* from Pets
select * from Shelters
select * from Donations
select * from AdoptionEvents
select * from Participants

--5)  Write an SQL query that retrieves a list of available pets (those marked as available for adoption) from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that the query filters out pets that are not available for adoption. 
select Name, Age,Breed,Type from Pets
where AvailableforAdoption =1

--6)Write an SQL query that retrieves the names of participants (shelters and adopters) registered for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query joins the necessary tables to retrieve the participant names and types.
select p.ParticipantName, p.ParticipantType
from Participants p
join AdoptionEvents ae on ae.EventID = p.EventID

--7) stored procedure 


--8)Write an SQL query that calculates and retrieves the total donation amount for each shelter (by shelter name) from the "Donations" table. The result should include the shelter name and the total donation amount. Ensure that the query handles cases where a shelter has received no donations. 
alter table Donations
add ShelterID int

alter table Donations
add constraint FK_Donations foreign key(ShelterID) references Shelters(ShelterID)

SELECT S.Name ,SUM(D.Donation_Amount) AS TotalDonationAmount
FROM Shelters S
LEFT JOIN Donations D ON S.ShelterID = D.ShelterID
GROUP BY S.Name;


--9)Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result set. 
select Name, Age, Breed, Type
from Pets  --becaue we dont have any onwer id in our database considering that no pets have onwership


--11)Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older than 5 years. 
Select distinct Breed
From Pets
where (Age BETWEEN 1 AND 3) OR (Age > 5);

--12)Retrieve a list of pets and their respective shelters where the pets are currently available for adoption. 
alter table Pets
add ShelterID int;

Alter table Pets
add constraint FK_Pets_Shelters FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

Select P.Name, P.Type, S.Name
from Pets P
INNER JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = 1;

--13)Find the total number of participants in events organized by shelters located in specific city. Example: City=Chennai
SELECT COUNT(p.ParticipantID) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents ae ON p.EventID = ae.EventID
JOIN Shelters s ON ae.Location = s.Location
WHERE s.Location = 'Chennai'

--14) Retrieve a list of unique breeds for pets with ages between 1 and 5 years. 
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

--15)Find the pets that have not been adopted by selecting their information from the 'Pet' table. 
 SELECT *
FROM Pets
WHERE AvailableForAdoption = 0;


--16) Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and 'User' tables. 
create table Users (
UserID int primary key,
Name varchar(50),
)

create table Adoption (
AdoptionID int primary key,
PetID INT,
UserID INT,
AdoptionDate DATE,
foreign key (PetID) references Pets(PetID),
foreign key (UserID) references Users(UserID)
)

Insert into Users (UserID, Name)
values
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'David Johnson'),
(4, 'Sarah Brown'),
(5, 'Michael Wilson')

Insert into Adoption (AdoptionID, PetID, UserID, AdoptionDate)
values
(1, 1, 1, '2024-01-15'),
(2, 2, 2, '2024-02-20'),
(3, 3, 3, '2024-03-25'),
(4, 4, 4, '2024-04-10'),
(5, 5, 5, '2024-05-05')
select p.Name, u.Name as [adopter name]
FROM Adoption a
JOIN Pets p ON a.PetID = p.PetID
JOIN Users u ON a.UserID = u.UserID
WHERE p.AvailableForAdoption = 1;

--17) Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter.

Select S.Name , count(P.PetID) as AvailablePetsCount
from Shelters S
LEFT JOIN Pets P on S.ShelterID = P.ShelterID
where P.AvailableForAdoption = 1
group by S.Name;

--18)Find pairs of pets from the same shelter that have the same breed.
Select p1.PetID , p1.Name
from Pets p1
JOIN Pets p2 on p1.ShelterID = p2.ShelterID and p1.Breed = p2.Breed
where p1.PetID < p2.PetID;


--19)List all possible combinations of shelters and adoption events. 
SELECT s.ShelterID, s.Name, ae.EventID, ae.EventName
FROM Shelters s
cross join AdoptionEvents ae;


--20) Determine the shelter that has the highest number of adopted pets. 
select top 1 S.ShelterID, S.Name, COUNT(A.AdoptionID) AS AdoptedPetsCount
from Shelters S
JOIN Pets P on S.ShelterID = P.ShelterID
JOIN Adoption A ON P.PetID = A.PetID
group by S.ShelterID, S.Name
order by ShelterID desc


