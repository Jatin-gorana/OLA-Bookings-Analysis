Create database Ola;
Use Ola;

show tables;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bookings.csv'
INTO TABLE ola.bookings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type, 
 Pickup_Location, Drop_Location, V_TAT, C_TAT, 
 Canceled_Rides_by_Customer, Canceled_Rides_by_Driver, Incomplete_Rides, 
 Incomplete_Rides_Reason, Booking_Value, Payment_Method, 
 Ride_Distance, Driver_Ratings, Customer_Rating, `Vehicle Images`);

-- /////////////////////////////////////////////////////////////////// 
Create view Successful_Bookings as
select * from bookings
where Booking_Status = 'Success';

select * from Successful_Bookings;

-- //////////////////////////////////////////////////////////////////
Create view AVGRideDist_PerVehicle as
select Vehicle_Type, avg(Ride_Distance)
from bookings
group by Vehicle_Type; 

select * from AVGRideDist_PerVehicle;

-- /////////////////////////////////////////////////////////////////
create View RidesCanceledbyCustomer as
select count(*) 
from bookings
where Booking_Status = 'Canceled by Customer'; 

select * from RidesCanceledByCustomer;

-- /////////////////////////////////////////////////////////////////
create view top5C_WithHighestBookings as
select Customer_ID, count(Booking_ID) as total_bookings
from bookings
group by Customer_ID
order by total_bookings desc limit 5; 

select * from top5C_WithHighestBookings;

-- ////////////////////////////////////////////////////////////////
create view CanceledbyDriver_P_C_issues as
select count(*)
from bookings
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

select * from CanceledbyDriver_P_C_issues;

-- //////////////////////////////////////////////////////////////
create view MaxMinDriverRatings as
select max(Driver_Ratings) as Max_Driver_Rating, min(Driver_Ratings) as Min_Driver_Rating
from bookings
where Vehicle_Type = 'Prime Sedan';

select * from MaxMinDriverRatings;

-- ////////////////////////////////////////////////////////////
create view BookingwithUPI as
select * from bookings where payment_method = 'UPI'; 

select * from BookingwithUPI;

-- ////////////////////////////////////////////////////////////
create view AVGCustRatPerVehicleType as
select vehicle_type, avg(Customer_Rating)
from bookings
group by vehicle_type;

select * from AVGCustRatPerVehicleType;

-- ////////////////////////////////////////////////////////////
create view TotalSuccessfulRideValue as
select sum(Booking_Value)
from bookings
where Incomplete_Rides = 'No'; 

select * from TotalSuccessfulRideValue;

-- ///////////////////////////////////////////////////////////
create view IncompleteRideswithReason as
select Booking_id, Incomplete_Rides_reason
from bookings
where Incomplete_Rides = 'Yes';

select * from IncompleteRideswithReason;
 
 

