package board.dto;

import java.sql.Timestamp;

public class BoardDTO {

    private int brdID; // 게시글 번호 (시퀀스)
    private String kusID; // 작성자 ID (VARCHAR2 타입에 맞춰 String으로 유지)
    private String brdTitle; // 게시글 제목
    private String brdContent; // 게시글 내용
    private Timestamp brdDate; // 작성일
    private int brdViews;    // 게시글 조회수 (NUMBER 타입에 맞춰 int로 추가)
    private String brdCategory; // 게시글 구분 (VARCHAR2 타입에 맞춰 String으로 추가)

    // BoardDTO가 게시글과 작성자 정보를 함께 담는 경우를 위해 유지 (JOIN 시 사용)
    private String userId; // kobusUser 테이블의 ID (로그인 ID)
    private String userTel; // kobusUser 테이블의 전화번호
    private String userRank; // kobusUser 테이블의 등급


    // brdID
    public int getBrdID() {
        return brdID;
    }

    public void setBrdID(int brdID) {
        this.brdID = brdID;
    }

    // kusID (String 타입으로 유지)
    public String getKusID() { // 변경
        return kusID;
    }

    public void setKusID(String kusID) { // 변경
        this.kusID = kusID;
    }

    // brdTitle
    public String getBrdTitle() {
        return brdTitle;
    }

    public void setBrdTitle(String brdTitle) {
        this.brdTitle = brdTitle;
    }

    // brdContent
    public String getBrdContent() {
        return brdContent;
    }

    public void setBrdContent(String brdContent) {
        this.brdContent = brdContent;
    }

    // brdDate
    public Timestamp getBrdDate() {
        return brdDate;
    }

    public void setBrdDate(Timestamp brdDate) {
        this.brdDate = brdDate;
    }

    // brdViews (추가)
    public int getBrdViews() {
        return brdViews;
    }

    public void setBrdViews(int brdViews) {
        this.brdViews = brdViews;
    }

    // brdCategory (추가)
    public String getBrdCategory() {
        return brdCategory;
    }

    public void setBrdCategory(String brdCategory) {
        this.brdCategory = brdCategory;
    }

    // 사용자 정보 필드 (JOIN 시 사용)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }

    public String getUserRank() {
        return userRank;
    }

    public void setUserRank(String userRank) {
        this.userRank = userRank;
    }
}