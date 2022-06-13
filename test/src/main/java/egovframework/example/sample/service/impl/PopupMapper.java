package egovframework.example.sample.service.impl;

import java.util.List;

import egovframework.example.sample.service.PopupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("popupMapper")
public interface PopupMapper {
	List<PopupVO> popupList(PopupVO popupVO) throws Exception;

	void popupInsert(PopupVO popupVO) throws Exception;

}
