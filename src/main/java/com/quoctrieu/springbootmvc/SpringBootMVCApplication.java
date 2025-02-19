package com.quoctrieu.springbootmvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
// @SpringBootApplication(exclude =
// org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
@EnableAsync
public class SpringBootMVCApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringBootMVCApplication.class, args);
		// System.out.println("hello world");
	}

}
