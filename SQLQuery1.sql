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


