package com.example.proyecto.daos;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
public class EnvioCorreosDaos extends DaoBase{
    private static final String emailFrom = "teleweek0@gmail.com";
    private static final String passwordFrom = "pwmvogowswkhbqlx";
    private static  String emailTo;
    private static  String subject;
    private static  String content;


    public static String getEmailTo() {
        return emailTo;
    }

    public static void setEmailTo(String emailTo) {
        EnvioCorreosDaos.emailTo = emailTo;
    }

    public static String getSubject() {
        return subject;
    }

    public static void setSubject(String subject) {
        EnvioCorreosDaos.subject = subject;
    }

    public static String getContent() {
        return content;
    }

    public static void setContent(String content) {
        EnvioCorreosDaos.content = content;
    }

    private Properties properties;
    private Session session;
    private MimeMessage correo;

    public EnvioCorreosDaos() {
        properties = new Properties();
    }

    public void createEmail(String emailTo, String asunto, String contenido) {
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.user", emailFrom);
        properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        properties.setProperty("mail.smtp.auth", "true");

        session = Session.getDefaultInstance(properties);

        EnvioCorreosDaos.setEmailTo(emailTo);
        EnvioCorreosDaos.setSubject(asunto);
        EnvioCorreosDaos.setContent(contenido);

        try {
            correo = new MimeMessage(session);
            correo.setFrom(new InternetAddress(emailFrom));
            correo.setRecipient(Message.RecipientType.TO, new InternetAddress(emailTo));
            correo.setSubject(subject);
            correo.setText(content, "ISO-8859-1", "html");

        } catch (AddressException ex) {
            Logger.getLogger(EnvioCorreosDaos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(EnvioCorreosDaos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void sendEmail() {
        try {
            Transport transport = session.getTransport("smtp");
            transport.connect(emailFrom, passwordFrom);
            transport.sendMessage(correo, correo.getRecipients(Message.RecipientType.TO));
            transport.close();

            //System.out.println("Correo enviado");
        } catch (NoSuchProviderException ex) {
            Logger.getLogger(EnvioCorreosDaos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(EnvioCorreosDaos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
