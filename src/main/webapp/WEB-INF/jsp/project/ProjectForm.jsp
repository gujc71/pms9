<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><s:message code="common.pageTitle"/></title>
    <link href="css/sb-admin/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin/metisMenu.min.css" rel="stylesheet">
    <link href="css/sb-admin/sb-admin-2.css" rel="stylesheet">
    <link href="css/sb-admin/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="js/datepicker/datepicker.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
	<script src="js/datepicker/bootstrap-datepicker.js"></script>
	<script src="js/project9.js"></script>    

<script>
window.onload = function() {
	$('#prstartdate').datepicker().on('changeDate', function(ev) {
		if (ev.viewMode=="days"){
			$('#prstartdate').datepicker('hide');
		}
	});
	$('#prenddate').datepicker().on('changeDate', function(ev) {
		if (ev.viewMode=="days"){
			$('#prenddate').datepicker('hide');
		}
	});
}

function fn_formSubmit(){
	
	if ( ! chkInputValue("#prtitle", "<s:message code="project.name"/>")) return false;
	
	$("#form1").submit();
} 
</script>
    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-files-o fa-fw"></i> <s:message code="project.title"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="projectSave" method="post" onsubmit="return fn_formSubmit();" >
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-2"><s:message code="project.name"/></label>
	                            <div class="col-lg-9">
	                            	<input type="text" class="form-control" id="prtitle" name="prtitle" size="70" maxlength="100" value="<c:out value="${projectInfo.prtitle}"/>">
	                            </div>
	                        </div>
				            <div class="row form-group">
				            	<label class="col-lg-2"><s:message code="project.term"/></label>
				                 <div class="col-lg-2">
									<input class="form-control" size="16" id="prstartdate" name="prstartdate" type="text" value="<c:out value="${projectInfo.prstartdate}"/>" readonly>
				                 </div>
				                 <div class="col-lg-2">
							  		<input class="form-control" size="16" id="prenddate" name="prenddate" type="text" value="<c:out value="${projectInfo.prenddate}"/>" readonly>
				                 </div>
				            </div>
				            <div class="row form-group">
				            	<label class="col-lg-2"><s:message code="project.status"/></label>
				                 <div class="col-lg-10 form-group">
				                 	<label class="radio-inline"><input type="radio" name="prstatus" value="0"
				                 	<c:if test="${projectInfo.prstatus==0}">checked</c:if>><s:message code="project.status0"/></label>
				                 	<label class="radio-inline"><input type="radio" name="prstatus" value="1"
				                 	<c:if test="${projectInfo.prstatus==1}">checked</c:if>><s:message code="project.status1"/></label>
				                 	
				                 </div>
				            </div>	  				            	                        
	                    </div>
	                </div>
			        <button class="btn btn-outline btn-primary"><i class="fa fa-save fa-fw"></i><s:message code="common.btnSave"/></button>
			        <c:if test="${projectInfo.prno!=null}">
		         		<button type="button" class="btn btn-default" onclick="fn_moveToURL('projectDelete?prno=<c:out value="${projectInfo.prno}"/>')"><i class="fa fa-minus fa-fw"></i><s:message code="common.btnDelete"/></button>
		         	</c:if>    
					<input type="hidden" name="prno" value="<c:out value="${projectInfo.prno}"/>"> 
				</form>	
                
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
