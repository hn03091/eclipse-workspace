package egovframework.example.sample.service.impl;

import egovframework.example.sample.service.PharmacyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("pharmacyMapper")
public interface PharmacyMapper {

	void insertPm(PharmacyVO pharmacyVO) throws Exception;
}
