package board.dao;

import java.util.List;
import board.dto.CommentDTO;

public interface CommentDAO {
    int insertComment(CommentDTO dto) throws Exception;

    List<CommentDTO> getCommentsByBoardID(int brdID) throws Exception;
}
