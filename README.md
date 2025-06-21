# flight_booking_sql
Created flight database with tables airline,airport,flight,passenger and booking
Table airline stores airline id, name of airline and country it belongs to.
Table airport stores airport id, name of airport, city and country where its located.
Table flight stores flight id, airline id referring from table airline, deaprture and arrival airport id referring from table airport, departure time,arrival time and status of the flight.
Table passenger stores id,name,email of the passenger.
Table booking stores booking id, flight id, passenger id, seat number and booking time.
Inserted 3 dummy values in the table.
Wrote 3 sample Sql queries:
1- List of all passengers on given flight id by joining booking and passenger tables.
2- Complete booking details for a given booking id including passenger name,flight information,seat number and departure/arrival airports.
3- Finds all flights between two given cities by matching departure and arrival airport cities and includes flight times and airline name.
4- Lists passengers booked on delayed flights, including their names and the corresponding flight IDs.
