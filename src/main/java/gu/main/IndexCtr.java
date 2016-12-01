package gu.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.SearchVO;
import gu.etc.EtcSvc;
import gu.project.ProjectSvc;


@Controller 
public class IndexCtr {
    @Autowired
    private EtcSvc etcSvc;
    
    @Autowired
    private ProjectSvc projectSvc;
    /**
     * main page. 
     */
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
        
        if (!"".equals(searchVO.getSearchKeyword())) {
        	searchVO.setSearchType("prtitle");
        }
        searchVO.setDisplayRowCount(12);
        searchVO.pageCalculate( projectSvc.selectProjectCount(searchVO) ); // startRow, endRow
        List<?> listview  = projectSvc.selectProjectList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "main/index";
    }
    
}
