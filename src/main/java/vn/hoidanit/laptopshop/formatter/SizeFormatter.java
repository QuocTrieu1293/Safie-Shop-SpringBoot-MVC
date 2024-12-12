package vn.hoidanit.laptopshop.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import vn.hoidanit.laptopshop.domain.Size;

public class SizeFormatter implements Formatter<Size> {

  @Override
  public String print(Size object, Locale locale) {
    // String value = Long.toString(object.getId());
    // System.out.println("SizeFormatter print(): " + object + " - " + value);
    return null;
  }

  @Override
  public Size parse(String text, Locale locale) throws ParseException {
    Size object = new Size();
    object.setId(Long.parseLong(text));
    System.out.println("SizeFormatter parse(): " + text + " - " + object);
    return object;
  }

}
