package board.dto;

import java.sql.Date;

public class NoticeDTO {
    private String notID;
    private String topic;
    private String content;
    private Date notDate;

    public String getNotID() { return notID; }
    public void setNotID(String notID) { this.notID = notID; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getNotDate() { return notDate; }
    public void setNotDate(Date notDate) { this.notDate = notDate; }
}
