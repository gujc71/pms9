<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

    	<div class="modal-dialog" role="document"> 
    		<div class="modal-content"> 
    			<div class="modal-header"> 
    				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
    					<span aria-hidden="true">×</span>
    				</button> 
    				<h4 class="modal-title" id="mySmallModalLabel"><s:message code="project.task"/></h4> 
    			</div> 
    			<div class="modal-body">
		            <!-- /.row -->
		            <div class="row">
		            	<div class="col-lg-12" >
			            	<div class="panel panel-default" >
			            		<div class="panel-body">
					            	<div class="row">
			                            <label class="col-lg-3"><s:message code="project.task"/></label>
			                            <div class="col-lg-9"><c:out value="${taskInfo.tstitle}"/></div>
			                        </div>
					            	<div class="row">
			                            <label class="col-lg-3"><s:message code="project.taskterm"/></label>
			                            <div class="col-lg-9"><c:out value="${taskInfo.tsstartdate}"/> ~ <c:out value="${taskInfo.tsenddate}"/></div>
			                        </div>
					            	<div class="row">
			                            <label class="col-lg-3"><s:message code="project.worker"/></label>
			                            <div class="col-lg-9"><c:out value="${taskInfo.usernm}"/></div>
			                        </div>
					            	<div class="row">
			                            <label class="col-lg-3"><s:message code="project.rate"/></label>
			                            <div class="col-lg-9">
			                            	<div style="width:100%;border:1px solid <c:out value="${taskInfo.statuscolor}"/>">
								   				<div style="width:<c:out value="${taskInfo.tsrate}"/>%;background:<c:out value="${taskInfo.statuscolor}"/>; color:#000000"><c:out value="${taskInfo.tsrate}"/>%</div>
								   			</div>
			                            </div>
			                        </div>
			                	</div>     
							</div>
		                </div> 
		            </div>
		            <!-- /.row -->
		
    			</div>
    		</div> 
    	</div> 
