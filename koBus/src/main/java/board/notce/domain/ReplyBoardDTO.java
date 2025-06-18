package board.notce.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyBoardDTO {
    private int num;             // 글번호
    private String writer;       // 작성자
    private String email;        // 이메일
    private String subject;      // 제목
    private String pass;         // 비밀번호
    private int readcount;       // 조회수
    private Date regdate;        // 작성일
    private String content;      // 내용
    private String ip;           // IP주소

    private int ref;             // 그룹 번호
    private int step;            // 순번
    private int depth;           // 깊이

    // 기본 생성자
    public ReplyBoardDTO() {}

    // 전체 필드 생성자
    public ReplyBoardDTO(int num, String writer, String email, String subject, String pass,
                         int readcount, Date regdate, String content, String ip,
                         int ref, int step, int depth) {
        this.num = num;
        this.writer = writer;
        this.email = email;
        this.subject = subject;
        this.pass = pass;
        this.readcount = readcount;
        this.regdate = regdate;
        this.content = content;
        this.ip = ip;
        this.ref = ref;
        this.step = step;
        this.depth = depth;
    }

    public int getNum() { return num; }
    public void setNum(int num) { this.num = num; }

    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getPass() { return pass; }
    public void setPass(String pass) { this.pass = pass; }

    public int getReadcount() { return readcount; }
    public void setReadcount(int readcount) { this.readcount = readcount; }

    public Date getRegdate() { return regdate; }
    public void setRegdate(Date regdate) { this.regdate = regdate; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getIp() { return ip; }
    public void setIp(String ip) { this.ip = ip; }

    public int getRef() { return ref; }
    public void setRef(int ref) { this.ref = ref; }

    public int getStep() { return step; }
    public void setStep(int step) { this.step = step; }

    public int getDepth() { return depth; }
    public void setDepth(int depth) { this.depth = depth; }
}
