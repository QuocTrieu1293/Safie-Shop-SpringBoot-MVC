<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://sargue.net/jsptags/time" prefix="javatime" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html
  xmlns:v="urn:schemas-microsoft-com:vml"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  lang="vi-VN"
>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900"
      rel="stylesheet"
      type="text/css"
    />
    <style>
      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        padding: 0;
      }

      a[x-apple-data-detectors] {
        color: inherit !important;
        text-decoration: inherit !important;
      }

      #MessageViewBody a {
        color: inherit;
        text-decoration: none;
      }

      p {
        line-height: inherit;
      }

      .desktop_hide,
      .desktop_hide table {
        mso-hide: all;
        display: none;
        max-height: 0px;
        overflow: hidden;
      }

      .image_block img + div {
        display: none;
      }

      sup,
      sub {
        font-size: 75%;
        line-height: 0;
      }

      @media (max-width: 620px) {
        .desktop_hide table.icons-inner,
        .row-5 .column-2 .block-3.button_block .alignment .button,
        .row-7 .column-2 .block-3.button_block .alignment .button,
        .row-9 .column-2 .block-3.button_block .alignment .button,
        .social_block.desktop_hide .social-table {
          display: inline-block !important;
        }

        .icons-inner {
          text-align: center;
        }

        .icons-inner td {
          margin: 0 auto;
        }

        .mobile_hide {
          display: none;
        }

        .row-content {
          width: 100% !important;
        }

        .stack .column {
          width: 100%;
          display: block;
        }

        .mobile_hide {
          min-height: 0;
          max-height: 0;
          max-width: 0;
          overflow: hidden;
          font-size: 0px;
        }

        .desktop_hide,
        .desktop_hide table {
          display: table !important;
          max-height: none !important;
        }

        .row-3 .column-1 .block-1.heading_block h2 {
          font-size: 24px !important;
        }

        .row-2 .column-1 .block-1.heading_block h1 {
          font-size: 28px !important;
        }

        .row-2 .column-1 .block-2.paragraph_block td.pad > div {
          font-size: 15px !important;
        }

        .row-12 .column-1 .block-3.paragraph_block td.pad,
        .row-12 .column-1 .block-4.paragraph_block td.pad,
        .row-2 .column-1 .block-2.paragraph_block td.pad {
          padding: 10px 20px !important;
        }

        .row-5 .column-2 .block-1.paragraph_block td.pad > div,
        .row-5 .column-2 .block-2.paragraph_block td.pad > div,
        .row-7 .column-2 .block-1.paragraph_block td.pad > div,
        .row-7 .column-2 .block-2.paragraph_block td.pad > div,
        .row-9 .column-2 .block-1.paragraph_block td.pad > div,
        .row-9 .column-2 .block-2.paragraph_block td.pad > div {
          text-align: center !important;
          font-size: 15px !important;
        }

        .row-5 .column-2 .block-1.paragraph_block td.pad,
        .row-7 .column-2 .block-1.paragraph_block td.pad,
        .row-9 .column-2 .block-1.paragraph_block td.pad {
          padding: 10px 20px 5px !important;
        }

        .row-12 .column-1 .block-2.paragraph_block td.pad,
        .row-5 .column-2 .block-2.paragraph_block td.pad,
        .row-7 .column-2 .block-2.paragraph_block td.pad,
        .row-9 .column-2 .block-2.paragraph_block td.pad {
          padding: 5px 20px !important;
        }

        .row-5 .column-2 .block-3.button_block td.pad,
        .row-7 .column-2 .block-3.button_block td.pad,
        .row-9 .column-2 .block-3.button_block td.pad {
          padding: 15px 20px 5px !important;
        }

        .row-5 .column-2 .block-3.button_block span,
        .row-7 .column-2 .block-3.button_block span,
        .row-9 .column-2 .block-3.button_block span {
          line-height: 27px !important;
        }

        .row-5 .column-2 .block-3.button_block .alignment,
        .row-7 .column-2 .block-3.button_block .alignment,
        .row-9 .column-2 .block-3.button_block .alignment {
          text-align: center !important;
        }

        .row-12 .column-1 .block-2.paragraph_block td.pad > div,
        .row-12 .column-1 .block-3.paragraph_block td.pad > div,
        .row-12 .column-1 .block-4.paragraph_block td.pad > div {
          font-size: 12px !important;
        }

        .row-2 .column-1,
        .row-3 .column-1 {
          padding: 10px 0 5px !important;
        }

        .row-5 .column-1,
        .row-7 .column-1,
        .row-9 .column-1 {
          padding: 0 !important;
        }

        .row-11 .column-1 {
          padding: 20px 0 30px !important;
        }
      }
    </style>
  </head>

  <body
    class="body"
    style="
      margin: 0;
      padding: 0;
      -webkit-text-size-adjust: none;
      text-size-adjust: none;
      background-color: #c5d6c3;
    "
  >
    <table
      class="nl-container"
      width="100%"
      border="0"
      cellpadding="0"
      cellspacing="0"
      role="presentation"
      style="
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
        background-size: auto;
        background-color: #c5d6c3;
        background-image: none;
        background-position: top left;
        background-repeat: no-repeat;
      "
    >
      <tbody>
        <tr>
          <td>
            <table
              class="row row-1"
              align="center"
              width="100%"
              border="0"
              cellpadding="0"
              cellspacing="0"
              role="presentation"
              style="
                mso-table-lspace: 0pt;
                mso-table-rspace: 0pt;
                background-size: auto;
              "
            >
              <tbody>
                <tr>
                  <td>
                    <table
                      class="row-content stack"
                      align="center"
                      border="0"
                      cellpadding="0"
                      cellspacing="0"
                      role="presentation"
                      style="
                        mso-table-lspace: 0pt;
                        mso-table-rspace: 0pt;
                        background-size: auto;
                        background-color: #c5d6c3;
                        color: #000000;
                        width: 600px;
                        margin: 0 auto;
                      "
                      width="600"
                    >
                      <tbody>
                        <tr>
                          <td
                            class="column column-1"
                            width="100%"
                            style="
                              mso-table-lspace: 0pt;
                              mso-table-rspace: 0pt;
                              font-weight: 400;
                              text-align: left;
                              padding-bottom: 5px;
                              padding-top: 5px;
                              vertical-align: top;
                              border-top: 0px;
                              border-right: 0px;
                              border-bottom: 0px;
                              border-left: 0px;
                            "
                          >
                            <table
                              class="image_block block-1"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 0px;
                                    padding-left: 20px;
                                    padding-right: 20px;
                                    padding-top: 15px;
                                    width: 100%;
                                  "
                                >
                                  <div
                                    class="alignment"
                                    align="center"
                                    style="line-height: 10px"
                                  >
                                    <div style="max-width: 300px">
                                      <a
                                        href="${appUrl}"
                                        target="_blank"
                                        style="outline: none"
                                        tabindex="-1"
                                        ><img
                                          src="https://84dbade219.imgdist.com/pub/bfra/lophwb51/ifr/0w6/u1n/logo.png"
                                          style="
                                            display: block;
                                            height: auto;
                                            border: 0;
                                            width: 100%;
                                            object-fit: cover;
                                          "
                                          width="300"
                                          alt="company logo"
                                          title="company logo"
                                          height="auto"
                                      /></a>
                                    </div>
                                  </div>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
            <table
              class="row row-2"
              align="center"
              width="100%"
              border="0"
              cellpadding="0"
              cellspacing="0"
              role="presentation"
              style="mso-table-lspace: 0pt; mso-table-rspace: 0pt"
            >
              <tbody>
                <tr>
                  <td>
                    <table
                      class="row-content stack"
                      align="center"
                      border="0"
                      cellpadding="0"
                      cellspacing="0"
                      role="presentation"
                      style="
                        mso-table-lspace: 0pt;
                        mso-table-rspace: 0pt;
                        background-color: #c5d6c3;
                        border-radius: 0;
                        color: #000000;
                        width: 600px;
                        margin: 0 auto;
                      "
                      width="600"
                    >
                      <tbody>
                        <tr>
                          <td
                            class="column column-1"
                            width="100%"
                            style="
                              mso-table-lspace: 0pt;
                              mso-table-rspace: 0pt;
                              font-weight: 400;
                              text-align: left;
                              padding-bottom: 15px;
                              padding-top: 0px;
                              vertical-align: middle;
                              border-top: 0px;
                              border-right: 0px;
                              border-bottom: 0px;
                              border-left: 0px;
                            "
                          >
                            <table
                              class="heading_block block-1"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 10px;
                                    padding-left: 20px;
                                    padding-right: 20px;
                                    padding-top: 0px;
                                    text-align: center;
                                    width: 100%;
                                  "
                                >
                                  <h1
                                    style="
                                      margin: 0;
                                      color: #a67c52;
                                      direction: ltr;
                                      font-family: Inter, 'Helvetica Neue',
                                        Helvetica, sans-serif;
                                      font-size: 38px;
                                      font-weight: 500;
                                      letter-spacing: normal;
                                      line-height: 120%;
                                      text-align: center;
                                      margin-top: 0;
                                      margin-bottom: 0;
                                      mso-line-height-alt: 50.4px;
                                    "
                                  >
                                    <span
                                      class="tinyMce-placeholder"
                                      style="white-space: nowrap"
                                      >Thời trang an toàn cho trẻ</span
                                    >
                                  </h1>
                                </td>
                              </tr>
                            </table>
                            <table
                              class="paragraph_block block-2"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                                word-break: break-word;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 15px;
                                    padding-left: 40px;
                                    padding-right: 40px;
                                    padding-top: 15px;
                                  "
                                >
                                  <div
                                    style="
                                      color: #1e2e2a;
                                      direction: ltr;
                                      font-family: Arial, 'Helvetica Neue',
                                        Helvetica, sans-serif;
                                      font-size: 20px;
                                      font-weight: 400;
                                      letter-spacing: 1px;
                                      line-height: 150%;
                                      text-align: center;
                                      mso-line-height-alt: 30px;
                                    "
                                  >
                                    <p style="margin: 0">${message}</p>
                                  </div>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
            <!-- link here -->
            <table
              class="row row-3"
              align="center"
              width="100%"
              border="0"
              cellpadding="0"
              cellspacing="0"
              role="presentation"
              style="mso-table-lspace: 0pt; mso-table-rspace: 0pt"
            >
              <tbody>
                <tr>
                  <td>
                    <table
                      class="row-content stack"
                      align="center"
                      border="0"
                      cellpadding="0"
                      cellspacing="0"
                      role="presentation"
                      style="
                        mso-table-lspace: 0pt;
                        mso-table-rspace: 0pt;
                        background-color: #c5d6c3;
                        border-radius: 0;
                        color: #000000;
                        width: 600px;
                        margin: 0 auto;
                      "
                      width="600"
                    >
                      <tbody>
                        <tr>
                          <td
                            class="column column-1"
                            width="100%"
                            style="
                              mso-table-lspace: 0pt;
                              mso-table-rspace: 0pt;
                              font-weight: 400;
                              text-align: left;
                              padding-bottom: 15px;
                              padding-top: 15px;
                              vertical-align: middle;
                              border-top: 0px;
                              border-right: 0px;
                              border-bottom: 0px;
                              border-left: 0px;
                            "
                          >
                            <table
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 10px;
                                    padding-left: 20px;
                                    padding-right: 20px;
                                    padding-top: 5px;
                                    text-align: center;
                                    width: 100%;
                                  "
                                >
                                  <a
                                    href="${verifyUrl}"
                                    target="_blank"
                                    style="
                                      padding: 8px 15px;
                                      font-family: 'Inter', Tahoma, Verdana,
                                        Segoe, sans-serif;
                                      font-size: 24px;
                                      font-weight: 500;
                                      border-radius: 10px;
                                      border: solid 0.75px #1e2e2a;
                                      background-color: #a97349;
                                      color: white;
                                      box-shadow: 0 0.5rem 1rem
                                        rgba(0, 0, 0, 0.15);
                                      text-decoration: none;
                                      cursor: pointer;
                                    "
                                  >
                                    ${not empty buttonLabel ? buttonLabel :
                                    "Kích hoạt"}
                                  </a>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>

            <table
              class="row row-12"
              align="center"
              width="100%"
              border="0"
              cellpadding="0"
              cellspacing="0"
              role="presentation"
              style="mso-table-lspace: 0pt; mso-table-rspace: 0pt"
            >
              <tbody>
                <tr>
                  <td>
                    <table
                      class="row-content stack"
                      align="center"
                      border="0"
                      cellpadding="0"
                      cellspacing="0"
                      role="presentation"
                      style="
                        mso-table-lspace: 0pt;
                        mso-table-rspace: 0pt;
                        background-color: #c5d6c3;
                        border-radius: 0;
                        color: #000000;
                        width: 600px;
                        margin: 0 auto;
                      "
                      width="600"
                    >
                      <tbody>
                        <tr>
                          <td
                            class="column column-1"
                            width="100%"
                            style="
                              mso-table-lspace: 0pt;
                              mso-table-rspace: 0pt;
                              font-weight: 400;
                              text-align: left;
                              padding-bottom: 30px;
                              padding-top: 30px;
                              vertical-align: top;
                              border-top: 0px;
                              border-right: 0px;
                              border-bottom: 0px;
                              border-left: 0px;
                            "
                          >
                            <table
                              class="social_block block-1"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 10px;
                                    padding-left: 20px;
                                    padding-right: 20px;
                                    padding-top: 10px;
                                    text-align: center;
                                  "
                                >
                                  <div class="alignment" align="center">
                                    <table
                                      class="social-table"
                                      width="108px"
                                      border="0"
                                      cellpadding="0"
                                      cellspacing="0"
                                      role="presentation"
                                      style="
                                        mso-table-lspace: 0pt;
                                        mso-table-rspace: 0pt;
                                        display: inline-block;
                                      "
                                    >
                                      <tr>
                                        <td style="padding: 0 2px 0 2px">
                                          <a
                                            href="https://www.facebook.com/trieu.truong.98622"
                                            target="_blank"
                                            ><img
                                              src="https://app-rsrc.getbee.io/public/resources/social-networks-icon-sets/t-only-logo-white/facebook@2x.png"
                                              width="32"
                                              height="auto"
                                              alt="Facebook"
                                              title="facebook"
                                              style="
                                                display: block;
                                                height: auto;
                                                border: 0;
                                                object-fit: cover;
                                              "
                                          /></a>
                                        </td>
                                        <td style="padding: 0 2px 0 2px">
                                          <a
                                            href="https://www.instagram.com/truongcongquoctrieu/"
                                            target="_blank"
                                            ><img
                                              src="https://app-rsrc.getbee.io/public/resources/social-networks-icon-sets/t-only-logo-white/instagram@2x.png"
                                              width="32"
                                              height="auto"
                                              alt="Instagram"
                                              title="instagram"
                                              style="
                                                display: block;
                                                height: auto;
                                                border: 0;
                                                object-fit: cover;
                                              "
                                          /></a>
                                        </td>
                                        <td style="padding: 0 2px 0 2px">
                                          <a
                                            href="https://www.linkedin.com/in/quoc-trieu-129t2003/"
                                            target="_blank"
                                            ><img
                                              src="https://app-rsrc.getbee.io/public/resources/social-networks-icon-sets/t-only-logo-white/linkedin@2x.png"
                                              width="32"
                                              height="auto"
                                              alt="LinkedIn"
                                              title="LinkedIn"
                                              style="
                                                display: block;
                                                height: auto;
                                                border: 0;
                                                object-fit: cover;
                                              "
                                          /></a>
                                        </td>
                                      </tr>
                                    </table>
                                  </div>
                                </td>
                              </tr>
                            </table>
                            <table
                              class="paragraph_block block-2"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                                word-break: break-word;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 15px;
                                    padding-left: 40px;
                                    padding-right: 40px;
                                    padding-top: 5px;
                                  "
                                >
                                  <div
                                    style="
                                      color: #45595b;
                                      direction: ltr;
                                      font-family: 'Ubuntu', Tahoma, Verdana,
                                        Segoe, sans-serif;
                                      font-size: 13px;
                                      font-weight: 300;
                                      letter-spacing: 1px;
                                      line-height: 150%;
                                      text-align: center;
                                      mso-line-height-alt: 19.5px;
                                    "
                                  >
                                    <p style="margin: 0; text-align: justify">
                                      Cảm ơn bạn đã tin tưởng và lựa chọn nhà
                                      Safie. Mong bạn có trải nghiệm thật tốt.
                                      Nếu có thắc mắc, phản hồi từng ngần ngại
                                      nhắn tin cho chúng mình nhé!
                                    </p>
                                  </div>
                                </td>
                              </tr>
                            </table>
                            <table
                              class="paragraph_block block-3"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                                word-break: break-word;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 10px;
                                    padding-left: 40px;
                                    padding-right: 40px;
                                    padding-top: 10px;
                                  "
                                >
                                  <div
                                    style="
                                      color: #45595b;
                                      direction: ltr;
                                      font-family: 'Ubuntu', Tahoma, Verdana,
                                        Segoe, sans-serif;
                                      font-size: 12px;
                                      font-weight: 300;
                                      letter-spacing: 1px;
                                      line-height: 120%;
                                      text-align: center;
                                      mso-line-height-alt: 14.399999999999999px;
                                    "
                                  >
                                    <p style="margin: 0">
                                      &nbsp;Đường Hàn Thuyên, khu phố 6, Tp Thủ
                                      Đức
                                    </p>
                                  </div>
                                </td>
                              </tr>
                            </table>
                            <table
                              class="paragraph_block block-4"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                                word-break: break-word;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    padding-bottom: 10px;
                                    padding-left: 40px;
                                    padding-right: 40px;
                                    padding-top: 10px;
                                  "
                                >
                                  <div
                                    style="
                                      color: #45595b;
                                      direction: ltr;
                                      font-family: 'Ubuntu', Tahoma, Verdana,
                                        Segoe, sans-serif;
                                      font-size: 12px;
                                      font-weight: 300;
                                      letter-spacing: 1px;
                                      line-height: 120%;
                                      text-align: center;
                                      mso-line-height-alt: 14.399999999999999px;
                                    "
                                  >
                                    <p style="margin: 0">© Safie Shop 2025</p>
                                  </div>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
            <table
              class="row row-13"
              align="center"
              width="100%"
              border="0"
              cellpadding="0"
              cellspacing="0"
              role="presentation"
              style="
                mso-table-lspace: 0pt;
                mso-table-rspace: 0pt;
                background-color: #c5d6c3;
              "
            >
              <tbody>
                <tr>
                  <td>
                    <table
                      class="row-content stack"
                      align="center"
                      border="0"
                      cellpadding="0"
                      cellspacing="0"
                      role="presentation"
                      style="
                        mso-table-lspace: 0pt;
                        mso-table-rspace: 0pt;
                        background-color: #c5d6c3;
                        color: #000000;
                        width: 600px;
                        margin: 0 auto;
                      "
                      width="600"
                    >
                      <tbody>
                        <tr>
                          <td
                            class="column column-1"
                            width="100%"
                            style="
                              mso-table-lspace: 0pt;
                              mso-table-rspace: 0pt;
                              font-weight: 400;
                              text-align: left;
                              padding-bottom: 5px;
                              padding-top: 5px;
                              vertical-align: top;
                              border-top: 0px;
                              border-right: 0px;
                              border-bottom: 0px;
                              border-left: 0px;
                            "
                          >
                            <table
                              class="icons_block block-1"
                              width="100%"
                              border="0"
                              cellpadding="0"
                              cellspacing="0"
                              role="presentation"
                              style="
                                mso-table-lspace: 0pt;
                                mso-table-rspace: 0pt;
                                text-align: center;
                                line-height: 0;
                              "
                            >
                              <tr>
                                <td
                                  class="pad"
                                  style="
                                    vertical-align: middle;
                                    color: #1e0e4b;
                                    font-family: 'Inter', sans-serif;
                                    font-size: 15px;
                                    padding-bottom: 5px;
                                    padding-top: 5px;
                                    text-align: center;
                                  "
                                >
                                  <!--[if vml]><table align="center" cellpadding="0" cellspacing="0" role="presentation" style="display:inline-block;padding-left:0px;padding-right:0px;mso-table-lspace: 0pt;mso-table-rspace: 0pt;"><![endif]-->
                                  <!--[if !vml]><!-->
                                  <table
                                    class="icons-inner"
                                    style="
                                      mso-table-lspace: 0pt;
                                      mso-table-rspace: 0pt;
                                      display: inline-block;
                                      padding-left: 0px;
                                      padding-right: 0px;
                                    "
                                    cellpadding="0"
                                    cellspacing="0"
                                    role="presentation"
                                  >
                                    <!--<![endif]-->
                                    <tr>
                                      <td
                                        style="
                                          vertical-align: middle;
                                          text-align: center;
                                          padding-top: 5px;
                                          padding-bottom: 5px;
                                          padding-left: 5px;
                                          padding-right: 6px;
                                        "
                                      >
                                        <a
                                          href="http://designedwithbeefree.com/"
                                          target="_blank"
                                          style="text-decoration: none"
                                          ><img
                                            class="icon"
                                            alt="Beefree Logo"
                                            src="https://d1oco4z2z1fhwp.cloudfront.net/assets/Beefree-logo.png"
                                            height="auto"
                                            width="34"
                                            align="center"
                                            style="
                                              display: block;
                                              height: auto;
                                              margin: 0 auto;
                                              border: 0;
                                              object-fit: cover;
                                            "
                                        /></a>
                                      </td>
                                      <td
                                        style="
                                          font-family: 'Inter', sans-serif;
                                          font-size: 15px;
                                          font-weight: undefined;
                                          color: #1e0e4b;
                                          vertical-align: middle;
                                          letter-spacing: undefined;
                                          text-align: center;
                                          line-height: normal;
                                        "
                                      >
                                        <a
                                          href="http://designedwithbeefree.com/"
                                          target="_blank"
                                          style="
                                            color: #1e0e4b;
                                            text-decoration: none;
                                          "
                                          >Designed with Beefree</a
                                        >
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
    <!-- End -->
  </body>
</html>
