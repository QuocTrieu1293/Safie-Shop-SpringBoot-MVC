package com.quoctrieu.springbootmvc;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.repository.CategoryRepository;
import com.quoctrieu.springbootmvc.service.CartService;
import com.quoctrieu.springbootmvc.service.CategoryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class SpringBootMVCApplicationTests {

    @Autowired
    CartService cartService;

    @Test
    void contextLoads() {
        Cart cart = cartService.get(13);
        List<CartDetail> cd = cart.getCartDetails();
        System.out.println(cd);
    }

}
