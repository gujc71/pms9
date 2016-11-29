package gu.project;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gu.common.Field3VO;
import gu.common.FileVO;

@Service
public class TaskSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    

    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(ProjectSvc.class);
    
    /** ------------------------------------------
     * Task.
     */
    public List<?> selectTaskList(String param) {
        return sqlSession.selectList("selectTaskList", param);
    }
    
    public List<?> selectTaskWorkerList(String param) {
        return sqlSession.selectList("selectTaskWorkerList", param);
    }
    
    /**
     * Task 저장.
     */
    public void insertTask(TaskVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
	        if (param.getTsno() == null || "".equals(param.getTsno())) {
	            if ("".equals(param.getTsparent())) {
	            	param.setTsparent(null); 
	            }
	            sqlSession.insert("insertTask", param);
	        } else {
	            sqlSession.update("updateTask", param);
	            sqlSession.delete("deleteTaskUser", param.getTsno());
	        }
	        String userno = param.getUserno();
	        if (userno!=null) {
	        	Field3VO fld = new Field3VO(param.getTsno(), null, null);
	        	String[] usernos = userno.split(",");
	        	for (int i=0; i< usernos.length; i++){
	        		if ("".equals(usernos[i])) {continue;}
	        		fld.setField2(usernos[i]);
		            sqlSession.update("insertTaskUser", fld);
	        	}
	        }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertTask");
        }  
    }
 
    public TaskVO selectTaskOne(String param) {
        return sqlSession.selectOne("selectTaskOne", param);
    }
    
    public List<?> selectTaskFileList(String param) {
        return sqlSession.selectList("selectTaskFileList", param);
    }
    public void deleteTaskOne(String param) {
        sqlSession.delete("deleteTaskOne", param);
    }
    
    /** ------------------------------------------
     * TaskMine.
     */
    public List<?> selectTaskMineList(Field3VO param) {
        return sqlSession.selectList("selectTaskMineList", param);
    }
    
    /**
     * TaskMine 저장.
     */
    public void insertTaskMine(TaskVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.update("updateTaskMine", param);
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteTaskFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getTsno());
                sqlSession.insert("insertTaskFile", f);
            }
            
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertTaskMine");
        }  
    }

    /**
     * TaskMine 복사.
     */
    public void taskCopy(Field3VO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.insert("taskCopy_step1", param);
            sqlSession.update("taskCopy_step2", param.getField2());   // prno
            
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertTaskMine");
        }  
    }
    
}
