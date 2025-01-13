package com.quoctrieu.springbootmvc.service;

import java.util.List;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.OrderDetail;
import com.quoctrieu.springbootmvc.domain.Order_;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.Size;
import com.quoctrieu.springbootmvc.domain.dto.CheckoutDTO;
import com.quoctrieu.springbootmvc.domain.dto.OrderCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.CartDetailRepository;
import com.quoctrieu.springbootmvc.repository.CartRepository;
import com.quoctrieu.springbootmvc.repository.OrderDetailRepository;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.specification.OrderSpecs;

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
    // newOrder.setDate(LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh")));
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

  public Page<Order> getPageWithSpec(OrderCriteriaDTO orderCriteria) {
    Sort sort = switch (orderCriteria.getSort()) {
      case "newest-created" -> Sort.by(Order_.DATE).descending();
      case "oldest-created" -> Sort.by(Order_.DATE).ascending();
      case "recently-updated" -> Sort.by(Order_.LAST_MODIFIED).descending();
      case "oldest-updated" -> Sort.by(Order_.LAST_MODIFIED).ascending();
      default -> Sort.by(Sort.Order.desc(Order_.DATE), Sort.Order.desc(Order_.LAST_MODIFIED));
    };
    PageRequest pageRequest = UtilsService.getPageRequest(orderCriteria.getPage(), orderCriteria.getPageSize());
    Specification<Order> spec = Specification.where(OrderSpecs.getByUser(orderCriteria.getUserId()))
        .and(OrderSpecs.getByStatus(orderCriteria.getStatus()))
        .and(OrderSpecs.getByDateBetween(orderCriteria.getFrom(), orderCriteria.getTo()))
        .and(OrderSpecs.getBySearch(orderCriteria.getSearch()));
    return orderRepository.findAll(spec, pageRequest.withSort(sort));
  }

}
