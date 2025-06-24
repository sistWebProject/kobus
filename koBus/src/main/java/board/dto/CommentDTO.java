package board.dto;

import java.sql.Timestamp;

public class CommentDTO {
    private int cmtID;           // 댓글 ID (시퀀스)
    private int brdID;           // 게시글 ID (외래키)
    private String kusID;        // 작성자 ID (회원 ID)
    private String content;      // 댓글 내용
    private Timestamp cmtDate;   // 작성일 (타임스탬프)

    // 기본 생성자
    public CommentDTO() {}

    // 전체 필드를 매개변수로 받는 생성자 (선택)
    public CommentDTO(int cmtID, int brdID, String kusID, String content, Timestamp cmtDate) {
        this.cmtID = cmtID;
        this.brdID = brdID;
        this.kusID = kusID;
        this.content = content;
        this.cmtDate = cmtDate;
    }

    // Getter / Setter
    public int getCmtID() {
        return cmtID;
    }

    public void setCmtID(int cmtID) {
        this.cmtID = cmtID;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCmtDate() {
        return cmtDate;
    }

    public void setCmtDate(Timestamp cmtDate) {
        this.cmtDate = cmtDate;
    }
}
