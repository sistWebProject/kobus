package board.dao;

import java.util.List;
import board.dto.CommentDTO;

public interface CommentDAO {
    // 특정 게시글에 달린 댓글 전체 조회
    List<CommentDTO> getCommentsByBrdID(int brdID) throws Exception;

    // 댓글 등록
    int insertComment(CommentDTO dto) throws Exception;

    // 댓글 삭제
    int deleteComment(int cmtID) throws Exception;

    // (선택) 댓글 수정
    int updateComment(CommentDTO dto) throws Exception;
    
    
}
