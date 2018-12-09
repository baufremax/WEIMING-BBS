import java.io.*;
import java.net.*;
 
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
 
@SuppressWarnings("serial")
@WebServlet(name = "xmldownload", urlPatterns = { "/xmldownload" })
public class XmlDownload extends HttpServlet {
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String xml = request.getParameter("xml");
		//在SSH框架中，可以通过HttpServletResponse response=ServletActionContext.getResponse();取出Respond对象
		//清空一下response对象，否则出现缓存什么的
		response.reset();
		//指明这是一个下载的respond
		response.setContentType("application/x-download");
		//这里是提供给用户默认的文件名
		String filename = userName+ "Info.xml";
		//双重解码、防止乱码
		filename = URLEncoder.encode(filename,"UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition","attachment;filename=" + filename);
		/*
		 * 这里是最关键的一步。
		 * 直接把这个东西写到response输出流里面，给用户下载。
		 * 如果输出到c:\b.txt就是：
		 * PrintWriter printwriter = new PrintWriter(new FileWriter("c:\\b.txt",true));
		 * 现在写好respond头，就写成：
		 * PrintWriter printwriter = new PrintWriter(response.getOutputStream());
		 * 把PrintWriter的输出点改一下
		 */
		PrintWriter printwriter = new PrintWriter(response.getOutputStream());
		printwriter.println(xml);
		//打印流的所有输出内容，必须关闭这个打印流才有效
		printwriter.close();
	}
}
