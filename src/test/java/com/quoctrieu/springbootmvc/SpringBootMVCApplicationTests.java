package com.quoctrieu.springbootmvc;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.service.CartService;

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
