package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.AccidentService;
import egovframework.example.sample.service.AccidentVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("accidentService")
public class AccidentServiceImpl extends EgovAbstractServiceImpl implements AccidentService {
	
	@Autowired AccidentMapper accidentMapper;
	@Override
	public List<AccidentVO> accidentList(AccidentVO accidentVO) throws Exception {
		return accidentMapper.accidentList(accidentVO);
	}

}
