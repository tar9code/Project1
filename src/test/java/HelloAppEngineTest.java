import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Servlet implementation class HelloWorld2Servlet
 */
@WebServlet("/clock")
public class HelloAppEngineTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloAppEngineTest() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request,
    		HttpServletResponse response)
    	throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	// Make custom Date and Time 
    	        

    	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    	String newDate = dateFormat.format(Calendar.getInstance().getTime());
    	try {
	    	/* TODO output your page here */
	    	out.println("<html>");
	    	out.println("<head>");
	    	out.println("<title>" + getServletInfo() + "</title>");
	    	out.println("</head>");
	    	out.println("<body>");
	    	out.println("<h1>Servlet dateTimeServlet at "
	    	               + request.getContextPath() + "</h1>");
	    	/*Browser is refresh in every 1 sec, 
	    	and date/Time is change on every refresh.*/
	    	out.println
	    	 ("<meta http-equiv='refresh' content='1'" + 
	    	"URL='http://localhost:8084/servletExample/dateTimeServlet'> Current date/Time:"
	    	             + newDate);
	    	out.println("</body>");
	    	out.println("</html>");
    	} finally {
    		out.close();
    	}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
