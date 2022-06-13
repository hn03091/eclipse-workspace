package egovframework.example.sample.service;

import java.util.List;

public interface PopupService {

	List<PopupVO> popupList(PopupVO popupVO) throws Exception;

	void popupInsert(PopupVO popupVO) throws Exception;

}
