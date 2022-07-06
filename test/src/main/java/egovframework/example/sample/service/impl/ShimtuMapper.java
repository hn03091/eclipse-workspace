package egovframework.example.sample.service.impl;

import java.util.List;

import egovframework.example.sample.service.ShimtuVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("shimtuMapper")
public interface ShimtuMapper {

	List<ShimtuVO> shimtuList(ShimtuVO shimtuVO) throws Exception;

}
