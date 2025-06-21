create database flight;
use flight ;

-- AIRLINE TABLE
create table Airline(
airline_id serial primary key,
name varchar(50) not null,
country varchar(50)
);
insert into airline(name,country)
values
("Indigo","India"),
("Emirates","UAE"),
("Lufthansa","Germany");

-- Airport Table
CREATE TABLE Airport (
  airport_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  country VARCHAR(50)
);
insert into airport(name,city,country)
values
('Indira Gandhi International', 'Delhi', 'India'),
('Dubai International', 'Dubai', 'UAE'),
('Frankfurt Airport', 'Frankfurt', 'Germany');

-- Flight Table
CREATE TABLE Flight (
  flight_id SERIAL PRIMARY KEY,
  airline_id INT REFERENCES Airline(airline_id),
  departure_airport_id INT REFERENCES Airport(airport_id),
  arrival_airport_id INT REFERENCES Airport(airport_id),
  departure_time TIMESTAMP,
  arrival_time TIMESTAMP,
  status VARCHAR(20)
);
insert into flight(airline_id,departure_airport_id,arrival_airport_id,departure_time,arrival_time,status)
values
(1, 1, 2, '2025-07-01 08:00:00', '2025-07-01 10:30:00', 'Scheduled'), -- Delhi--Indigo--Dubai
(2, 2, 3, '2025-07-02 13:00:00', '2025-07-02 18:30:00', 'Scheduled'), -- Dubai-- Emirates-- Frankfurt
(3, 3, 1, '2025-07-03 09:45:00', '2025-07-03 20:15:00', 'Delayed');   -- Frankfurt-- Germany-- Delhi
-- Passenger Table
CREATE TABLE Passenger (
  passenger_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  email VARCHAR(100)
); 
insert into passenger(full_name,email)
values
("Sham","sham123@mail.com"),
("Sarah","sarah123@mail.com"),
("John","john123@mail.com");

-- Booking Table
CREATE TABLE Booking (
  booking_id SERIAL PRIMARY KEY,
  flight_id INT REFERENCES Flight(flight_id),
  passenger_id INT REFERENCES Passenger(passenger_id),
  seat_number VARCHAR(5),
  booking_time TIMESTAMP DEFAULT NOW()
); 
insert into booking(flight_id, passenger_id, seat_number, booking_time)
VALUES
(1, 1, '12A', NOW()), -- Sham-12A-Delhi-Dubai
(2, 2, '12B', NOW()), -- Sarah-12B-Dubai-Frankfurt
(3, 3, '14C', NOW()); -- John-14C-Frankfurt-Delhi

SELECT * FROM Airline;
SELECT * FROM Airport;
SELECT * FROM Booking;
SELECT * FROM flight;
SELECT * FROM passenger;
UPDATE Booking SET flight_id = 2 WHERE booking_id = 2;
UPDATE Booking SET flight_id = 3 WHERE booking_id = 3;

-- SQL QUERIES 

-- List of all passengers on specific flight 
SELECT 
  Passenger.passenger_id,
  Passenger.full_name,
  Booking.seat_number
FROM Booking
JOIN Passenger ON Booking.passenger_id = Passenger.passenger_id
WHERE Booking.flight_id = 3;

-- entire information from booking id 
SELECT 
  Booking.booking_id,
  Passenger.full_name,
  Flight.flight_id,
  Airport1.name as departure_airport,
  Airport2.name as arrival_airport,
  Flight.departure_time,
  Flight.arrival_time,
  Booking.seat_number
FROM Booking
JOIN Passenger ON Booking.passenger_id = Passenger.passenger_id
JOIN Flight ON Booking.flight_id = Flight.flight_id
JOIN Airport AS Airport1 ON Flight.departure_airport_id = Airport1.airport_id
JOIN Airport AS Airport2 ON Flight.arrival_airport_id = Airport2.airport_id
WHERE Booking.booking_id = 1;

-- find flights between 2 cities
SELECT 
  Flight.flight_id,
  Flight.departure_time,
  Flight.arrival_time,
  Airline.name AS airline
FROM Flight
JOIN Airport AS DepartureAirport ON Flight.departure_airport_id = DepartureAirport.airport_id
JOIN Airport AS ArrivalAirport ON Flight.arrival_airport_id = ArrivalAirport.airport_id
JOIN Airline ON Flight.airline_id = Airline.airline_id
WHERE DepartureAirport.city = 'Delhi' AND ArrivalAirport.city = 'Dubai'; 

-- passengers on delayed flight
SELECT 
  Passenger.full_name,
  Flight.flight_id,
  Flight.status
FROM Booking
JOIN Passenger ON Booking.passenger_id = Passenger.passenger_id
JOIN Flight ON Booking.flight_id = Flight.flight_id
WHERE Flight.status = 'Delayed';








