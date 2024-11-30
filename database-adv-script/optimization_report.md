# Query Optimization Report

## Objective:

To improve the performance of the query that retrieves all bookings along with user details, property details, and payment details. The goal is to refactor the query by identifying inefficiencies and reducing execution time.

### Step 1: Analyze the Initial Query

We begin by reviewing the initial query that joins the `Booking`, `User`, `Property`, and `Payment` tables. The query is designed to retrieve booking details along with the associated user and property information, as well as payment data.

#### Performance Analysis Using EXPLAIN:

Upon running the `EXPLAIN ANALYZE` command, we observed the following inefficiencies:

1. **Full Table Scans:** In some cases, the query scans entire tables due to missing indexes, which results in a higher cost.
2. **Unnecessary Joins:** While the `LEFT JOIN` on the `Payment` table is required to fetch payments (which may not always exist), it can still add unnecessary overhead if payment information isn't needed for all bookings.
3. **Index Usage:** The query could benefit from indexes on frequently used columns, such as `user_id`, `property_id`, and `booking_id`, to speed up the joins.

### Step 2: Refactor the Query

To optimize the query, we can:

- **Add Indexes**: Create indexes on the columns frequently used in joins (`user_id`, `property_id`, and `booking_id`) to reduce the need for full table scans.
- **Consider Filtering**: If payment data is not always required, we can add a condition to only include bookings that have a payment (or adjust the join type).
- **Use `INNER JOIN` where possible**: If there are cases where payments must exist for all bookings, replace the `LEFT JOIN` with an `INNER JOIN` for better performance.
