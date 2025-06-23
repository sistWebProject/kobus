package board.dto;

import java.sql.Timestamp;

public class CommentDTO {
    private int bcmID;           // 댓글 ID (PK)
    private int brdID;           // 게시글 ID (FK)
    private String kusID;        // 작성자 ID
    private String comContent;   // 댓글 내용
    private Timestamp comDate;   // 작성일시

    public int getBcmID() {
        return bcmID;
    }

    public void setBcmID(int bcmID) {
        this.bcmID = bcmID;
    }

    public int getBrdID() {
        return brdID;
    }

    public void setBrdID(int brdID) {
        this.brdID = brdID;
    }

    public String getKusID() {
        return kusID;
    }

    public void setKusID(String kusID) {
        this.kusID = kusID;
    }

    public String getComContent() {
        return comContent;
    }

    public void setComContent(String comContent) {
        this.comContent = comContent;
    }

    public Timestamp getComDate() {
        return comDate;
    }

    public void setComDate(Timestamp comDate) {
        this.comDate = comDate;
    }
}
