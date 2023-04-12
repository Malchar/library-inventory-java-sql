-- ICS 311 Project Step #4
-- Paul Schmitz 4/19/2022

drop database library_inventory_system;
create database library_inventory_system;
use library_inventory_system;
create table client(
	clientId int primary key,
    clientName varchar(255)
);
create table employee(
	employeeId int primary key,
    employeeName varchar(255),
    employeeRole enum("Admin", "Manager", "Default")
);
create table login(
	loginEmail varchar(255) primary key,
    loginPassword varchar(255),
    clientId int,
    employeeId int,
    foreign key (clientId) references client (clientId),
    foreign key (employeeId) references employee (employeeId)
);
create table category(
	categoryId int primary key,
    categoryParent int,
    categoryName varchar(255),
    categoryDescription varchar(255),
    foreign key (categoryParent) references category (categoryId)
);
create table book(
	bookId int primary key,
    categoryId int,
    bookAuthor varchar(255),
    bookTitle varchar(255),
    bookISBN varchar(13),
    bookDescription varchar(255),
    bookInPrint bool,
    foreign key (categoryId) references category (categoryId)
);
create table inventory(
	inventoryId int primary key,
    bookId int,
    inventoryAvailable bool,
    inventoryCondition enum("New", "Fine", "Damaged"),
    foreign key (bookId) references book (bookId)
);
create table checkout(
	checkoutId int primary key,
    checkoutDue date,
    checkoutReturned date,
    clientId int,
    inventoryId int,
    foreign key (clientId) references client (clientId),
    foreign key (inventoryId) references inventory (inventoryId)
);

insert into client values
    (1, "Jane Doe"),
    (2, "John Doe"),
    (3, "Bill Gates"),
    (4, "Kamala Harris"),
    (5, "Ada Lovelace"),
    (6, "Barack Obama"),
    (7, "Paul Schmitz"),
    (8, "George Washington");
insert into employee values
	(1, "Paul Schmitz", "Admin"),
    (2, "Ada Lovelace", "Manager"),
    (3, "Barack Obama", "Default"),
    (4, "Vin Diesel", "Default"),
    (5, "Tom Hanks", "Default");
insert into login values
	("paul_s@gmail.com", "12345", 7, 1),
    ("ada_l@hotmail.com", "pass", 5, 2),
    ("bill_g@microsoft.com", "password1", 3, null),
    ("barack_o@hotmail.com", "pres", 6, null),
    ("barack_obama@whitehouse.com", "pres", null, 3),
    ("kamala_h@gmail.com", "veep", 4, null),
    ("vin_d@fastandfurious.com", "1234", null, 4);
insert into category values
	(1, null, "fiction", null),
    (2, null, "non-fiction", null),
    (3, 1, "science fiction", "Speculative fiction which typically deals with imaginative and futuristic concepts."),
    (4, 1, "horror", "Speculative fiction which is intended to frighten, scare, or disgust."),
    (5, 1, "romance", "Fiction which places its primary focus on the relationship and romantic love between two people, and usually has an emotionally satisfying and optimistic ending."),
    (6, 2, "technology", "Guides for the novice nerd, tips and assistance for the student designer, or describe the story of a computer genius for technological inspiration."),
    (7, 2, "history", "Past events as well as the memory, discovery, collection, organization, presentation, and interpretation of these events."),
    (8, 7, "african history", null);
insert into book values
	(1, 8, "Nelson Mandela", "Long Walk to Freedom", "0316874965", "An autobiography ghostwritten by Richard Stengel. The book profiles his early life, coming of age, education and 27 years spent in prison.", true),
    (2, 8, "Mark Bowden", "Black Hawk Down", "9780871137388", "Documents efforts by the Unified Task Force to capture Somali faction leader Mohamed Farrah Aidid in 1993, and the resulting battle in Mogadishu between United States forces and Aidid's militia.", true),
    (3, 6, "Peter Thiel", "Zero to One", "9780804139298", "Condensed and updated version of a highly popular set of online notes taken by Masters for the CS183 class on startups, as taught by Thiel at Stanford University in Spring 2012.", true),
    (4, 6, "Kevin Kelly", "The Inevitable", "9780525428084", "Forecasts the twelve technological forces that will shape the next thirty years.", true),
    (5, 4, "Gillian Flynn", "Gone Girl", "9780307588364", "The sense of suspense in the novel comes from whether or not Nick Dunne is involved in the disappearance of his wife Amy.", true),
    (6, 3, "George Orwell", "1984", "9780452284234", "Thematically, it centres on the consequences of totalitarianism, mass surveillance and repressive regimentation of people and behaviours within society.", true),
    (7, 3, "Andy Weir", "The Martian", "9780804139021", "The story follows an American astronaut, Mark Watney, as he becomes stranded alone on Mars in 2035 and must improvise in order to survive.", true);
insert into inventory values
	(1, 1, true, "New"),
    (2, 1, true, "Fine"),
    (3, 2, false, "Fine"),
    (4, 2, true, "Damaged"),
    (5, 3, true, "New"),
    (6, 5, true, "New"),
    (7, 6, true, "Fine"),
    (8, 7, true, "Damaged"),
    (9, 7, false, "Damaged");
insert into checkout values
	(1, "2022-03-31", "2022-03-05", 1, 2), -- long walk to freedom
    (2, "2022-03-25", "2022-03-31", 2, 3), -- black hawk down, overdue
    (3, "2022-03-14", null, 3, 2), -- long walk to freedom, overdue
    (4, "2022-05-18", null, 1, 1), -- long walk to freedom
    (5, "2022-05-30", null, 4, 5), -- zero to one
    (6, "2022-05-30", null, 5, 6), -- gone girl
    (7, "2022-03-24", null, 6, 2), -- long walk to freedom, overdue
    (8, "2022-03-31", "2022-04-01", 4, 6), -- gone girl, overdue
    (9, "2022-06-01", null, 4, 6); -- gone girl
