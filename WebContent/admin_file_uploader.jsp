<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%
	ServletContext context = pageContext.getServletContext();
	String uploadPath = "..\\..\\uploads\\poster\\";
	String filePath = getServletContext().getRealPath("")
			+ File.separator + uploadPath;
	File file;
	int maxFileSize = 10000 * 1024;
	int maxMemSize = maxFileSize;
	String contentType = request.getContentType();
	String filename = "";
	
	if(session.getAttribute("superuser") == null) {
        response.sendRedirect("401.html");
    } else {

		if (contentType != null
				&& (contentType.indexOf("multipart/form-data") >= 0)) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(maxMemSize);
			factory.setRepository(new File("/tmp"));
			ServletFileUpload upload = new ServletFileUpload(factory);
	
			upload.setSizeMax(maxFileSize);
	
			try {
	
				List fileItems = upload.parseRequest(request);
				Iterator i = fileItems.iterator();
	
				while (i.hasNext()) {
					FileItem fi = (FileItem) i.next();
					if(fi.getContentType().matches("image/.+")){
					    if (!fi.isFormField()) {
					    	   String fieldName = fi.getFieldName();
					    	   String fileName = fi.getName();
					    	   filename = fileName;
	
					    	   boolean isInMemory = fi.isInMemory();
					    	   long sizeInBytes = fi.getSize();
	
					    	   if (fileName.lastIndexOf("\\") >= 0) {
					    		   file = new File(filePath
					    				    + fileName.substring(fileName
					    				    		  .lastIndexOf("\\")));
					    		   } else {
					    			   file = new File(filePath
					    					    + fileName.substring(fileName
					    					    		  .lastIndexOf("\\") + 1));
					    		   }

						fi.write(file);
	
						out.println("<script type='text/javascript'>");
						out.println("parent.parent.document.getElementById('upload').value='uploads/poster/"
								+ filename
								+ "'; alert('File has been uploaded!')");
						out.println("</script>");
					    }
					} else {
						out.println("<script type='text/javascript'>");
	                    out.println("alert('Illegal filetype, only images allowed.')");
	                    out.println("</script>");
					}
	
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
</head>
<body style="background: #131415;">
	<form id="uploadform" name="uploadform" enctype="multipart/form-data"
		action="admin_file_uploader.jsp" method="post">
		<table>
			<tr>
				<td align="left"><input type="file" name="file" id="listfile"
					onChange="upload()" accept="image/*"></td>
			</tr>
		</table>
	</form>
	<iframe name="test-iframe" style="visibility: hidden; display: none;"></iframe>
	<script>
		function upload() {
			document.getElementById('uploadform').target = 'test-iframe';
			document.getElementById("uploadform").submit();
		}
		function updateParent() {
			parent.document.getElementById('upload').value = document
					.getElementById('upload').value;
		}
	</script>
</body>
</html>
<%
	    }
    }
%>