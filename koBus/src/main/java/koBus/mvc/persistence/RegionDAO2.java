package koBus.mvc.persistence;

import java.util.List;

import koBus.mvc.domain.RegionDTO2;


public interface RegionDAO2 {
	List<RegionDTO2> selectBySidoCode(int sidoCode);

	List<RegionDTO2> selectByRegion();
	
}
