package koBus.mvc.persistence;

import java.sql.SQLException;
import java.util.List;

import koBus.mvc.domain.ItemPurDTO;

public interface ItemPurDAO {
	
	// 정기권 결제 테이블 리스트 가져오기
	List<ItemPurDTO> itemPopPurList(String loginId) throws SQLException; 
	
	// 프리패스 결제 테이블 리스트 가져오기
	List<ItemPurDTO> itemFreePurList(String loginId) throws SQLException; 
	
}
