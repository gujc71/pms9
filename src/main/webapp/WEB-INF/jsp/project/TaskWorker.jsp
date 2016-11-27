<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<script src="js/project9.js"></script>    
	
<script>

</script>
		
</head>
<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-tasks fa-fw"></i> <s:message code="project.title"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
            	<div class="col-lg-12">
            		<c:out value="${projectInfo.prtitle}"/> ( <c:out value="${projectInfo.prstartdate}"/> ~ <c:out value="${projectInfo.prenddate}"/>)
            		<c:if test="${projectInfo.userno == sessionScope.userno}">
            			<a href="projectForm?prno=<c:out value="${projectInfo.prno}"/>"><i class="fa fa-edit fa-fw" title="<s:message code="common.btnUpdate"/>"></i></a>
            		</c:if>
				</div>
            </div>     
            <p>&nbsp;</p>      
            <!-- /.row -->
            <div class="row">
                <ul class="nav nav-pills">
                     <li><a href='task?prno=<c:out value="${prno}" />'><i class="fa fa-tasks fa-fw"></i><s:message code="project.taskMgr"/></a></li>
                     <li><a href="taskCalendar?prno=<c:out value="${prno}" />"><i class="fa fa-calendar  fa-fw"></i><s:message code="project.calendar"/></a></li>
                     <li class="active"><a href="taskWorker?prno=<c:out value="${prno}" />"><i class="fa fa-user fa-fw"></i><s:message code="project.taskWorker"/></a></li>
                     <li><a href="taskMine?prno=<c:out value="${prno}" />"><s:message code="project.taskMine"/></a></li>
                 </ul>
            </div>
            
            <!-- /.row -->
            <div class="panel panel-default">
            	<div class="panel-body">
					<c:if test="${listview.size()==0}">
						<div class="listBody height200">
						</div>
					</c:if>
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:if test="${userno != listview.userno}">
							<p><i class="fa fa-user fa-fw"></i> <strong><c:out value="${listview.usernm}"/></strong></p>  
							<div class="listHead">
								<div class="listHiddenField pull-left field60"><s:message code="board.no"/></div>
								<div class="listHiddenField pull-right field100"><s:message code="project.rate"/></div>
								<div class="listHiddenField pull-right field130"><s:message code="project.endreal"/></div>
								<div class="listHiddenField pull-right field100"><s:message code="project.enddate"/></div>
								<div class="listHiddenField pull-right field100"><s:message code="project.startdate"/></div>
								<div class="listTitle"><s:message code="project.task"/></div>
							</div>							
						</c:if>						
						<c:set var="userno" value="${listview.userno}" />	
						<c:url var="link" value="taskMineForm">
							<c:param name="tsno" value="${listview.tsno}" />
						</c:url>
					
						<div class="listBody">
							<div class="listHiddenField pull-left field60 textCenter"><c:out value="${status.index+1}"/></div>
							<div class="listHiddenField pull-right field100 textCenter">
								<div style="width:100%;border:1px solid <c:out value="${listview.statuscolor}"/>">
									<div style="width:<c:out value="${listview.tsrate}"/>%;background:<c:out value="${listview.statuscolor}"/>; color:#000000"><c:out value="${listview.tsrate}"/>%</div>
								</div>
							</div>
							<div class="listHiddenField pull-right field130 textCenter"><c:out value="${listview.tsendreal}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.tsenddate}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.tsstartdate}"/></div>
							<div class="listTitle" title="<c:out value="${listview.tstitle}"/>">
								<c:choose>
								    <c:when test="${projectInfo.userno == sessionScope.userno}">
										<a href="${link}"><c:out value="${listview.tstitle}"/></a>
								    </c:when>
								    <c:otherwise>
										<c:out value="${listview.tstitle}"/>
								    </c:otherwise>
								</c:choose>
							</div>
							<div class="showField text-muted small">
								<c:out value="${listview.tsstartdate}"/> ~
								<c:out value="${listview.tsenddate}"/>
								<c:out value="${listview.tsrate}"/>%
								<c:out value="${listview.usernm}"/>
							</div>								
						</div>
					
					</c:forEach>	
					
            	</div>    
            </div>
            <!-- /.row -->                    
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
