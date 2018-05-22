

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.SimpleTimeZone;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.KeyFactory;

/**
 * Servlet implementation class TweetServlet
 */
@WebServlet("/TweetServlet")
public class TweetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TweetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSSSSS");
        fmt.setTimeZone(new SimpleTimeZone(0, ""));
        String date = fmt.format(new Date());
        String tweet_text = request.getParameter("tweet_text");
        String userid = request.getParameter("userid");
        String username = request.getParameter("username");
        String picture = request.getParameter("picture");
        String msg_tweet = request.getParameter("msg_tweet");
        int count = 0;

        System.out.println("hello world");
        System.out.println(userid);
        System.out.println(request.getParameter("userid"));
        System.out.println(username);
        System.out.println(request.getParameter("username"));
        System.out.println(picture);
        System.out.println(request.getParameter("picture"));
        DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
        
        Entity tweet = new Entity("Tweet");

        tweet.setProperty("text", tweet_text);
        tweet.setProperty("userid", userid);
        tweet.setProperty("date", date);
        tweet.setProperty("username", username);
        tweet.setProperty("picture", picture);
        tweet.setProperty("count", count);
        ds.put(tweet);
        String key = KeyFactory.keyToString(tweet.getKey());
        if (msg_tweet != null || msg_tweet == "true") {
        	out.print(key);
        }
        else {
        response.sendRedirect("/index.jsp");
        }
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
