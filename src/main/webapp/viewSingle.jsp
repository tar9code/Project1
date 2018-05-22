<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery.TooManyResultsException" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
    	<div class="container-fluid">
      		<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
      		</a>
	      	<a class="brand" href="#">Tweeter for FB</a>
	      	<div class="btn-group pull-right" id="welcome">
	       		Welcome, <strong><a id="fullname"> </a> </strong> 
            <fb:login-button size="large" autologoutlink="true" scope="public_profile,email,publish_actions,user_friends" onlogin="checkLoginState();">
			</fb:login-button>                      
	       	</div>
	      	<div class="nav-collapse">
	        <ul class="nav">
	          <li class="active"><a href="index.jsp">Home</a></li>
	          <li><a id="friends_tweet" href="./friends.jsp">Friends Tweet</a> </li>
	          <li><a id="friends_top_tweets" href="./topTweets.jsp">Top Tweets of Friends</a> </li>
	        </ul>
	      	</div><!--/.nav-collapse -->
	  	</div>
	</div>
</div>
<%
    String tweet_key = request.getParameter("tweet_key");
	
    if (tweet_key == null) {
    	System.out.println("failure, key == NULL");	
    	%>
    	<script type="text/javascript"> 
    	msg= "fatal no tweet ID provided , this page must be opened by providing a tweet ID using POST- redirecting to home...";
    	console.log(msg);alert(msg); location.href="home.jsp";
    	</script>
    <%
    } else { 
    	System.out.println("got key...");
        DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
        Key tw_key = KeyFactory.stringToKey(tweet_key); 
        String tweet_text="", username="", date="";
 		Long newcount;
        String count = "";
			Entity tweet = ds.get(tw_key);
			 tweet_text = (String) tweet.getProperty("text");
			 newcount = (Long) tweet.getProperty("count");
			 newcount +=1 ;
			 tweet.setProperty("count", newcount);
			 username = (String) tweet.getProperty("username");
			 date = (String) tweet.getProperty("date");
			 ds.put(tweet);
    
			
    %>
    <table>
	<tr>
	  <th>Tweet</th>
	  <th>Date</th> 
	  <th>Poster</th>
	  <th>Count</th>
	</tr>
	<tr>
		<td><%=tweet_text %></td>
		<td><%=date %></td>
		<td><%=username %></td>
		<td><%=newcount %></td>
	</tr>
	</table>
    <%} %>
</body>
</html>