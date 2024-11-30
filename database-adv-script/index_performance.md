## Index Performance Analysis

### User Table:

- `email`: Frequently used for user lookup during registration, login, etc.

### Booking Table:

- `user_id`: Commonly used for JOINs with the `User` table.
- `property_id`: Commonly used for JOINs with the `Property` table.
- `created_at`: Often used to filter or sort bookings by creation date.
- `status`: Used for filtering bookings based on their status (e.g., pending, confirmed, canceled).

### Property Table:

- `host_id`: Foreign key to the `User` table, used in JOINs.
- `created_at`: Frequently used for filtering or ordering properties by their creation date.

## Index Creation:

The following indexes have been created on high-usage columns:

1. `idx_booking_user_id` on `Booking(user_id)`
2. `idx_booking_property_id` on `Booking(property_id)`
3. `idx_property_user_id` on `Property(host_id)`
4. `idx_user_email` on `User(email)`
5. `idx_booking_created_at` on `Booking(created_at)`
6. `idx_property_created_at` on `Property(created_at)`
7. `idx_booking_status` on `Booking(status)`
