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
<style>
.inline {
  display: inline;
}

.link-button {
  background: none;
  border: none;
  color: blue;
  text-decoration: underline;
  cursor: pointer;
  font-size: 1em;
  font-family: serif;
}
.link-button:focus {
  outline: none;
}
.link-button:active {
  color:red;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../css/bootstrap.min.css" media="all" type="text/css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" media="all" type="text/css" rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet" >
<link href="../css/nav-fix.css" media="all" type="text/css" rel="stylesheet">

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
<% Cookie[] cookies = request.getCookies();
		String theuserid="", theusername="",thepicture="";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("userid")) {
					theuserid = cookie.getValue();
				}
				if (cookie.getName().equals("username")) {
					theusername = cookie.getValue();
				}
				if (cookie.getName().equals("picture")) {
					thepicture = cookie.getValue();
				}
			}
		}
		
		%>
<% 
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	// Run an ancestor query to ensure we see the most up-to-date
	// view of the Greetings belonging to the selected Guestbook.
	String name = "123";
	name = theuserid;
	Filter propertyFilter =
        new FilterPredicate("userid", FilterOperator.NOT_EQUAL, name);
	Query query = new Query("Tweet");
	
	query.setFilter(propertyFilter);
	//query.addSort("username",SortDirection.ASCENDING);
	//query.addSort("count", SortDirection.DESCENDING);
	//List<Entity> tweets = datastore.prepare(query).asList(FetchOptions.Builder.withChunkSize(2000));
	//int num_tweets = tweets.size();
	//if (tweets.isEmpty()) {}
	PreparedQuery pq = datastore.prepare(query);
	
	%>
	<table>
	<tr>
	  <th>Tweet</th>
	  <th>Date</th> 
	  <th>Poster</th>
	  <th>Count</th>
	</tr>
	<%
	
	for (Entity result : pq.asIterable()) {
		String tweet = (String) result.getProperty("text");
		String userid = (String) result.getProperty("userid");

		String username = (String) result.getProperty("username");

		Long count = (Long) result.getProperty("count");
		String date = (String)result.getProperty("date");
		String id = (String)result.getProperty("id");
		String key = KeyFactory.keyToString(result.getKey());
		String href = "/viewSingle.jsp?tweet_key=" + key;
		%>
		<tr>
			<td>
				<form method="post" action="<%=href %>" class="inline">
				  <input type="hidden" name="key" value="<%=key %>">
				  <button type="submit" name="submit_param" value="submit_value" class="link-button">
				    <%=tweet%>
				  </button>
				</form>
			</td>
			<td><%=date %></td>
			<td><%=username %></td>
			<td><%=count %></td>
		</tr>
		<%
		System.out.println(tweet);

		System.out.println(userid);
		System.out.println(username);
		System.out.println(date);
	}
%>
	</table>
</body>
</html>