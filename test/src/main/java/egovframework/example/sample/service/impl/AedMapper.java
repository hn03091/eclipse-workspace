package egovframework.example.sample.service.impl;

import egovframework.example.sample.service.AedVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("aedMapper")
public interface AedMapper {
	
	void insertAed(AedVO aedVO) throws Exception;
}
