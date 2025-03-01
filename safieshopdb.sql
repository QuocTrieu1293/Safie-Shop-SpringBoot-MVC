-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: laptopshopdb
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `city_id` varchar(255) NOT NULL,
  `default_address` bit(1) NOT NULL,
  `district` varchar(255) NOT NULL,
  `district_id` varchar(255) NOT NULL,
  `receiver_name` varchar(255) NOT NULL,
  `receiver_phone` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `type` enum('HOME','OFFICE') NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `ward` varchar(255) NOT NULL,
  `ward_id` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1fa36y2oqhao3wgg2rw1pi459` (`user_id`),
  CONSTRAINT `FK1fa36y2oqhao3wgg2rw1pi459` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (3,'Thành phố Hồ Chí Minh','79',_binary '\0','Quận 1','760','Quốc Triệu','0359924897','178 Trần Hưng Đạo','HOME','2025-02-13 02:48:38.041462','Phường Nguyễn Cư Trinh','26758',12),(4,'Tỉnh Bình Thuận','60',_binary '','Thành phố Phan Thiết','593','Hiếu Ngân','1234567890','910 test','HOME','2025-02-13 02:48:32.793483','Phường Đức Thắng','22948',12);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_oce3937d2f4mpfqrycbr0l93m` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Bobi craft'),(2,'Lullaby'),(3,'Safie');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_detail`
--

DROP TABLE IF EXISTS `cart_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `size_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbjuqmks644n9fm46rbw9q97ti` (`size_id`),
  KEY `FKbql1m2v2po7hcawonqsgqex88` (`cart_id`),
  KEY `FKclb1c0wg3mofxnpgidib1t987` (`product_id`),
  CONSTRAINT `FKbjuqmks644n9fm46rbw9q97ti` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKbql1m2v2po7hcawonqsgqex88` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKclb1c0wg3mofxnpgidib1t987` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_detail`
--

