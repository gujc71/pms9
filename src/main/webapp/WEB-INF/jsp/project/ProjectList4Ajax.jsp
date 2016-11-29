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
<script>

function fnSubmitForm(page){ 
    $.ajax({
    	url: "projectList4Ajax",
		type: "post",
		data: {page: page}
    }).success(function(result){
    			$("#projectList").html(result);
		}    		
    );
}

function fn_copyTask(srcno){
	if (!confirm("선택한 프로젝트로 부터 작업 항목을 복사 하시겠습니까?")) {return;}
	location.href = "taskCopy?prno=" + prno + "&srcno="+srcno
}

</script>
    
</head>

<body>

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel"><s:message code="project.copy"/></h4>
                </div>
                <div class="modal-body" id="myModalBody">
		            <!-- /.row -->
		            <div class="row">
		            	<div class="col-lg-12" >
							<div class="listHead">
								<div class="listHiddenField pull-left field60"><s:message code="board.no"/></div>
								<div class="listHiddenField pull-right field60"><s:message code="project.status"/></div>
								<div class="listHiddenField pull-right field100"><s:message code="project.enddate"/></div>
								<div class="listHiddenField pull-right field100"><s:message code="project.startdate"/></div>
								<div class="listTitle"><s:message code="project.name"/></div>
							</div>
							
							<c:forEach var="listview" items="${listview}" varStatus="status">
								<div class="listBody">
									<div class="listHiddenField pull-left field60">
										<c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/>
									</div>
									
									<div class="listHiddenField pull-right field60 textCenter"><c:out value="${listview.prstatus}"/></div>
									<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.prenddate}"/></div>
									<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.prstartdate}"/></div>
									<div class="listTitle" title="<c:out value="${listview.prtitle}"/>">
										<a href="#" onclick="fn_copyTask(<c:out value="${listview.prno}"/>)"><c:out value="${listview.prtitle}"/></a>
									</div>
		
									<div class="showField text-muted small">
										<c:out value="${listview.usernm}"/> 
										<c:out value="${listview.prstartdate}"/>~<c:out value="${listview.prenddate}"/>
										<c:out value="${listview.prstatus}"/> 
									</div>
								</div>
									
							</c:forEach>	
							<br/>
							<form role="form" id="form1" name="form1"  method="post">
							    <jsp:include page="../common/pagingforAjax.jsp" />
							</form>								
						</div>	
		            </div>
            		<!-- /.row -->

				</div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
</body>

</html>
