package org.kobus.spring.domain.board;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDTO {
    private int bcmID;          // 댓글 ID (PK)
    private int brdID;          // 게시글 ID (FK)
    private String kusID;       // 작성자 ID
    private String content;     // 댓글 내용
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
    private Timestamp cmtDate;  // 작성일

    
}