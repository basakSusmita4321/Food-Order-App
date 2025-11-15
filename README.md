# Food Order App

A full-stack food ordering application built using Java, Spring MVC, Hibernate/JPA, MySQL, and JSP.  
It supports user login, menu browsing, cart management, and admin functionalities like adding or managing food items.

---

## Features

### User Features
- User registration and login  
- Browse available food items  
- Add items to cart  
- Place orders  
- View order history  

### Admin Features
- Add new food items  
- Edit or delete food items  
- View all orders  
- Manage menu from Admin Dashboard  

---

## Tech Stack

### Backend
- Java  
- Spring MVC  
- Spring ORM  
- Hibernate/JPA  
- MySQL  

### Frontend
- JSP  
- HTML, CSS  
- Bootstrap  

### Build Tool
- Maven  

---

## Project Structure

Food-Order-App/
│
├── src/main/java/com/foodorderapp/
│   ├── controller/        # controllers (Admin, Home, User)
│   ├── model/             # Entity classes
│   ├── repository/        # DAO/Repository interfaces
│   ├── service/           # Service layer
│   └── config/            # Spring configuration files
│
├── src/main/webapp/
│   ├── views/             # JSP pages
│   ├── resources/         # CSS, JS, images
│
├── pom.xml                # Maven dependencies
└── README.md              # Project documentation

---

## Database Setup

Create a MySQL database:

CREATE DATABASE food_order_app;

Update your database username & password inside your Spring/Hibernate config files.

---

## How to Run

1. Clone the repository:
   git clone https://github.com/basakSusmita4321/Food-Order-App.git

2. Import into Spring Tool Suite (STS) / Eclipse:
   File → Import → Existing Maven Project

3. Configure MySQL DB.

4. Start the server:
   Run As → Run on Server → Apache Tomcat

5. Visit:
   http://localhost:8080/Food-Order-App/

---

## Future Improvements
- Convert to Spring Boot  
- Add JWT authentication  
- Add online payment  
- Deploy frontend + backend  
- Add REST APIs  

---

## Author
Susmita Basak
