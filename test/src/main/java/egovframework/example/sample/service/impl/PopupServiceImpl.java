package egovframework.example.sample.service.impl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.PopupService;
import egovframework.example.sample.service.PopupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("popupService")
public class PopupServiceImpl extends EgovAbstractServiceImpl implements PopupService  {
	
	@Autowired PopupMapper popupmapper;

	
	@Override
	public List<PopupVO> popupList(PopupVO popupVO) throws Exception {
		return popupmapper.popupList(popupVO);
	}
	@Override
	public void popupInsert(PopupVO popupVO) throws Exception{
		popupmapper.popupInsert(popupVO);
	}

}
