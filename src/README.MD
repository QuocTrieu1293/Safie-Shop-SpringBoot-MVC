![Safie Shop Logo](https://github.com/QuocTrieu1293/host-image/blob/7f4bc56942131e17593df26e5535d42e68352486/safie-logo.png)

# 🛒 Safie Shop Web App

An ecommerce website for selling baby clothes, this  is my pet project for learning and get similar to Spring Boot & Spring ecosystem. The web app follows MVC pattern and allows user to browse and search products with multiple criteria, add them to cart, place orders, process online payments with VNPAY, and view order history. User can also log in or sign up with many methods such as email/password, OAuth2 with Google, GitHub account, the password can be reset via email when forgotten. Moreover, user can edit their profile, upload avatar image, change password, ... The admin can manage products, users, and orders.

## 🚀 Live Demo
For better live demo, the project is deployed on *AWS Elastic Beanstalk*.
> **🔗Here the link:** <http://safie-shop.ap-southeast-1.elasticbeanstalk.com>

**Admin Access:** visit `/admin` and login with `admin@gmail.com`/`12345678` to see the admin features.

❌ ***VNPAY does not work on deploy environment.***

## 🏗️ Tech Stack

**Frontend:** HTML, CSS, JavaScript, JSP/JSTL, Bootstrap, JQuery

**Backend:** Spring Boot, Spring Security, Spring Data JPA, Maven, MySQL

## 🎖️ Features

- Filter & Sort & Pagination products with multiple criteria using Criteria Queries
- Search products by keyword with debounce technique for search suggestions & Save search history in LocalStorage
- Login/Signup with email/password (verify via email), OAuth2 with Google, GitHub account
- Reset password via email
- Persist user Session with Spring Security
- Add products to cart, update quantity, remove product
- Place order, process online payment with VNPAY and send order confirmation email
- View order history
- Edit profile, upload avatar image, change password
- User manage their address book: add new address, set default address for convenience when checkout
- Admin Dashboard: manage products, users, orders

## 📸 Screenshots


## Contact
- 📩 **Email:** tcqtrieu@gmail.com
- 🔗 **LinkedIn:** [in/quoc-trieu-129t2003](https://www.linkedin.com/in/quoc-trieu-129t2003/)
- 💻 **GitHub:** [QuocTrieu1293](https://github.com/QuocTrieu1293)