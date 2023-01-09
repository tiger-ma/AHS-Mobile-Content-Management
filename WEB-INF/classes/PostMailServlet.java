/*
 *
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Example servlet sending mail message via JNDI resource.
 *
 * @author Tiger Ma
 *
 */

public class PostMailServlet extends HttpServlet {

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response)
        throws IOException, ServletException
    {

        // Acquire request parameters we need
        String from = request.getParameter("mailfrom");
        String to = request.getParameter("mailto");
        String subject = request.getParameter("mailsubject");
        String content = request.getParameter("mailcontent");

        // Prepare the beginning of our response
        PrintWriter writer = response.getWriter();
        response.setContentType("text/html");
        writer.println("<html>");
        writer.println("<head>");
        writer.println("<title>Mail Sending Results</title>");
        writer.println("</head>");
        writer.println("<body bgcolor=\"pink\">");

        try {

			java.util.Properties prop = System.getProperties();
			prop.put("mail.smtp.host", "aspmx.l.google.com");
            Session session = Session.getInstance(prop, null);

            /* Acquire our JavaMail session object
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            Session session = (Session) envCtx.lookup("mail/Session");
			*/

            // Prepare our mail message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            InternetAddress dests[] = new InternetAddress[]
                { new InternetAddress(to) };
            message.setRecipients(Message.RecipientType.TO, dests);
            message.setSubject(subject);
            message.setContent(content, "text/plain");

            // Send our mail message
            Transport.send(message);

            // Report success
            writer.println("<h3>Email Sent</h3>");

            writer.println("<strong>The AHS App Development Team will review your request(s) shortly.</strong>");

        } catch (Throwable t) {
			//print the current time
			Calendar today = java.util.Calendar.getInstance();
			java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MMM/dd/yyyy HH:mm") ;
			System.out.println(df.format(today.getTime()));

			t.printStackTrace();

           //%writer.println("<strong>System resource for mailing is not available right now. If problem persists, please contact programmers.</strong>");
			
			//String x = t.toString();
			//writer.println(x);
			
			t.printStackTrace(writer);
			String exceptionAsString = writer.toString();
			writer.println(exceptionAsString);
        }

        // Prepare the ending of our response
        writer.println("<br><br>");
        writer.println("<a href=\"http://ahsmobile.ausd.net:8080/AHS-Mobile/request/home.jsp\">BACK</a><br>");
        writer.println("</body>");
        writer.println("</html>");

    }

}
