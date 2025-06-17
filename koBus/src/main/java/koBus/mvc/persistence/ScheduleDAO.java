package koBus.mvc.persistence;

import java.util.List;

import koBus.mvc.domain.ScheduleDTO;


public interface ScheduleDAO {
	List<ScheduleDTO> selectBySidoCode(int sidoCode);

	List<ScheduleDTO> selectByRegion();
	
}
