package vn.hoidanit.laptopshop.service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Size;
import vn.hoidanit.laptopshop.domain.dto.CheckoutDTO;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

  private final OrderRepository orderRepository;
  private final OrderDetailRepository orderDetailRepository;
  private final CartService cartService;
  private final CartRepository cartRepository;
  private final CartDetailRepository cartDetailRepository;

  public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository,
      CartService cartService, CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
    this.orderRepository = orderRepository;
    this.orderDetailRepository = orderDetailRepository;
    this.cartService = cartService;
    this.cartRepository = cartRepository;
    this.cartDetailRepository = cartDetailRepository;
  }

  public Order create(long cartId, CheckoutDTO checkoutDTO) {

    Cart cart = cartService.get(cartId);

    // create new order
    Order newOrder = new Order();
    newOrder.setNotes(checkoutDTO.getOrderNotes());
    newOrder.setReceiverAddress(checkoutDTO.getAddress());
    newOrder.setReceiverName(checkoutDTO.getFullName());
    newOrder.setReceiverPhone(checkoutDTO.getPhone());
    newOrder.setSum(cart.getSum());
    newOrder.setTotalPrice(cartService.getTotalPrice(cartId));
    newOrder.setUser(cart.getUser());

    newOrder.setStatus("PENDING");
    newOrder.setPaymentStatus("PAYMENT_UNPAID");
    String paymentMethod = checkoutDTO.getPaymentMethod();
    newOrder.setPaymentMethod(paymentMethod);
    String paymentRef = UUID.randomUUID().toString().replaceAll("-", "");
    newOrder.setPaymentRef(paymentMethod.equals("COD") ? "UNKNOWN" : paymentRef);
    // newOrder.setDate(LocalDateTime.now(ZoneId.of(ZoneId.SHORT_IDS.get("VST"))));
    newOrder.setDate(LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh")));
    newOrder = orderRepository.save(newOrder);

    // create OrderDetails # Không thể đồng thời thêm OrderDetail và xoá CartDetail
    List<CartDetail> items = cart.getCartDetails();
    if (items != null) {

      for (CartDetail item : items) {
        OrderDetail od = new OrderDetail();
        od.setOrder(newOrder);
        od.setPrice(item.getPrice());
        Product product = item.getProduct();
        od.setProduct(product);
        od.setProductPrice(product.getPrice());
        od.setQuantity(item.getQuantity());
        Size size = item.getSize();
        od.setSize(size);
        orderDetailRepository.save(od);
      }

      // remove CartDetails
      for (CartDetail item : items) {
        cartDetailRepository.deleteById(item.getId());
      }

      cart.setCartDetails(null);
    }

    // clear Cart
    cart.setSum(0);
    cartRepository.save(cart);

    newOrder = orderRepository.findById(newOrder.getId()).orElse(null);
    return newOrder;
  }

  public void delete(long id) {
    Order order = orderRepository.findById(id).orElse(null);
    if (order == null)
      return;
    List<OrderDetail> items = order.getOrderDetails();
    if (items != null) {
      for (OrderDetail item : items)
        orderDetailRepository.delete(item);
    }
    orderRepository.delete(order);
  }

}
