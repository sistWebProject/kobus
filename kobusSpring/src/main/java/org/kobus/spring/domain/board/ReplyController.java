package org.kobus.spring.domain.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.kobus.spring.domain.member.UserMapper;
import org.kobus.spring.service.board.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserMapper userMapper;  // 로그인한 id로 kusID 조회

    @GetMapping("/replyList.do")
    public String replyList(@RequestParam("brdID") int brdID,
                            HttpSession session,
                            Model model) {
        List<CommentDTO> comments = replyService.getCommentsByBoardId(brdID);
        model.addAttribute("comments", comments);

        // ✅ 로그인 사용자 ID 직접 전달
        String loginKusID = (String) session.getAttribute("auth");
        model.addAttribute("loginKusID", loginKusID);  // 여기에 핵심 있음

        return "board_reply/replyList";
    }

    
    @PostMapping("/replyWrite.do")
    @ResponseBody
    public String write(@RequestParam("brdID") int brdID,
                        @RequestParam("content") String content,
                        HttpSession session) {

        String loginId = (String) session.getAttribute("auth");
        if (loginId == null) 
        return "kobus.login/logonMain";

        String kusID = userMapper.getKusIDById(loginId);
        if (kusID == null) 
        return "kobus.login/logonMain";

        CommentDTO dto = new CommentDTO();
        dto.setBrdID(brdID);
        dto.setKusID(kusID);
        dto.setContent(content);

        replyService.insertComment(dto);
        return "success";
    }

    @PostMapping("/replyEdit.do")
    @ResponseBody
    public String editReply(@RequestParam int bcmID, @RequestParam String content,
                            HttpSession session) {
        String kusID = (String) session.getAttribute("auth");
        CommentDTO dto = new CommentDTO();
        dto.setBcmID(bcmID);
        dto.setContent(content);
        dto.setKusID(kusID);
        
        int result = replyService.updateComment(dto);
        return result > 0 ? "success" : "fail";
    }

    @PostMapping("/replyDelete.do")
    @ResponseBody
    public String deleteReply(@RequestParam int bcmID, HttpSession session) {
        String kusID = (String) session.getAttribute("auth");
        int result = replyService.deleteComment(bcmID, kusID);
        return result > 0 ? "success" : "fail";
    }


}
