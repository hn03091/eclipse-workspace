package egovframework.example.sample.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.AedService;
import egovframework.example.sample.service.AedVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("aedService")
public class AedServiceImpl extends EgovAbstractServiceImpl implements AedService{
	
	@Autowired AedMapper aedMapper;
	
	@Override
	public void insertAed(AedVO aedVO) throws Exception{
		aedMapper.insertAed(aedVO);
	}
	

}
