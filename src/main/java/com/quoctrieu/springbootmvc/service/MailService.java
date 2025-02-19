package com.quoctrieu.springbootmvc.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.OrderDetail;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.mail.BodyPart;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

@Service
public class MailService {

  @Value("${spring.mail.username}")
  private String fromAddress;

  private final String VERIFY_ORDER_MAIL = "/WEB-INF/view/template/verifyOrderMail.jsp";
  private final String VERIFY_ORDER_MAIL_SUBJECT = "Xác nhận đơn hàng";

  private final String VERIFY_USER_MAIL = "/WEB-INF/view/template/verifyUserMail.jsp";
  private final String VERIFY_USER_SUBJECT = "Xác thực tài khoản";

  private final JavaMailSender mailSender;
  private final ServletContext servletContext;
  private final HttpServletRequest request;
  private final HttpServletResponse response;

  public MailService(JavaMailSender mailSender, ServletContext servletContext, HttpServletRequest request,
      HttpServletResponse response) {
    this.mailSender = mailSender;
    this.servletContext = servletContext;
    this.request = request;
    this.response = response;
  }

  private String renderHtmlJspTemplate(String templatePath, Map<String, Object> model)
      throws ServletException, IOException {

    for (Map.Entry<String, Object> entry : model.entrySet()) {
      request.setAttribute(entry.getKey(), entry.getValue());
    }
    RequestDispatcher dispatcher = servletContext.getRequestDispatcher(templatePath);
    StringWriter stringWriter = new StringWriter();
    HttpServletResponseWrapper responseWrapper = new HttpServletResponseWrapper(response) {

      @Override
      public PrintWriter getWriter() throws IOException {
        PrintWriter printWriter = new PrintWriter(stringWriter);
        return printWriter;
      }

    };
    dispatcher.include(request, responseWrapper);

    return stringWriter.toString();
  }

  // @Async
  public void sendSimpleMail(String toAddress, String content) throws MailException {
    SimpleMailMessage message = new SimpleMailMessage();
    message.setFrom(fromAddress);
    message.setTo(toAddress);
    message.setSubject("Test mail");
    message.setText(content);
    mailSender.send(message);
  }

  // @Async
  public void sendVerifyOrderMail(Order order)
      throws IOException, ServletException, MessagingException {

    MimeMessage message = mailSender.createMimeMessage();
    MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
    String toAddress = order.getUser().getEmail();
    helper.setFrom(fromAddress);
    helper.setTo(toAddress);
    helper.setSubject(VERIFY_ORDER_MAIL_SUBJECT);

    MimeMultipart mimeMultipart = new MimeMultipart("related");

    BodyPart messageBodyPart = new MimeBodyPart();

    // Thêm code HTML dưới dạng string vào email
    String htmlString = renderHtmlJspTemplate(VERIFY_ORDER_MAIL, Map.of("order", order));
    messageBodyPart.setContent(htmlString, "text/html; charset=UTF-8");
    mimeMultipart.addBodyPart(messageBodyPart);

    // Thêm ảnh sản phẩm vào mail
    List<OrderDetail> orderDetails = order.getOrderDetails();
    for (OrderDetail od : orderDetails) {
      messageBodyPart = new MimeBodyPart();
      Product product = od.getProduct();
      DataSource dataSource = new FileDataSource(
          servletContext.getRealPath("/resources/images/product") + File.separator + product.getImage());
      messageBodyPart.setDataHandler(new DataHandler(dataSource));
      messageBodyPart.setHeader("Content-ID", "<" + String.valueOf(product.getId())
          + ">");
      messageBodyPart.setDisposition(MimeBodyPart.INLINE);
      mimeMultipart.addBodyPart(messageBodyPart);
    }

    message.setContent(mimeMultipart);

    mailSender.send(message);

  }

  public void sendVerifyRegistrationMail(VerifyUserToken verifyToken)
      throws MessagingException, ServletException, IOException {
    MimeMessage message = mailSender.createMimeMessage();
    MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");
    helper.setFrom(fromAddress);
    String toAddress = verifyToken.getUser().getEmail();
    helper.setTo(toAddress);
    helper.setPriority(1);
    helper.setSubject(VERIFY_USER_SUBJECT);
    helper.setSentDate(new Date());

    String htmlString = renderHtmlJspTemplate(VERIFY_USER_MAIL,
        Map.of("verifyToken", verifyToken, "verifyURL",
            "http://localhost:8080/verifyUser/verify?token=" + verifyToken.getToken()));
    helper.setText(htmlString, true);

    // SimpleMailMessage message = new SimpleMailMessage();
    // message.setFrom(fromAddress);
    // String toAddress = verifyToken.getUser().getEmail();
    // message.setTo(toAddress);
    // message.setSubject(VERIFY_USER_SUBJECT);
    // message.setText("http://localhost:8080/verifyUser?token=" +
    // verifyToken.getToken());

    mailSender.send(message);
  }
}
