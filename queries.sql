// Write an SQL query that gives below output.(Summary at segment level)

SELECT
  Segment,
  COUNT(DISTINCT ut.User_id) AS total_users,
  COUNT(DISTINCT CASE
    WHEN MONTH(bt.Booking_date) = 4 AND
      YEAR(bt.Booking_date) = 2022 AND
      bt.Line_of_business = 'Flight' THEN bt.User_id
    ELSE NULL
  END) AS User_who_booked_flight_in_apr2022
FROM user_table ut
LEFT JOIN booking_table bt
  ON ut.User_id = bt.User_id
GROUP BY Segment;


// Write a query to identify users whose first booking was a hotel booking.

SELECT
  User_id,
  Booking_id,
  Booking_date
FROM (SELECT
  *,
  RANK() OVER (PARTITION BY User_id ORDER BY Booking_date) AS rnk
FROM booking_table
WHERE Line_of_business = 'Hotel') AS ranking
WHERE rnk = 1;

// Write a query to calculate the days between first and last booking of each user.

SELECT User_id,
DATEDIFF(MAX(Booking_date), MIN(Booking_date))
FROM booking_table
GROUP BY User_id;

// Write a query to count the number of flights and hotel bookings in each of the users by the year 2022.

SELECT
  Segment,
  COUNT(CASE
    WHEN bt.Line_of_business = 'Flight' THEN bt.User_id
    ELSE NULL
  END) AS no_of_flights_bookings,
  COUNT(CASE
    WHEN bt.Line_of_business = 'Hotel' THEN bt.User_id
    ELSE NULL
  END) AS no_of_hotels_bookings
FROM user_table ut
JOIN booking_table bt
  ON ut.User_id = bt.User_id
GROUP BY Segment;
