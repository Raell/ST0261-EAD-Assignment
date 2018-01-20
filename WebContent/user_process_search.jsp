<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="Base64.*"%>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileOutputStream" %> 
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.IOException" %>        
<% 
String searchString     = request.getParameter("search_string"); 
String searchGenre      = request.getParameter("search_genre");
String displaySearch;

if(request.getParameter("search_string") == null) {
    displaySearch = "";
} else {
    displaySearch = StringEscapeUtils.escapeHtml4(searchString);
}
%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                padding-top: 60px;
            }
        </style>
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css">
        <link rel="stylesheet" href="css/main.css">

        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">SPMovy</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <li><a href="index.html">Home</a></li>
                            <li class="active"><a href="user_process_search.jsp">Search</a></li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <h2>Currently searching for: <%=displaySearch %></h2>
                <form class="form-search" action="user_process_search.jsp" method="get">
                    <div class="input-append">
                        <input type="text" class="span4 search-query" name="search_string"/>
                        <button type="submit" class="btn btn-inverse">
                            <i class="icon-search icon-white"></i>
                        </button>
                    </div>
                    <%@ include file = "globalGetGenreCombobox.jsp" %>
                </form>
                <table class="table table-hover">
                    <tr>
                        <th></th>
                        <th>Title</th>
                        <th>Release Date</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    String connURL                  = "jdbc:mysql://localhost/spmovy?user=root&password=root";
    Connection conn                 = DriverManager.getConnection(connURL);
    
    String searchMovie              = "SELECT movie_id, title, release_date, poster_directory, description " + 
    		                          "FROM movie WHERE title LIKE ? AND genre LIKE ?";
    PreparedStatement pstmt         = conn.prepareStatement(searchMovie);
    
    pstmt.setString(1, "%" + searchString + "%");
    pstmt.setString(2, "%" + searchGenre + "%");
    
    ResultSet rs                    = pstmt.executeQuery();
    
    if(rs.isBeforeFirst()){
        int rowCount = 0;
        while(rs.next()) {
            String movie_id         = rs.getString("movie_id");
            String title            = rs.getString("title");
            String release_date     = rs.getString("release_date");
            String description      = rs.getString("description");
            String poster_path      = rs.getString("poster_directory");
%>   
<tr>
    <td align="center"><img src="<%
    	    if (poster_path.endsWith(".png") || poster_path.endsWith(".jpg") || poster_path.endsWith(".jpeg")) {  
		String filename = poster_path.substring(poster_path.lastIndexOf('/')+1);
		out.print("uploads/" + filename);

    	    	File f = new File(filename);
    	    	if(f.exists() == false) {
    	    		  try {
				/*
					StringBuilder sb = new StringBuilder();
	               			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0_wintcmt\\uploads\\poster\\" + filename)));   
	                		int c = 0;
	                		while((c = br.read()) != -1) {
	                			sb.append((char) c);
	                		}
	                		br.close();
	                		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0_wintcmt\\webapps\\spmovy\\uploads\\" + filename)));
	                		bw.write(sb.toString());
	                		bw.close();
				*/
				InputStream inStream = new FileInputStream(new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0_wintcmt\\uploads\\poster\\" + filename));
    	                	OutputStream outStream = new FileOutputStream(new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0_wintcmt\\webapps\\spmovy\\uploads\\" + filename));
    	                
    	               		int bufferSize;
				byte[] buffer = new byte[8192];
    	                	while ((bufferSize = inStream.read(buffer)) > 0){
    	                   		outStream.write(buffer, 0, bufferSize);
    	               		}
    	                	inStream.close();
    	                	outStream.close();
    	    		} catch (Exception e) {out.print(e.getMessage());}
    	    	}
    	    }
    
    %>" alt="NO IMAGE" style="width: 203.5px; max-width:203.5px;" /></td>
    <td><%=title %></td>
    <td><%=release_date %></td>
    <td><%=description %></td>
    <td>
        <form action="user_movie_details.jsp" method="post" style="display: inline;">
            <input class=" btn btn-primary" name="details_button" type="submit" value="Details"/>
            <input type="hidden" name="movie_id" value=<%=movie_id %>>
        </form>
    </td>
</tr>
<%
            rowCount++;
        }
        }
    
} catch(Exception e) {
    System.err.println("Error: " + e);
}
%>
        </table>     
        </div>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.js"><\/script>')</script>

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/main.js"></script>
    </body>
</html>
