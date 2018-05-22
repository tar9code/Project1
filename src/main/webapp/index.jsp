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
<link href="../css/bootstrap.min.css" media="all" type="text/css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" media="all" type="text/css" rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet" >
<link href="../css/nav-fix.css" media="all" type="text/css" rel="stylesheet">
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
<title>Insert title here</title>
</head>
<body>
<script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else {
      // The person is not logged into your app or we are unable to tell.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '201214117357434',
      cookie     : true,  // enable cookies to allow the server to access 
                          // the session
      xfbml      : true,  // parse social plugins on this page
      version    : 'v3.0' // use graph api version 2.8
    });

    // Now that we've initialized the JavaScript SDK, we call 
    // FB.getLoginStatus().  This function gets the state of the
    // person visiting this page and can return one of three states to
    // the callback you provide.  They can be:
    //
    // 1. Logged into your app ('connected')
    // 2. Logged into Facebook, but not your app ('not_authorized')
    // 3. Not logged into Facebook and can't tell if they are logged into
    //    your app or not.
    //
    // These three cases are handled in the callback function.

    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
      document.getElementById('userId').value = response.id;

      document.getElementById('userId2').innerHTML = response.id;
      var userId3 = response.id;
      var userName3 = response.name;
      var myImg3 = 
    	  'https://graph.facebook.com/'+ response.id + '/picture';
      document.getElementById('userName').value = response.name;

      document.getElementById('username2').innerHTML = response.name;
      document.getElementById('myImg').src = 
    	  'https://graph.facebook.com/'+ response.id + '/picture';
      document.getElementById('myImg2').value = 
    	  'https://graph.facebook.com/'+ response.id + '/picture';
      
      
      document.getElementById('userid').innerHTML = response.id;
      document.getElementById('username').innerHTML = "" + response.name + "";
      document.getElementById('picture').value = 
    	  'https://graph.facebook.com/'+ response.id + '/picture';
      document.cookie = "username=" + response.name;
	  document.cookie = "profile=" + "https://facebook.com/" + response.id;
	  document.cookie = "picture=" + "http://graph.facebook.com/" + response.id + "/picture?type=large";
    });
    FB.api('/me', function(response) {
        document.getElementById('birthday').innerHTML = response.birthday;
        document.getElementById('image').innerHTML = response.cover;
        document.getElementById('gender').innerHTML = response.gender;
        document.getElementById('age').innerHTML = response.age_range;
      });
  }
  function getFriends() {
	    console.log('Welcome!  Fetching your information.... ');
	    FB.api('/me/friends', function(response) {
	      console.log('Friends list: ' + response.name);
	      document.getElementById('status').innerHTML =
	        'Thanks for logging in, ' + response.name + '!';
	    });
	  }
</script>
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
	          <li class="active"><a href="#">Home</a></li>
	          <li><a id="friends_tweet" href="./friends.jsp">Friends Tweet</a> </li>
	          <li><a id="friends_top_tweets" href="./topTweets.jsp">Top Tweets of Friends</a> </li>
	        </ul>
	      	</div><!--/.nav-collapse -->
	  	</div>
	</div>
