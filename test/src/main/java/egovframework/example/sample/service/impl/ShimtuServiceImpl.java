package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.ShimtuService;
import egovframework.example.sample.service.ShimtuVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("shimtuService")
public class ShimtuServiceImpl extends EgovAbstractServiceImpl implements ShimtuService{
	
	@Autowired ShimtuMapper shimtuMapper;
	@Override
	public List<ShimtuVO> shimtuList(ShimtuVO shimtuVO) throws Exception {
		return shimtuMapper.shimtuList(shimtuVO);
	}
}
