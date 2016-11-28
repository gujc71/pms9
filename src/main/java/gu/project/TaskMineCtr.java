package gu.project;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.Field3VO;
import gu.common.FileUtil;
import gu.common.FileVO;
import gu.etc.EtcSvc;

@Controller 
public class TaskMineCtr {

    @Autowired
    private TaskSvc taskSvc;
    
    @Autowired
    private EtcSvc etcSvc;    
    
    @Autowired
    private ProjectSvc projectSvc;

    static final Logger LOGGER = LoggerFactory.getLogger(ProjectCtr.class);
    
    /**
     * Task.
     */
    @RequestMapping(value = "/taskMine")
    public String taskMine(HttpServletRequest request, ModelMap modelMap) {
    	
        String userno = request.getSession().getAttribute("userno").toString();
        String prno = request.getParameter("prno");
        
        ProjectVO projectInfo = projectSvc.selectProjectOne(prno);
        if (projectInfo == null) {
            return "common/noAuth";
        }
        
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
        
        List<?> listview  = taskSvc.selectTaskMineList(new Field3VO(prno, userno, null));
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("prno", prno);
        modelMap.addAttribute("projectInfo", projectInfo);
        
        return "project/TaskMine"; 
    }
    
    @RequestMapping(value = "/taskMineForm")
    public String taskMineForm(HttpServletRequest request, ModelMap modelMap) {
    	String tsno = request.getParameter("tsno");
    	
    	TaskVO taskInfo = taskSvc.selectTaskOne(tsno);
        List<?> listview = taskSvc.selectTaskFileList(tsno);
        
    	modelMap.addAttribute("taskInfo", taskInfo);
        modelMap.addAttribute("listview", listview);
    	
        return "project/TaskMineForm"; 
    }
    
    @RequestMapping(value = "/taskMineSave")
    public String taskMineSave(HttpServletRequest request, HttpServletResponse response, TaskVO taskInfo) {
        
        String[] fileno = request.getParameterValues("fileno");
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(taskInfo.getUploadfile());
        
        taskSvc.insertTaskMine(taskInfo, filelist, fileno);
        
        return "redirect:taskMine?prno=" + taskInfo.getPrno(); 
    }
}
