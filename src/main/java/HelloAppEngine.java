

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
import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

import java.util.List;

/**
 * Servlet implementation class HelloAppEngine
 */
@WebServlet("/clock")
public class HelloAppEngine extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private FacebookClient facebookClient;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloAppEngine() {
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
	    	out.println("<script>\n" + 
	    			"  window.fbAsyncInit = function() {\n" + 
	    			"    FB.init({\n" + 
	    			"      appId      : '201214117357434',\n" + 
	    			"      xfbml      : true,\n" + 
	    			"      version    : 'v3.0'\n" + 
	    			"    });\n" + 
	    			"    FB.AppEvents.logPageView();\n" + 
	    			"  };\n" + 
	    			"\n" + 
	    			"  (function(d, s, id){\n" + 
	    			"     var js, fjs = d.getElementsByTagName(s)[0];\n" + 
	    			"     if (d.getElementById(id)) {return;}\n" + 
	    			"     js = d.createElement(s); js.id = id;\n" + 
	    			"     js.src = \"https://connect.facebook.net/en_US/sdk.js\";\n" + 
	    			"     fjs.parentNode.insertBefore(js, fjs);\n" + 
	    			"   }(document, 'script', 'facebook-jssdk'));\n" + 
	    			"</script>");
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
		//doGet(request, response);

		doGet(request,response);
		String signedRequest = (String) request.getParameter("signed_request");
		FacebookSignedRequest facebookSR = null;
		try {
			facebookSR = FacebookSignedRequest.getFacebookSignedRequest(signedRequest);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String oauthToken = facebookSR.getOauth_token();
		PrintWriter writer = response.getWriter();
		if(oauthToken == null) {
			
			response.setContentType("text/html");
			String authURL = "https://www.facebook.com/dialog/oauth?client_id="
								+ Constants.API_KEY + "&redirect_uri=https://apps.facebook.com/myoldfriends/&scope=";
			writer.print("<script> top.location.href='"	+ authURL + "'</script>");
			writer.close();

		}
		else {
			
			facebookClient = new DefaultFacebookClient(oauthToken);
			Connection<User> myFriends = facebookClient.fetchConnection("me/friends", User.class);
			writer.print("<table><tr><th>Photo</th><th>Name</th><th>Id</th></tr>");
			for (List<User> myFriendsList : myFriends) {
	
				for(User user: myFriendsList)
					writer.print("<tr><td><img src=\"https://graph.facebook.com/" + user.getId() + "/picture\"/></td><td>" + user.getName() +"</td><td>" + user.getId() + "</td></tr>");
	
			}
			writer.print("</table>");
			writer.close();
			
		}
	}

}
