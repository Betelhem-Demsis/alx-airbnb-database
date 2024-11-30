# Database Normalization to Third Normal Form (3NF)

This document outlines the steps taken to normalize the database schema to ensure compliance with the Third Normal Form (3NF). Each step addresses potential redundancies and ensures data integrity while eliminating transitive dependencies.

---

## **Steps for Normalization**

### **1. Review of Existing Schema**

The initial schema consists of six entities:

- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

---

### **2. Normalization Adjustments**

#### **User Table**

- **Issue:** No redundancy detected.
- **Action:** No changes needed.

#### **Property Table**

- **Issue:** The `host_id` field directly links to the `User` table. However, there is no transitive dependency that violates 3NF.
- **Action:** No changes needed.

#### **Booking Table**

- **Issue:** `total_price` can be derived from `pricepernight` in the `Property` table and the duration (`end_date - start_date`).
- **Action:** Remove `total_price` to avoid storing derived data.

#### **Payment Table**

- **Issue:** No redundancy detected.
- **Action:** No changes needed.

#### **Review Table**

- **Issue:** No redundancy detected.
- **Action:** No changes needed.

#### **Message Table**

- **Issue:** No redundancy detected.
- **Action:** No changes needed.

---

## **Updated Schema**

### **User**

| Attribute         | Type                            | Constraints               |
| ----------------- | ------------------------------- | ------------------------- |
| **user_id**       | UUID                            | Primary Key, Indexed      |
| **first_name**    | VARCHAR                         | NOT NULL                  |
| **last_name**     | VARCHAR                         | NOT NULL                  |
| **email**         | VARCHAR                         | UNIQUE, NOT NULL          |
| **password_hash** | VARCHAR                         | NOT NULL                  |
| **phone_number**  | VARCHAR                         | NULL                      |
| **role**          | ENUM ('guest', 'host', 'admin') | NOT NULL                  |
| **created_at**    | TIMESTAMP                       | DEFAULT CURRENT_TIMESTAMP |

### **Property**

| Attribute         | Type      | Constraints                             |
| ----------------- | --------- | --------------------------------------- |
| **property_id**   | UUID      | Primary Key, Indexed                    |
| **host_id**       | UUID      | Foreign Key, references `User(user_id)` |
| **name**          | VARCHAR   | NOT NULL                                |
| **description**   | TEXT      | NOT NULL                                |
| **location**      | VARCHAR   | NOT NULL                                |
| **pricepernight** | DECIMAL   | NOT NULL                                |
| **created_at**    | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP               |
| **updated_at**    | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP             |

### **Booking**

| Attribute       | Type                                      | Constraints                                     |
| --------------- | ----------------------------------------- | ----------------------------------------------- |
| **booking_id**  | UUID                                      | Primary Key, Indexed                            |
| **property_id** | UUID                                      | Foreign Key, references `Property(property_id)` |
| **user_id**     | UUID                                      | Foreign Key, references `User(user_id)`         |
| **start_date**  | DATE                                      | NOT NULL                                        |
| **end_date**    | DATE                                      | NOT NULL                                        |
| **status**      | ENUM ('pending', 'confirmed', 'canceled') | NOT NULL                                        |
| **created_at**  | TIMESTAMP                                 | DEFAULT CURRENT_TIMESTAMP                       |

### **Payment**

| Attribute          | Type                                     | Constraints                                   |
| ------------------ | ---------------------------------------- | --------------------------------------------- |
| **payment_id**     | UUID                                     | Primary Key, Indexed                          |
| **booking_id**     | UUID                                     | Foreign Key, references `Booking(booking_id)` |
| **amount**         | DECIMAL                                  | NOT NULL                                      |
| **payment_date**   | TIMESTAMP                                | DEFAULT CURRENT_TIMESTAMP                     |
| **payment_method** | ENUM ('credit_card', 'paypal', 'stripe') | NOT NULL                                      |

### **Review**

| Attribute       | Type      | Constraints                                     |
| --------------- | --------- | ----------------------------------------------- |
| **review_id**   | UUID      | Primary Key, Indexed                            |
| **property_id** | UUID      | Foreign Key, references `Property(property_id)` |
| **user_id**     | UUID      | Foreign Key, references `User(user_id)`         |
| **rating**      | INTEGER   | CHECK: rating >= 1 AND rating <= 5, NOT NULL    |
| **comment**     | TEXT      | NOT NULL                                        |
| **created_at**  | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                       |

### **Message**

| Attribute        | Type      | Constraints                             |
| ---------------- | --------- | --------------------------------------- |
| **message_id**   | UUID      | Primary Key, Indexed                    |
| **sender_id**    | UUID      | Foreign Key, references `User(user_id)` |
| **recipient_id** | UUID      | Foreign Key, references `User(user_id)` |
| **message_body** | TEXT      | NOT NULL                                |
| **sent_at**      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP               |

---

## **Summary of Normalization**

1. **Eliminated Derived Data:** Removed `total_price` from the `Booking` table to avoid redundancy.
2. **No Transitive Dependencies:** Ensured all attributes depend only on the primary key.
3. **Achieved 3NF:** All tables now fully comply with the principles of 3NF.
