package koBus.mvc.persistence;

import java.sql.SQLException;
import java.util.List;

import koBus.mvc.domain.ResvDTO;

public interface ResvDAO {

	List<ResvDTO> searchResvList(String loginId) throws SQLException;

}
