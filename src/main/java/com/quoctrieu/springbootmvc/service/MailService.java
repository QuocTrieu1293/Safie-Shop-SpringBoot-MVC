package com.quoctrieu.springbootmvc.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.util.UriComponentsBuilder;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.OrderDetail;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.annotation.PostConstruct;
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

  @Value("${app.url}")
  private String appUrl;

  private static String APP_URL;

  @PostConstruct
  private void postConstruct() {
    APP_URL = appUrl;
  }

  private enum MailType {
    VERIFY_REGISTRATION(
        new MailConfig("Xác thực tài khoản", String.format("%s/verifyRegistration/verify", APP_URL),
            "Chào %s! Gửi bạn đường dẫn xác thực tài khoản", "Xác thực")),
    SET_PASSWORD(
        new MailConfig("Thiết lập mật khẩu", String.format("%s/profile/account/password/reset", APP_URL),
            "Chào %s! Gửi bạn đường dẫn thiết lập mật khẩu", "Thiết lập"));

    private final MailConfig mailConfig;

    MailType(MailConfig mailConfig) {
      this.mailConfig = mailConfig;
    }

    public MailConfig getMailConfig() {
      return this.mailConfig;
    }
  }

  private final String VERIFY_ORDER_MAIL = "/WEB-INF/views/template/verifyOrderMail.jsp";
  private final String VERIFY_ORDER_MAIL_SUBJECT = "Xác nhận đơn hàng";

  private final String VERIFY_TOKEN_MAIL = "/WEB-INF/views/template/verifyTokenMail.jsp";

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
    String htmlString = renderHtmlJspTemplate(VERIFY_ORDER_MAIL,
        Map.of("order", order, "appUrl", APP_URL));
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

  private void sendVerifyTokenMail(VerifyUserToken verifyToken, MailType mailType)
      throws MessagingException, ServletException, IOException {
    User user = verifyToken.getUser();
    MailConfig mailConfig = mailType.getMailConfig();

    MimeMessage message = mailSender.createMimeMessage();
    MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");

    helper.setFrom(fromAddress);
    helper.setTo(user.getEmail());
    helper.setPriority(1);
    helper.setSubject(mailConfig.getSubject());
    helper.setSentDate(new Date());

    String verifyUrl = UriComponentsBuilder.fromHttpUrl(mailConfig.getUrl())
        .queryParam("token", verifyToken.getToken())
        .toUriString();
    String mailMessage = String.format(mailConfig.getMessageTemplate(), user.getFullName());
    Map<String, Object> model = new HashMap<>();
    model.put("verifyUrl", verifyUrl);
    model.put("message", mailMessage);
    model.put("buttonLabel", mailConfig.getButtonLabel());
    model.put("appUrl", APP_URL);
    String htmlString = renderHtmlJspTemplate(VERIFY_TOKEN_MAIL, model);
    helper.setText(htmlString, true);

    mailSender.send(message);
  }

  public void sendVerifyRegistrationMail(VerifyUserToken verifyToken)
      throws MessagingException, ServletException, IOException {
    sendVerifyTokenMail(verifyToken, MailType.VERIFY_REGISTRATION);
  }

  public void sendSetPasswordMail(VerifyUserToken verifyToken)
      throws MessagingException, ServletException, IOException {
    sendVerifyTokenMail(verifyToken, MailType.SET_PASSWORD);
  }

  private static class MailConfig {
    private String subject;
    private String url;
    private String messageTemplate;
    private String buttonLabel;

    public MailConfig() {
    }

    public MailConfig(String subject, String url, String messageTemplate, String buttonLabel) {
      this.subject = subject;
      this.url = url;
      this.messageTemplate = messageTemplate;
      this.buttonLabel = buttonLabel;
    }

    public String getSubject() {
      return subject;
    }

    public void setSubject(String subject) {
      this.subject = subject;
    }

    public String getUrl() {
      return url;
    }

    public void setUrl(String url) {
      this.url = url;
    }

    public String getMessageTemplate() {
      return messageTemplate;
    }

    public void setMessageTemplate(String messageTemplate) {
      this.messageTemplate = messageTemplate;
    }

    public String getButtonLabel() {
      return buttonLabel;
    }

    public void setButtonLabel(String buttonLabel) {
      this.buttonLabel = buttonLabel;
    }

  }
}
