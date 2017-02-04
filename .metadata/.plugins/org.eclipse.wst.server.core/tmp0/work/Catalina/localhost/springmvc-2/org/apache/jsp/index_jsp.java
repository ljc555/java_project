package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("<script type=\"text/javascript\" src=\"scripts/jquery-1.9.1.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t$(function(){\r\n");
      out.write("\t\t$(\"#testJson\").click(function(){\r\n");
      out.write("\t\t\tvar url = this.href;\r\n");
      out.write("\t\t\tvar args = {};\r\n");
      out.write("\t\t\t$.post(url, args, function(data){\r\n");
      out.write("\t\t\t\tfor(var i = 0; i < data.length; i++){\r\n");
      out.write("\t\t\t\t\tvar id = data[i].id;\r\n");
      out.write("\t\t\t\t\tvar lastName = data[i].lastName;\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\talert(id + \": \" + lastName);\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t});\r\n");
      out.write("\t})\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t\r\n");
      out.write("\t<form action=\"testFileUpload\" method=\"POST\" enctype=\"multipart/form-data\">\r\n");
      out.write("\t\tFile: <input type=\"file\" name=\"file\"/>\r\n");
      out.write("\t\tDesc: <input type=\"text\" name=\"desc\"/>\r\n");
      out.write("\t\t<input type=\"submit\" value=\"Submit\"/>\r\n");
      out.write("\t</form>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t\r\n");
      out.write("\t<a href=\"emps\">List All Employees</a>\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t\r\n");
      out.write("\t<a href=\"testJson\" id=\"testJson\">Test Json</a>\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t\r\n");
      out.write("\t<form action=\"testHttpMessageConverter\" method=\"POST\" enctype=\"multipart/form-data\">\r\n");
      out.write("\t\tFile: <input type=\"file\" name=\"file\"/>\r\n");
      out.write("\t\tDesc: <input type=\"text\" name=\"desc\"/>\r\n");
      out.write("\t\t<input type=\"submit\" value=\"Submit\"/>\r\n");
      out.write("\t</form>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t\r\n");
      out.write("\t<a href=\"testResponseEntity\">Test ResponseEntity</a>\r\n");
      out.write("\t\r\n");
      out.write("\t<!--  \r\n");
      out.write("\t\t关于国际化:\r\n");
      out.write("\t\t1. 在页面上能够根据浏览器语言设置的情况对文本(不是内容), 时间, 数值进行本地化处理\r\n");
      out.write("\t\t2. 可以在 bean 中获取国际化资源文件 Locale 对应的消息\r\n");
      out.write("\t\t3. 可以通过超链接切换 Locale, 而不再依赖于浏览器的语言设置情况\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t解决:\r\n");
      out.write("\t\t1. 使用 JSTL 的 fmt 标签\r\n");
      out.write("\t\t2. 在 bean 中注入 ResourceBundleMessageSource 的示例, 使用其对应的 getMessage 方法即可\r\n");
      out.write("\t\t3. 配置 LocalResolver 和 LocaleChangeInterceptor\r\n");
      out.write("\t-->\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t<a href=\"i18n\">I18N PAGE</a>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t<a href=\"testExceptionHandlerExceptionResolver?i=10\">Test ExceptionHandlerExceptionResolver</a>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t<a href=\"testResponseStatusExceptionResolver?i=10\">Test ResponseStatusExceptionResolver</a>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t<a href=\"testDefaultHandlerExceptionResolver\">Test DefaultHandlerExceptionResolver</a>\r\n");
      out.write("\t\r\n");
      out.write("\t<br><br>\r\n");
      out.write("\t<a href=\"testSimpleMappingExceptionResolver?i=2\">Test SimpleMappingExceptionResolver</a>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
