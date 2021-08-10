----------UC1->Creating Database-------------
create database AddressBookSystem;

-------------UC2->Create table------------------
create table Address_Book_Table
(
FirstName varchar(100),
SecondName varchar(100),
Address varchar(250),
City varchar(100),
State varchar(100),
zip BigInt,
PhoneNumber BigInt,
Email varchar(200)
)

------ UC 3->Insert Values to Table ------
Insert into Address_Book_Table(FirstName,SecondName,Address,City,State,zip,PhoneNumber,Email) 
values('Arun','Kumar','T-Nagar','Chennai','TamilNadu',600068,1234567899,'arun@gmail.com'),
('Vignesh','A','ramapuram','Chennai','TamilNadu',600066,2345678991,'vig123@gamil.com'),
('Sam','M','CMBT','	Chennai','TamilNadu',600032,2345678911,'sam@gmail.com');

-------------UC4---->edit existing contact person using person name----------

update Address_Book_Table set PhoneNumber=7845712874 where FirstName='Sam';

--------UC5---->Delete a contact using perosn name-----

delete from Address_Book_Table where FirstName='Sam' and SecondName='M';

---------UC6---->Retrieve data belongs to state or city--------

Select * from Address_Book_Table where City='Chennai' or State='TamilNadu';

-----------UC7---->Count of state and city--------
Select Count(*) As Count,State,City from Address_Book_Table group by State,City;

---------UC8---->Sort the name alphabetically using city name--------

select * from Address_Book_Table where City='Chennai' order by FirstName;

----------UC9---->Add the new columns and adding the address book name and type-----------
alter table Address_Book_Table
add AddressBookName varchar(50),RelationType varchar(50);

update Address_Book_Table set AddressBookName='Friends',RelationType='Friend' where FirstName='Arun' ;

update Address_Book_Table set AddressBookName ='Family',RelationType ='Cousin' where zip=600066;

---------UC10---->Count of persons based on realtion type-----
Select count(*)as CountType, RelationType  from Address_Book_Table group by RelationType;

----------UC11----->Insert into tables For each Type--------
Insert into Address_Book_Table(FirstName,SecondName,Address,City,State,zip,PhoneNumber,Email,AddressBookName,RelationType) 
values('Vijai','Kumar','T-Nagar','Bengaluru','Karnataka',620068,1234567809,'Vijai@gmail.com','Friends','Friend'),
('Surya','A','KK-Nagar','Bengaluru','Karnataka',620066,2345678091,'Surya123@gamil.com','Family','Cousin');

--------------------------UC12-ER Diagram----------------
CREATE TABLE Contact
(
    FirstName VARCHAR(100) NOT NULL,
    LastName varchar(100) not null,
    Address varchar(250) not null,
    City varchar(100) not null,
    State varchar(100) not null,
    Zip BigInt not null,
    PhoneNumber varchar(200) not null
);
INSERT into Contact
VALUES
('Arun','Kumar','T-Nagar','Chennai','TamilNadu',600068,1234567899),
('Vignesh','A','ramapuram','Chennai','TamilNadu',600066,2345678991),
('Vijai','Kumar','T-Nagar','Bengaluru','Karnataka',620068,1234567809),
('Surya','A','KK-Nagar','Bengaluru','Karnataka',620066,2345678091);


create table Contact_Type
(
    FirstName varchar(100) not null,
    RelationType varchar(50) not null
);

INSERT into Contact_Type
VALUES
(
    'Arun','Friend'
),
(
    'Vignesh','Cousin'
),
(
    'Vijai','Friend'
),
(
    'Surya','Cousin'
);


CREATE TABLE Contact_BookName
(
    FirstName VARCHAR(100) NOT NULL,
    AddressBookName VARCHAR(50) NOT NULL
)
INSERT into Contact_BookName
VALUES
(
    'Arun','Friends'
),
(
    'Vignesh','Family'
),
(
    'Vijai','Friends'
),
(
    'Surya','Family'
);


Select * from AddressBookTable;
Select * from Contact;
Select * from Contact_Type;
Select * From Contact_BookName;

--------------------------UC13-Aggregate Function On Multiple Tables--------------------------

SELECT * FROM contact INNER JOIN Contact_Type type 
on contact.FirstName = type.FirstName;

--Count Contact By Type
select  type.RelationType,COUNT(contact.FirstName) as Total_Count
FROM contact INNER JOIN contact_type type 
ON contact.FirstName = type.FirstName
GROUP BY type.RelationType;

-----------------------------
alter table Contact add
AddedDate DATE NOT NULL default GETDATE();

------------------------------------------

CREATE PROCEDURE spAddContact  
(  
@FirstName varchar(100),
@LastName varchar(100),
@Address varchar(250),
@City varchar(100),
@State varchar(100),
@Zip BigInt,
@PhoneNumber BigInt,
@Email varchar(200),
@AddressBookName VARCHAR(50),
@RelationType varchar(50)
)  
as  
begin  
        insert into AddressBookTable values(@FirstName,@LastName,@Address,@City,@State,@Zip,@PhoneNumber,@Email,@AddressBookName,@RelationType)
		insert into Contact values(@FirstName,@LastName,@Address,@City,@State,@Zip,@PhoneNumber,GETDATE())
        insert into Contact_Type values(@FirstName,@RelationType)
        insert into Contact_BookName values(@FirstName,@AddressBookName)  
end 