### Partitioning Performance Report

### Objective:

The goal of this task was to implement partitioning on the `Booking` table based on the `start_date` column in order to improve the query performance for large datasets.

### Step 1: Partitioning Strategy

We decided to partition the `Booking` table by year using the `start_date` column as the partition key. This is a common strategy for time-based data, as it ensures that each partition contains only a year's worth of data, reducing the size of each individual partition and improving query performance when filtering by date.

The partitions were created as follows:

- **Booking_2021** for data from January 1, 2021, to December 31, 2021.
- **Booking_2022** for data from January 1, 2022, to December 31, 2022.
- **Booking_2023** for data from January 1, 2023, to December 31, 2023.

### Step 2: Query Performance Before and After Partitioning

#### **Query Before Partitioning:**

We executed a query to retrieve all bookings between June 1, 2022, and June 30, 2022, from the original `Booking` table (non-partitioned). The query required scanning the entire table to find relevant bookings, resulting in slower performance as the table size grew larger.
