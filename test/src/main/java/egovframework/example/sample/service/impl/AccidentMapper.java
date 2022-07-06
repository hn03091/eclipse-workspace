package egovframework.example.sample.service.impl;

import java.util.List;

import egovframework.example.sample.service.AccidentVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("accidentMapper")
public interface AccidentMapper {

	List<AccidentVO> accidentList(AccidentVO accidentVO) throws Exception;

}