</div>
<script>
function submitForm() {
	document.getElementById("post_tweet").submit();
}
function myFunction() {
	FB.ui({   method: 'share',   href: document.getElementById('picture').value, }, function(response){});
	setTimeout("submitForm()", 15000);
}
function myShare() {
	var tweet_text = document.getElementById('tweet_text').value;
	var userid = document.getElementById('userid').value;
	var username = document.getElementById('username').value;
	var picture = document.getElementById('picture').value;
	var msg_tweet = "true";
	/*var post_data = {
			  tweet_text: tweet_text,
			  userid: userid  , 
			  username: username,
			 picture: picture,
			 msg_tweet : "true"
			};*/
	var post_data = {
			  tweet_text: "hi worldsasdf....",
			  userid: "123", 
			  username: "dogs",
			 picture: "coolPic",
			 msg_tweet : "true"
			};
	console.log("try post\n");
	$.post( "TweetServlet", post_data, function(data) {
		console.log(data);
		var key = data;
		var url = window.location.href ;
		if (url.search("localhost")!==-1) {
			url = "https://facebook.com/";
		}
		console.log("try post");
		var share_url = url + "view_tweet.jsp?tweet_key=" + key ;
		console.log(share_url);
		FB.ui({ method: 'send', 
				href: 'https://developers.facebook.com/docs/',
				link: share_url, }, 
				function(response){});
	});
}
function share() {
	var key = "hirandom"
	var url = "https://facebook.com/";
	var share_url = url + "view_tweet.jsp?tweet_key=" + key ;
	FB.ui({ method: 'send', 
		href: document.getElementById('picture').value,
		link: share_url, }, 
		function(response){});

	setTimeout("submitForm()", 15000);
}
var id = "";
var name = "";
var pic = "";
function updateImage() {
	FB.api('/me', function(response) {
	      document.getElementById('myImg').src = 
	    	  'https://graph.facebook.com/'+ response.id + '/picture';
	    });
}
function updateValues(){
	FB.api('/me', function(response) {
		document.getElementById('username').value = response.name;
		document.getElementById('userid').innerHTML = response.id;
		document.getElementById('picture').src = 
			 'https://graph.facebook.com/'+ response.id + '/picture';
		pic = 'https://graph.facebook.com/'+ response.id + '/picture';
		id = response.id;
		name = response.name;

		document.getElementById('userid').value = response.id;
		document.getElementById('picture').value = 
			 'https://graph.facebook.com/'+ response.id + '/picture';
		document.cookie = "userid=" + response.id;
		document.cookie = "username=" + response.name;
		document.cookie = "profile=" + "https://facebook.com/" + response.id;
		document.cookie = "picture=" + "http://graph.facebook.com/" + response.id + "/picture?type=large";
      });
}
function updateValues2(){
	FB.api('/me', function(response) {
		document.getElementById('userId2').innerHTML = response.id;

		document.getElementById('userid').innerHTML = response.id;
		document.getElementById('username2').innerHTML = response.name;
		document.getElementById('picture2').src = 
		 'https://graph.facebook.com/'+ response.id + '/picture';
      });
}
</script>

<div id="userId2"></div>
<div id="username2"></div>
<div id="picture2"></div>
<form method="post" action="TweetServlet" onsubmit="updateValues()" name="post_tweet" id="post_tweet" accept-charset="UTF-8">        
	<input type="hidden" name="userid" id="userid" value="" readonly/>
	<input type="hidden" name="username" id="username" value="" readonly/>
	<input type="hidden" name="picture" id="picture" value="" readonly/>       
	<br>    
	<textarea class="span4" id="tweet_text" name="tweet_text" rows="5" onfocus="updateValues()" placeholder="Type in your new tweet"></textarea>
	<input type="button" name="post_btn" value="Post New Tweet" class="btn btn-info" onfocus="updateValues()" onclick="myFunction()"/>
	<input type="button" name="share_btn" value="Share with friends" class="btn btn-primary" onfocus="updateValues()" onclick="share()"/>
</form> 
<script>
updateValues();
</script>
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
        new FilterPredicate("userid", FilterOperator.EQUAL, name);
	Query query = new Query("Tweet");
	
	query.setFilter(propertyFilter);
	//query.addSort("username",SortDirection.ASCENDING);
	//query.addSort("count", SortDirection.DESCENDING);
	//List<Entity> tweets = datastore.prepare(query).asList(FetchOptions.Builder.withChunkSize(2000));
	//int num_tweets = tweets.size();
	//if (tweets.isEmpty()) {}
	PreparedQuery pq = datastore.prepare(query);
	
	%>
	<table style="width:100%">
	<tr>
	  <th>Tweet</th>
	  <th>Date</th> 
	  <th>Count</th>
	  <th>Delete</th>
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
			<td><%=count %></td>
			<td>
				<form method="post" action="DeleteServlet" name="delete_tweet" accept-charset="UTF-8">     
		            <input type="hidden" name="tweet_key" id="tweet_key" value="<%=key%>"/>    
		            <input type="submit" class="btn btn-danger" value="Delete"/>
		        </form>
        	</td>
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