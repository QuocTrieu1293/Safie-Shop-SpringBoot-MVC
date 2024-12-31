package com.quoctrieu.springbootmvc.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import com.quoctrieu.springbootmvc.domain.Size;

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