LOCK TABLES `cart_detail` WRITE;
/*!40000 ALTER TABLE `cart_detail` DISABLE KEYS */;
INSERT INTO `cart_detail` VALUES (124,3,16,18,10),(129,3,13,25,2),(130,2,13,20,2);
/*!40000 ALTER TABLE `cart_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sum` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_chk_1` CHECK ((`sum` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (12,0,12),(13,5,11),(16,3,16),(21,0,21),(23,0,23),(29,0,40);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bé trai'),(2,'Bé gái'),(3,'Tất & bao tay'),(4,'Bộ đồ liền thân');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `product_price` double NOT NULL,
  `quantity` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `size_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc7q42e9tu0hslx6w4wxgomhvn` (`product_id`),
  KEY `FK64s0y27ydsqyr41ovs1kwpkd9` (`size_id`),
  KEY `FK48fbrtcney4ysqrvfa2qqj3s4` (`order_id`),
  CONSTRAINT `FK48fbrtcney4ysqrvfa2qqj3s4` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK64s0y27ydsqyr41ovs1kwpkd9` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `FKc7q42e9tu0hslx6w4wxgomhvn` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (29,597000,199000,3,10,20,2),(30,75000,15000,5,10,19,10),(31,398000,199000,2,11,17,2),(32,15000,15000,1,11,19,10),(33,30000,15000,2,11,18,10),(47,537300,179100,3,16,29,2),(48,585000,292500,2,17,24,5),(49,265500,265500,1,17,25,2),(50,265500,265500,1,17,25,3),(51,179100,179100,1,18,28,2),(52,208800,104400,2,18,27,2),(53,495000,247500,2,19,30,2),(54,318000,159000,2,19,31,3),(55,179100,179100,1,20,26,2),(56,318000,159000,2,20,32,3),(57,30000,15000,2,21,19,10),(58,15000,15000,1,21,18,10),(59,398000,199000,2,22,17,2),(60,199000,199000,1,22,20,2),(61,199000,199000,1,24,20,2),(62,398000,199000,2,24,17,2),(63,495000,247500,2,25,23,6),(64,30000,15000,2,26,19,10),(65,597000,199000,3,26,20,2),(66,15000,15000,1,29,18,10),(67,796000,199000,4,29,20,2),(68,60000,15000,4,30,19,10),(69,199000,199000,1,31,20,2),(70,30000,15000,2,32,19,10),(85,15000,15000,1,43,19,10),(86,597000,199000,3,43,17,2),(87,15000,15000,1,43,18,10),(88,15000,15000,1,44,19,10),(89,877500,292500,3,44,24,7);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_ref` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `receiver_address` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `sum` int NOT NULL,
  `total_price` double DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `last_modified` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65vkmord8rjg54ayj5j2rkd96` (`user_id`),
  CONSTRAINT `FK65vkmord8rjg54ayj5j2rkd96` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (10,'2024-12-22 04:52:20.745353','','VNPAY','7fd9165b91a94f25a24657e9ba30674e','PAYMENT_SUCCEED','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','CANCEL',8,672000,11,'2025-01-12 14:34:31.079757'),(11,'2024-12-22 05:09:31.465148','Giao trong giờ hành chính. Gọi trước 10 phút khi giao.','VNPAY','0f08db7d7f5f4d3097c742d11c0d2e61','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','SHIPPING',5,443000,11,NULL),(16,'2024-12-28 02:40:11.003039','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','CANCEL',3,537300,11,'2025-01-15 03:11:29.872575'),(17,'2024-12-28 02:40:58.845599','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','SHIPPING',4,1116000,11,NULL),(18,'2024-12-28 02:41:51.817770','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','PENDING',3,387900,11,NULL),(19,'2024-12-28 02:42:56.587793','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','CANCEL',4,813000,11,NULL),(20,'2024-12-28 02:43:35.950059','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','SHIPPING',3,497100,11,NULL),(21,'2024-12-28 02:44:39.288230','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','PENDING',3,45000,11,NULL),(22,'2024-12-28 02:45:07.141790','','VNPAY','f811a97888f94e1b9d8bf45ac32bdc7f','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','COMPLETE',3,597000,11,NULL),(24,'2024-12-28 02:45:52.216189','','VNPAY','d40210a0246d496e86fb21fdbf990bbb','PAYMENT_SUCCEED','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','PENDING',3,597000,11,NULL),(25,'2024-12-28 21:23:34.501025','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','PENDING',2,495000,11,NULL),(26,'2025-01-11 17:51:53.323316','','VNPAY','0855b99aa6e9469eb648385f3ceedc80','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','user','0359923897','SHIPPING',5,627000,12,'2025-01-13 12:30:01.624282'),(29,'2025-01-11 17:55:06.691581','','VNPAY','a1eccbfcb18144b796c9f61f3193da3b','PAYMENT_SUCCEED','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','user','0359924897','COMPLETE',5,811000,12,NULL),(30,'2025-01-12 10:44:24.786166','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','PENDING',4,60000,11,'2025-01-12 10:44:24.786166'),(31,'2025-01-16 16:26:04.881450','','VNPAY','b4252912e7904ea8a98e2c13c9bb40f6','PAYMENT_FAILED','178','Trương Công Quốc Triệu','0359924897','PENDING',1,199000,11,'2025-01-16 16:41:40.298993'),(32,'2025-01-17 01:56:40.968747','','VNPAY','5ea76301374e4e109ed8929d14e5bc6d','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','Trương Công Quốc Triệu','0359924897','COMPLETE',2,30000,11,'2025-01-23 10:54:06.828458'),(43,'2025-02-04 09:36:26.672168','','COD','UNKNOWN','PAYMENT_UNPAID','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','trieu2912','0359924897','PENDING',5,627000,21,'2025-02-04 09:36:26.672168'),(44,'2025-02-04 15:17:03.280525','','VNPAY','31b24071a3f245e7bedb6c7017c7aa7f','PAYMENT_SUCCEED','178 Trần Hưng Đạo, phường Nguyễn Cư Trinh','trieu2912','0359924899','PENDING',4,892500,21,'2025-02-04 15:19:29.270387');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_size`
--

DROP TABLE IF EXISTS `product_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_size` (
  `product_id` bigint NOT NULL,
  `size_id` bigint NOT NULL,
  PRIMARY KEY (`product_id`,`size_id`),
  KEY `FK1yl8bbmokvonm64131xlscnci` (`size_id`),
  CONSTRAINT `FK1yl8bbmokvonm64131xlscnci` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `FK9qjgp0xvl5jfetdt683i7wqwr` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_size`
--

LOCK TABLES `product_size` WRITE;
/*!40000 ALTER TABLE `product_size` DISABLE KEYS */;
INSERT INTO `product_size` VALUES (33,1),(17,2),(20,2),(21,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(35,2),(20,3),(21,3),(25,3),(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),(34,3),(27,4),(23,5),(24,5),(25,5),(26,5),(28,5),(29,5),(30,5),(31,5),(32,5),(23,6),(24,6),(25,6),(26,6),(28,6),(29,6),(30,6),(31,6),(32,6),(23,7),(24,7),(25,7),(27,7),(28,7),(30,7),(31,9),(32,9),(33,9),(18,10),(19,10);
/*!40000 ALTER TABLE `product_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `detail_desc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` double DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `short_desc` varchar(255) DEFAULT NULL,
  `sold` bigint NOT NULL,
  `brand_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_o61fmio5yukmmiqgnxf8pnavn` (`name`),
  KEY `FKa3a4mpsfdf4d2y6r8ra3sc8mv` (`brand_id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKa3a4mpsfdf4d2y6r8ra3sc8mv` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`price` >= 0)),
  CONSTRAINT `products_chk_2` CHECK ((`quantity` >= 0)),
  CONSTRAINT `products_chk_3` CHECK ((`sold` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (17,'Jumpsuit Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại\r\n\r\nMô tả sản phẩm:\r\nMang đến sự an toàn tuyệt đối cho làn da mỏng manh của bé yêu với sleepsuit cotton hữu cơ 100%, đạt chứng nhận GOTS (Global Organic Textile Standard). Sản phẩm không chứa hóa chất độc hại, là lựa chọn lý tưởng để bảo vệ sức khỏe bé sơ sinh từ 0-6 tháng.\r\n\r\n✨ Vì sao chọn cotton hữu cơ?\r\n\r\nCotton thường có hóa chất độc hại: Trong quá trình sản xuất, cotton thông thường thường sử dụng thuốc trừ sâu, phân bón hóa học và chất nhuộm độc hại, có thể gây kích ứng da, dị ứng và các vấn đề hô hấp ở trẻ.\r\nLợi ích vượt trội của cotton hữu cơ:\r\nAn toàn tuyệt đối: Không hóa chất độc hại, thân thiện với làn da nhạy cảm.\r\nThoáng mát và mềm mại: Giúp bé ngủ ngon và thoải mái suốt cả ngày.\r\nBảo vệ môi trường: Quá trình sản xuất giảm thiểu tác động xấu đến hệ sinh thái.\r\n? Đạt chứng nhận GOTS:\r\nChứng nhận GOTS đảm bảo sản phẩm đạt tiêu chuẩn cao nhất về chất liệu và quy trình sản xuất, hoàn toàn hữu cơ và an toàn.\r\n\r\n✨ Đặc điểm nổi bật:\r\n\r\nChất liệu cotton hữu cơ 100%, không thuốc nhuộm hóa chất.\r\nThiết kế tiện lợi, dễ mặc, phù hợp cho bé sơ sinh 0-6 tháng.\r\nĐường may chắc chắn, tỉ mỉ, đảm bảo độ bền và sự thoải mái.\r\n? Lựa chọn hoàn hảo:\r\nPhù hợp làm quà tặng hoặc sử dụng hàng ngày, giúp bé yêu luôn được bảo vệ và chăm sóc tốt nhất.\r\n\r\n? Cam kết:\r\n\r\nGiao hàng nhanh chóng, đóng gói cẩn thận.\r\nĐổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\nHãy đầu tư vào sức khỏe và giấc ngủ của bé yêu với sản phẩm chất lượng hàng đầu được chứng nhận GOTS! ❤️','1734275292081-vn-11134207-7ras8-m3s5e62wnhnle5.webp','Bộ liền thân jumpsuit cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic an toàn không hoá chất độc hại 2 màu trắng, be',199000,0,'Bộ liền thân jumpsuit cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic an toàn không hoá chất độc hại 2 màu trắng, be',0,3,4),(18,'Mô tả sản phẩm:\r\nMang đến sự an toàn tuyệt đối cho làn da mỏng manh của bé yêu với sleepsuit cotton hữu cơ 100%, đạt chứng nhận GOTS (Global Organic Textile Standard). Sản phẩm không chứa hóa chất độc hại, là lựa chọn lý tưởng để bảo vệ sức khỏe bé sơ sinh từ 0-6 tháng.\r\n\r\n✨ Vì sao chọn cotton hữu cơ?\r\n\r\nCotton thường có hóa chất độc hại: Trong quá trình sản xuất, cotton thông thường thường sử dụng thuốc trừ sâu, phân bón hóa học và chất nhuộm độc hại, có thể gây kích ứng da, dị ứng và các vấn đề hô hấp ở trẻ.\r\nLợi ích vượt trội của cotton hữu cơ:\r\nAn toàn tuyệt đối: Không hóa chất độc hại, thân thiện với làn da nhạy cảm.\r\nThoáng mát và mềm mại: Giúp bé ngủ ngon và thoải mái suốt cả ngày.\r\nBảo vệ môi trường: Quá trình sản xuất giảm thiểu tác động xấu đến hệ sinh thái.\r\n? Đạt chứng nhận GOTS:\r\nChứng nhận GOTS đảm bảo sản phẩm đạt tiêu chuẩn cao nhất về chất liệu và quy trình sản xuất, hoàn toàn hữu cơ và an toàn.\r\n\r\n✨ Đặc điểm nổi bật:\r\n\r\nChất liệu cotton hữu cơ 100%, không thuốc nhuộm hóa chất.\r\nThiết kế tiện lợi, dễ mặc, phù hợp cho bé sơ sinh 0-6 tháng.\r\nĐường may chắc chắn, tỉ mỉ, đảm bảo độ bền và sự thoải mái.\r\n? Lựa chọn hoàn hảo:\r\nPhù hợp làm quà tặng hoặc sử dụng hàng ngày, giúp bé yêu luôn được bảo vệ và chăm sóc tốt nhất.\r\n\r\n? Cam kết:\r\n\r\nGiao hàng nhanh chóng, đóng gói cẩn thận.\r\nĐổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\nHãy đầu tư vào sức khỏe và giấc ngủ của bé yêu với sản phẩm chất lượng hàng đầu được chứng nhận GOTS! ❤️','1734275513300-vn-11134207-7ras8-m3t9t82pwnq9ef@resize_w450_nl.webp','Tất giữ ấm cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic không hoá chất độc hại 3 màu trắng, be, nâu',15000,10,'Tất giữ ấm Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại',0,3,3),(19,'Bao tay giữ ấm Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại\r\n\r\nMô tả sản phẩm:\r\nMang đến sự an toàn tuyệt đối cho làn da mỏng manh của bé yêu với sleepsuit cotton hữu cơ 100%, đạt chứng nhận GOTS (Global Organic Textile Standard). Sản phẩm không chứa hóa chất độc hại, là lựa chọn lý tưởng để bảo vệ sức khỏe bé sơ sinh từ 0-6 tháng.\r\n\r\n✨ Vì sao chọn cotton hữu cơ?\r\n\r\nCotton thường có hóa chất độc hại: Trong quá trình sản xuất, cotton thông thường thường sử dụng thuốc trừ sâu, phân bón hóa học và chất nhuộm độc hại, có thể gây kích ứng da, dị ứng và các vấn đề hô hấp ở trẻ.\r\nLợi ích vượt trội của cotton hữu cơ:\r\nAn toàn tuyệt đối: Không hóa chất độc hại, thân thiện với làn da nhạy cảm.\r\nThoáng mát và mềm mại: Giúp bé ngủ ngon và thoải mái suốt cả ngày.\r\nBảo vệ môi trường: Quá trình sản xuất giảm thiểu tác động xấu đến hệ sinh thái.\r\n? Đạt chứng nhận GOTS:\r\nChứng nhận GOTS đảm bảo sản phẩm đạt tiêu chuẩn cao nhất về chất liệu và quy trình sản xuất, hoàn toàn hữu cơ và an toàn.\r\n\r\n✨ Đặc điểm nổi bật:\r\n\r\nChất liệu cotton hữu cơ 100%, không thuốc nhuộm hóa chất.\r\nThiết kế tiện lợi, dễ mặc, phù hợp cho bé sơ sinh 0-6 tháng.\r\nĐường may chắc chắn, tỉ mỉ, đảm bảo độ bền và sự thoải mái.\r\n? Lựa chọn hoàn hảo:\r\nPhù hợp làm quà tặng hoặc sử dụng hàng ngày, giúp bé yêu luôn được bảo vệ và chăm sóc tốt nhất.\r\n\r\n? Cam kết:\r\n\r\nGiao hàng nhanh chóng, đóng gói cẩn thận.\r\nĐổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\nHãy đầu tư vào sức khỏe và giấc ngủ của bé yêu với sản phẩm chất lượng hàng đầu được chứng nhận GOTS! ❤️','1734275757233-vn-11134207-7ras8-m3t9zdqviojgf1.webp','Bao tay giữ ấm mềm mại cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic không hoá chất độc hại 3 màu trắng, be, nâu',15000,10,'Bao tay giữ ấm Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại',0,3,3),(20,'Sleepsuit Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại\r\n\r\nMang đến sự an toàn tuyệt đối cho làn da mỏng manh của bé yêu với sleepsuit cotton hữu cơ 100%, đạt chứng nhận GOTS (Global Organic Textile Standard). Sản phẩm không chứa hóa chất độc hại, là lựa chọn lý tưởng để bảo vệ sức khỏe bé sơ sinh từ 0-6 tháng.\r\n\r\n✨ Vì sao chọn cotton hữu cơ?\r\nCotton thường có hóa chất độc hại: Trong quá trình sản xuất, cotton thông thường thường sử dụng thuốc trừ sâu, phân bón hóa học và chất nhuộm độc hại, có thể gây kích ứng da, dị ứng và các vấn đề hô hấp ở trẻ.\r\nLợi ích vượt trội của cotton hữu cơ:\r\nAn toàn tuyệt đối: Không hóa chất độc hại, thân thiện với làn da nhạy cảm.\r\nThoáng mát và mềm mại: Giúp bé ngủ ngon và thoải mái suốt cả ngày.\r\nBảo vệ môi trường: Quá trình sản xuất giảm thiểu tác động xấu đến hệ sinh thái.\r\n? Đạt chứng nhận GOTS:\r\nChứng nhận GOTS đảm bảo sản phẩm đạt tiêu chuẩn cao nhất về chất liệu và quy trình sản xuất, hoàn toàn hữu cơ và an toàn.\r\n\r\n✨ Đặc điểm nổi bật:\r\nChất liệu cotton hữu cơ 100%, không thuốc nhuộm hóa chất.\r\nThiết kế tiện lợi, dễ mặc, phù hợp cho bé sơ sinh 0-6 tháng.\r\nĐường may chắc chắn, tỉ mỉ, đảm bảo độ bền và sự thoải mái.\r\n? Lựa chọn hoàn hảo:\r\nPhù hợp làm quà tặng hoặc sử dụng hàng ngày, giúp bé yêu luôn được bảo vệ và chăm sóc tốt nhất.\r\n\r\n? Cam kết:\r\nGiao hàng nhanh chóng, đóng gói cẩn thận.\r\nĐổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\nHãy đầu tư vào sức khỏe và giấc ngủ của bé yêu với sản phẩm chất lượng hàng đầu được chứng nhận GOTS! ❤️','1734275844558-vn-11134207-7ras8-m3s4iepvs9b5b7@resize_w450_nl.webp','Bộ liền thân sleepsuit cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic không hoá chất độc hại 3 màu trắng, be, nâu',199000,10,'Sleepsuit Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại',0,3,4),(21,'Bộ liền thân Singlet Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại\r\n\r\nMô tả sản phẩm:\r\nMang đến sự an toàn tuyệt đối cho làn da mỏng manh của bé yêu với sleepsuit cotton hữu cơ 100%, đạt chứng nhận GOTS (Global Organic Textile Standard). Sản phẩm không chứa hóa chất độc hại, là lựa chọn lý tưởng để bảo vệ sức khỏe bé sơ sinh từ 0-6 tháng.\r\n\r\n✨ Vì sao chọn cotton hữu cơ?\r\n\r\nCotton thường có hóa chất độc hại: Trong quá trình sản xuất, cotton thông thường thường sử dụng thuốc trừ sâu, phân bón hóa học và chất nhuộm độc hại, có thể gây kích ứng da, dị ứng và các vấn đề hô hấp ở trẻ.\r\nLợi ích vượt trội của cotton hữu cơ:\r\nAn toàn tuyệt đối: Không hóa chất độc hại, thân thiện với làn da nhạy cảm.\r\nThoáng mát và mềm mại: Giúp bé ngủ ngon và thoải mái suốt cả ngày.\r\nBảo vệ môi trường: Quá trình sản xuất giảm thiểu tác động xấu đến hệ sinh thái.\r\n? Đạt chứng nhận GOTS:\r\nChứng nhận GOTS đảm bảo sản phẩm đạt tiêu chuẩn cao nhất về chất liệu và quy trình sản xuất, hoàn toàn hữu cơ và an toàn.\r\n\r\n✨ Đặc điểm nổi bật:\r\n\r\nChất liệu cotton hữu cơ 100%, không thuốc nhuộm hóa chất.\r\nThiết kế tiện lợi, dễ mặc, phù hợp cho bé sơ sinh 0-6 tháng.\r\nĐường may chắc chắn, tỉ mỉ, đảm bảo độ bền và sự thoải mái.\r\n? Lựa chọn hoàn hảo:\r\nPhù hợp làm quà tặng hoặc sử dụng hàng ngày, giúp bé yêu luôn được bảo vệ và chăm sóc tốt nhất.\r\n\r\n? Cam kết:\r\n\r\nGiao hàng nhanh chóng, đóng gói cẩn thận.\r\nĐổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\nHãy đầu tư vào sức khỏe và giấc ngủ của bé yêu với sản phẩm chất lượng hàng đầu được chứng nhận GOTS! ❤️','1734275928384-vn-11134207-7ras8-m3t9erjlpyg870@resize_w450_nl.webp','Safie Bộ liền thân singlet cho bé sơ sinh 0-6 tháng cotton 100% hữu cơ organic an toàn không hoá chất độc hại màu be',99000,10,'Bộ liền thân Singlet Cotton Hữu Cơ 100% GOTS Cho Trẻ Sơ Sinh 0-6 Tháng - An Toàn Không Hóa Chất Độc Hại',0,3,4),(23,'Chất liệu: 100% Organic Cotton\r\n\r\nSản xuất: Việt Nam\r\n\r\nSản phẩm bé gái từ 0 - 36 tháng tuổi\r\n\r\nDa của trẻ em rất nhạy cảm, đặc biệt trong khoảng từ 1-3 tuổi. Hướng đến sự an toàn và dễ chịu của các bé, Bobi Craft cho ra đời dòng sản phẩm quần áo trẻ em Organic Collection được làm từ organic cotton 100%.\r\n\r\nOrganic cotton là chất liệu quần áo trẻ em rất được ưa chuộng nhờ vào đặc tính thoáng khí, hút ẩm tốt, không gây kích ứng, kháng được vi khuẩn và nấm mốc. Vì vậy, bé sẽ luôn cảm thấy thoải mái và khô thoáng dù là vào mùa hè nóng bức.\r\n\r\nVới chất liệu tự nhiên, không sử dụng thuốc tẩy nhuộm hóa học nên những sản phẩm quần áo cho bé trai và bé gái của Bobi Craft vẫn giữ được màu sắc trắng và nâu nguyên bản của sợi bông.\r\n\r\nĐặc biệt, chất vải mịn, mát, không làm tổn thương, bảo vệ an toàn cho làn da nhạy cảm của bé. Màu sắc nhẹ nhàng, đơn giản kết hợp với những họa tiết dễ thương, tinh tế, chắc chắn sẽ là điểm cộng lớn của bộ sản phẩm quần áo trẻ em của nhà Bobi.\r\n\r\nSản phẩm Organic Collection từ Bobi Craft chắc chắn sẽ là quà tặng sinh nhật, đầy tháng vô cùng ý nghĩa dành cho các bé.','1734890580096-web3.webp','Áo Đầm Cổ Tròn Lai Phối',247500,15,NULL,0,1,2),(24,NULL,'1734890654888-artboard-1-copy-b06f179c-e008-4fd0-a687-c0b0e990bc27.webp','Quần áo trẻ em Bobicraft - Đầm đô bèo tay dài - Cotton hữu cơ organic an toàn',292500,15,NULL,0,1,2),(25,'Chất liệu: 100% Organic Cotton\r\nSản xuất: Việt Nam\r\nSản phẩm bé gái từ 0 - 18 tháng tuổi\r\n\r\nDa của trẻ em rất nhạy cảm, đặc biệt trong khoảng từ 1-3 tuổi. Hướng đến sự an toàn và dễ chịu của các bé, Bobi Craft cho ra đời dòng sản phẩm quần áo trẻ em Organic Collection được làm từ organic cotton 100%.\r\n\r\nOrganic cotton là chất liệu quần áo trẻ em rất được ưa chuộng nhờ vào đặc tính thoáng khí, hút ẩm tốt, không gây kích ứng, kháng được vi khuẩn và nấm mốc. Vì vậy, bé sẽ luôn cảm thấy thoải mái và khô thoáng dù là vào mùa hè nóng bức.\r\n\r\nVới chất liệu tự nhiên, không sử dụng thuốc tẩy nhuộm hóa học nên những sản phẩm quần áo cho bé trai và bé gái của Bobi Craft vẫn giữ được màu sắc trắng và nâu nguyên bản của sợi bông.\r\n\r\nĐặc biệt, chất vải mịn, mát, không làm tổn thương, bảo vệ an toàn cho làn da nhạy cảm của bé. Màu sắc nhẹ nhàng, đơn giản kết hợp với những họa tiết dễ thương, tinh tế, chắc chắn sẽ là điểm cộng lớn của bộ sản phẩm quần áo trẻ em của nhà Bobi.\r\n\r\nSản phẩm Organic Collection từ Bobi Craft chắc chắn sẽ là quà tặng sinh nhật, đầy tháng vô cùng ý nghĩa dành cho các bé.','1734890861652-7bd79f964a6bbcd7664160249f9f0126-1667548804912.webp','Quần áo trẻ em Bobicraft - Áo đầm tay cánh hoa - Cotton hữu cơ organic an toàn',265500,10,NULL,0,1,2),(26,'Da của trẻ em rất nhạy cảm, đặc biệt trong khoảng từ 1-3 tuổi. Hướng đến sự an toàn và dễ chịu của các bé, Bobi Craft cho ra đời dòng sản phẩm quần áo trẻ em Organic Collection được làm từ organic cotton 100%.\r\n\r\nOrganic cotton là chất liệu quần áo trẻ em rất được ưa chuộng nhờ vào đặc tính thoáng khí, hút ẩm tốt, không gây kích ứng, kháng được vi khuẩn và nấm mốc. Vì vậy, bé sẽ luôn cảm thấy thoải mái và khô thoáng dù là vào mùa hè nóng bức.','1734890938963-z3762544872507-a91a881850e1291b74f2726f1737041e-1-1667983689462.webp','Quần áo trẻ em Bobicraft - Romper bỉm bé trai thêu B - Cotton hữu cơ organic an toàn',179100,10,NULL,0,1,1),(27,NULL,'1734891045804-44.webp','Quần áo trẻ em Bobicraft - Áo thun bé trai Cổ tròn tay dài - Cotton hữu cơ organic an toàn',104400,10,NULL,0,1,1),(28,NULL,'1734891142632-artboard-1-copy-15-300b0b04-97fd-4349-aa66-7d2a418d6423.webp','Quần áo trẻ em Bobicraft - Bộ đồ liền thân bodysuit Romper tay ngắn quần đùi gấu bé trai bé gái - Cotton hữu cơ organic an toàn',179100,10,NULL,0,1,1),(29,'Chất liệu: 100% Organic Cotton\r\nSản xuất: Việt Nam\r\n\r\nDa của trẻ em rất nhạy cảm, đặc biệt trong khoảng từ 1-3 tuổi. Hướng đến sự an toàn và dễ chịu của các bé, Bobi Craft cho ra đời dòng sản phẩm quần áo trẻ em Organic Collection được làm từ organic cotton 100%.\r\n\r\nOrganic cotton là chất liệu quần áo trẻ em rất được ưa chuộng nhờ vào đặc tính thoáng khí, hút ẩm tốt, không gây kích ứng, kháng được vi khuẩn và nấm mốc. Vì vậy, bé sẽ luôn cảm thấy thoải mái và khô thoáng dù là vào mùa hè nóng bức.\r\n\r\nVới chất liệu tự nhiên, không sử dụng thuốc tẩy nhuộm hóa học nên những sản phẩm quần áo cho bé trai và bé gái của Bobi Craft vẫn giữ được màu sắc trắng và nâu nguyên bản của sợi bông.\r\n\r\nĐặc biệt, chất vải mịn, mát, không làm tổn thương, bảo vệ an toàn cho làn da nhạy cảm của bé. Màu sắc nhẹ nhàng, đơn giản kết hợp với những họa tiết dễ thương, tinh tế, chắc chắn sẽ là điểm cộng lớn của bộ sản phẩm quần áo trẻ em của nhà Bobi.\r\n\r\nSản phẩm Organic Collection từ Bobi Craft chắc chắn sẽ là quà tặng sinh nhật, đầy tháng vô cùng ý nghĩa dành cho các bé.','1734891251154-romperbim2.webp','Quần áo trẻ em Bobicraft - Bộ đồ liền thân bodysuit Romper bỉm gấu bé trai bé gái - Cotton hữu cơ organic an toàn',179100,13,NULL,0,1,1),(30,'Chất liệu: 100% Organic Cotton\r\nSản xuất: Việt Nam\r\nSản phẩm bé trai từ 0-18 tháng tuổi\r\n\r\nDa của trẻ em rất nhạy cảm, đặc biệt trong khoảng từ 1-3 tuổi. Hướng đến sự an toàn và dễ chịu của các bé, Bobi Craft cho ra đời dòng sản phẩm quần áo trẻ em Organic Collection được làm từ organic cotton 100%.\r\n\r\nOrganic cotton là chất liệu quần áo trẻ em rất được ưa chuộng nhờ vào đặc tính thoáng khí, hút ẩm tốt, không gây kích ứng, kháng được vi khuẩn và nấm mốc. Vì vậy, bé sẽ luôn cảm thấy thoải mái và khô thoáng dù là vào mùa hè nóng bức.\r\n\r\nVới chất liệu tự nhiên, không sử dụng thuốc tẩy nhuộm hóa học nên những sản phẩm quần áo cho bé trai và bé gái của Bobi Craft vẫn giữ được màu sắc trắng và nâu nguyên bản của sợi bông.\r\n\r\nĐặc biệt, chất vải mịn, mát, không làm tổn thương, bảo vệ an toàn cho làn da nhạy cảm của bé. Màu sắc nhẹ nhàng, đơn giản kết hợp với những họa tiết dễ thương, tinh tế, chắc chắn sẽ là điểm cộng lớn của bộ sản phẩm quần áo trẻ em của nhà Bobi.\r\n\r\nSản phẩm Organic Collection từ Bobi Craft chắc chắn sẽ là quà tặng sinh nhật, đầy tháng vô cùng ý nghĩa dành cho các bé.','1734891389540-z3063355308692-6cce460a1c31c731f2b3afa314320db0.webp','Quần áo trẻ em Bobicraft - Bộ đồ liền thân bodysuit Romper Gile xám nơ đỏ bé trai - Cotton hữu cơ organic an toàn',247500,10,NULL,0,1,1),(31,'BST Quilt Jacquard by Lul\r\n\r\nMột lớp bông Êm – Mềm nằm giữa để giữ được hơi ấm cho bé cũng như chống lại những cơn gió lạnh mùa đông.Chất liệu hoàn hảo cho mùa đông của Bé.\r\n\r\nLớp vải bề mặt 100% Cotton: thấm hút, thân thiện với làn da cùng lớp bông nhẹ như mây sẽ giúp bé thoải mái nô đùa và luôn năng động, dù trong những ngày đông lạnh.\r\n\r\nBộ sưu tập được chứng nhận OEKO-TEX 100 CLASS I, chứng nhận quốc tế cao nhất và an toàn nhất về sản phẩm dệt may cho trẻ sơ sinh và trẻ nhỏ.\r\n\r\nCác mẹ tham khảo bảng size để chọn size cho bé nhé:\r\n\r\nSize 1 – 3M: 4 – 6Kg cao 54 – 62cm\r\n\r\nSize 3 – 6M: 6-8Kg cao 62 – 69cm\r\n\r\nSize 6 – 9M: 8-9Kg cao 69 – 72cm\r\n\r\nSize 9 – 12M: 9-10Kg cao 72 – 76cm\r\n\r\nHướng dẫn giặt là, bảo quản:\r\n\r\nLullaby mách nhỏ Mẹ một số bí quyết để giữ bộ quần áo 100% cotton của bé luôn sạch sẽ, bền màu:\r\n\r\n1. Phương pháp giặt:\r\n\r\n– Giặt máy (phù hợp với những trang phục đơn giản, ít như tiết phức tạp như phụ kiện, hình thêu,…)\r\n\r\n+ Xử lý các vết bẩn khó giặt ở cổ áo, nách riêng biệt trước khi cho vào máy.\r\n\r\n+ Nên sử dụng túi lưới có kíchcỡ phù hợp\r\n\r\n+ Giặt ở chế độ nhẹ\r\n\r\n+ Vắt trong 1-2 phút bằng chế độ giặt ly tâm để hạn chế độ giãn của cotton.\r\n\r\n– Giặt tay: Giặt nhẹ tay, không vò xát mạnh\r\n\r\n– Khigiặt đồ của bé dù bằng tay hay bằng máy, Mẹ nên sử dụng chất tẩy rửa trung tính, tốt nhất là loại nước giặt dành riêng cho trẻ em.\r\n\r\n– Hạn chế sử dụng nước nóng để tránh ảnh hưởng đến độ co giãn của sản phẩm, nên dùng nước ấm ở nhiệt độ tầm 30 độ C.\r\n\r\n2. Phơi, sấy khô, là ủi:\r\n\r\n– Sau khi giặt xong, nên phơi/sấy quần áo của bé ngay, vì cotton là sợi tự nhiên nên để ủ lâu trong chậu/máy giặt ẩm ướt sẽ dễ sinh nấm mốc, vi khuẩn.\r\n\r\n– Phơi quần áo của bé ở nơi thoáng mát, tránh tiếp xúc với ánh sáng mặt trời gay gắt.\r\n\r\n–  Mùa đông có thể sử dụng máy sấy nhưng hạn chế sấy ở nhiệt độ quá cao.\r\n\r\n– Ủi đồ của bé ở nhiệt độ vừa phải, tốt nhất nên dùng chế độ là bằng hơi nước.\r\n\r\n– Không sử dụng loại móc treo quá to với kích thước quần áo bé, móc sắt.','1734891786676-750R-5@2x-100.jpg','LULLABY – Áo gile đệm bông – NH750R',159000,10,'Một lớp bông Êm – Mềm nằm giữa để giữ được hơi ấm cho bé cũng như chống lại những cơn gió lạnh mùa đông.Chất liệu hoàn hảo cho mùa đông của Bé.',0,2,1),(32,'BST Quilt Jacquard by Lul\r\n\r\nMột lớp bông Êm – Mềm nằm giữa để giữ được hơi ấm cho bé cũng như chống lại những cơn gió lạnh mùa đông.Chất liệu hoàn hảo cho mùa đông của Bé.\r\n\r\nLớp vải bề mặt 100% Cotton: thấm hút, thân thiện với làn da cùng lớp bông nhẹ như mây sẽ giúp bé thoải mái nô đùa và luôn năng động, dù trong những ngày đông lạnh.\r\n\r\nBộ sưu tập được chứng nhận OEKO-TEX 100 CLASS I, chứng nhận quốc tế cao nhất và an toàn nhất về sản phẩm dệt may cho trẻ sơ sinh và trẻ nhỏ.\r\n\r\nCác mẹ tham khảo bảng size để chọn size cho bé nhé:\r\n\r\nSize 1 – 3M: 4 – 6Kg cao 54 – 62cm\r\n\r\nSize 3 – 6M: 6-8Kg cao 62 – 69cm\r\n\r\nSize 6 – 9M: 8-9Kg cao 69 – 72cm\r\n\r\nSize 9 – 12M: 9-10Kg cao 72 – 76cm\r\n\r\nHướng dẫn giặt là, bảo quản:\r\n\r\nLullaby mách nhỏ Mẹ một số bí quyết để giữ bộ quần áo 100% cotton của bé luôn sạch sẽ, bền màu:\r\n\r\n1. Phương pháp giặt:\r\n\r\n– Giặt máy (phù hợp với những trang phục đơn giản, ít như tiết phức tạp như phụ kiện, hình thêu,…)\r\n\r\n+ Xử lý các vết bẩn khó giặt ở cổ áo, nách riêng biệt trước khi cho vào máy.\r\n\r\n+ Nên sử dụng túi lưới có kíchcỡ phù hợp\r\n\r\n+ Giặt ở chế độ nhẹ\r\n\r\n+ Vắt trong 1-2 phút bằng chế độ giặt ly tâm để hạn chế độ giãn của cotton.\r\n\r\n– Giặt tay: Giặt nhẹ tay, không vò xát mạnh\r\n\r\n– Khigiặt đồ của bé dù bằng tay hay bằng máy, Mẹ nên sử dụng chất tẩy rửa trung tính, tốt nhất là loại nước giặt dành riêng cho trẻ em.\r\n\r\n– Hạn chế sử dụng nước nóng để tránh ảnh hưởng đến độ co giãn của sản phẩm, nên dùng nước ấm ở nhiệt độ tầm 30 độ C.\r\n\r\n2. Phơi, sấy khô, là ủi:\r\n\r\n– Sau khi giặt xong, nên phơi/sấy quần áo của bé ngay, vì cotton là sợi tự nhiên nên để ủ lâu trong chậu/máy giặt ẩm ướt sẽ dễ sinh nấm mốc, vi khuẩn.\r\n\r\n– Phơi quần áo của bé ở nơi thoáng mát, tránh tiếp xúc với ánh sáng mặt trời gay gắt.\r\n\r\n–  Mùa đông có thể sử dụng máy sấy nhưng hạn chế sấy ở nhiệt độ quá cao.\r\n\r\n– Ủi đồ của bé ở nhiệt độ vừa phải, tốt nhất nên dùng chế độ là bằng hơi nước.\r\n\r\n– Không sử dụng loại móc treo quá to với kích thước quần áo bé, móc sắt.','1734891887989-750R-2@2x-100.jpg','LULLABY – Áo gile đệm bông màu hồng – NH750R',159000,10,'Một lớp bông Êm – Mềm nằm giữa để giữ được hơi ấm cho bé cũng như chống lại những cơn gió lạnh mùa đông.Chất liệu hoàn hảo cho mùa đông của Bé.',0,2,2),(33,NULL,'1735248668853-docker-compose.yaml_vd.png','test',319999,10,NULL,0,1,1),(34,NULL,'1738163028421-brand-logo.png','test123',200000,8,NULL,0,2,3),(35,NULL,'1738417602507-empty_state.png','tesst',1000,10,NULL,0,1,2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin có toàn quyền','Admin'),(2,'User chỉ có quyền mua sắm','User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,'Mới sinh'),(2,'0-3 tháng'),(3,'3-6 tháng'),(4,'6-12 tháng'),(5,'6-9 tháng'),(6,'9-12 tháng'),(7,'12-18 tháng'),(8,'0-1 tháng'),(9,'1-3 tháng'),(10,'0-6 tháng');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `authen_provider` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'1738942353760-138647849_879885659497488_5462443423758691429_n.jpg','admin@gmail.com','TrTr','$2a$10$jhmy6saa5x9ABDfVm1k48ekoyF2NRW6SeuQ8EMGHKzaSfDXbGTO1e','0359924897',1,NULL,'male',_binary ''),(12,'1738961032182-17244.JPG','user@gmail.com','user','$2a$10$e4whk/CItgZbFm.le4Tl2uuS.ARdRQKrQrvXlE64fH5WITSMr82Bm',NULL,2,NULL,'male',_binary '\0'),(16,'1734899533925-images.jpg','hieungangao@gmail.com','Lưu Hiếu Ngân','$2a$10$N3kw3FjyCXw2OJ84R6nVweOXY.6ZL7W.SPhuar6Bod4mS9IFgVQJy',NULL,2,NULL,NULL,_binary '\0'),(21,'1738551717561-189081963.png','truongcongquoctrieu2912@gmail.com','trieu2912','$2a$10$bbn0vfMF.E.MwcnKsSWLt.mvKASXn11TJOUAUQtR4Z9mGk7JGTkC2',NULL,2,'GitHub',NULL,_binary '\0'),(23,'1739727107640-ACg8ocIwknWDQ0xjuFojmddatx2r4QBpfOh9ToQ_W10F5PmhMHG0d9s=s96-c.png','safie.shop.babycloth@gmail.com','Trieu','$2a$10$zV8EjRRcBgyeBn4wJKtD0u3QcSeODlM7LieWAxYdcw4pk8TcYZop2',NULL,2,'Google',NULL,_binary '\0'),(40,'1740233616669-ACg8ocK3qOrgUa96dRyovXu-7f_1tCFtb3sur3i2hL2d1ZF7FBlhDEWW=s96-c.png','quoctrieu9a434@gmail.com','Quoc Trieu','$2a$10$GrUNXDdoQAqBmvThMzCUd.NfEPsKG6sbNKdUSgwDK8lEhXV.ZTMWS',NULL,2,'Local',NULL,_binary '');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_user_token`
--

DROP TABLE IF EXISTS `verify_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verify_user_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_b0flca89iqe0pej1co93yiiti` (`user_id`),
  UNIQUE KEY `UK_2s4xmtsnxysq95e8hnc4jcdch` (`token`),
  CONSTRAINT `FKkosem85fmgwi4m774hvfl6tsh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_user_token`
--

LOCK TABLES `verify_user_token` WRITE;
/*!40000 ALTER TABLE `verify_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laptopshopdb'
--

--
-- Dumping routines for database 'laptopshopdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-25 19:38:56
