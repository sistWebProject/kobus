package board.dto;

import java.sql.Date;

public class BoardDTO {

	private int brdID; // 게시글 번호 (시퀀스)
	private String kusID; // 작성자 ID
	private String brdTitle; // 게시글 제목
	private Date brdDate; // 작성일
	private String brdContent; // 게시글 내용

	// brdID
	public int getBrdID() {
		return brdID;
	}

	public void setBrdID(int brdID) {
		this.brdID = brdID;
	}

	// kusID
	public String getKusID() {
		return kusID;
	}

	public void setKusID(String kusID) {
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
	public Date getBrdDate() {
		return brdDate;
	}

	public void setBrdDate(Date brdDate) {
		this.brdDate = brdDate;
	}

	private String userId;
	private String userTel;
	private String userRank;

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
