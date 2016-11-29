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
	<link href="js/dynatree/ui.dynatree.css" rel="stylesheet" id="skinSheet"/>
	<link rel="stylesheet" type="text/css" href="js/easyui/easyui.css">

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
	<script src="js/easyui/jquery.easyui.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/dynatree/jquery.dynatree.js"></script>
	<script src="js/project9.js"></script>    
	
<script>

$(function() {

	var b = {"total":<c:out value="${listview.size()}" />,"rows":[
		<c:forEach var="listview" items="${listview}" varStatus="status">
			{"id":'<c:out value="${listview.tsno}" />',"tstitle":'<c:out value="${listview.tstitle}" />',"tsstartdate":"<c:out value="${listview.tsstartdate}" />"
			,"tsenddate":"<c:out value="${listview.tsenddate}" />","tsendreal":"<c:out value="${listview.tsendreal}" />", "tsrate":"<c:out value="${listview.tsrate}" />"
			,"userno": "<c:out value="${listview.userno}" />", "usernm": "<c:out value="${listview.usernm}" />"
			<c:if test="${listview.tsparent!=null}">,"_parentId":"<c:out value="${listview.tsparent}" />"</c:if> } <c:if test="${!status.last}">,</c:if>
		</c:forEach>
    ]};

	$('#tg').treegrid({
		data: b
		<c:if test="${projectInfo.userno == sessionScope.userno}"> 
		,onDblClickCell : function(field, row) {
			if (editingId === undefined) {
				edit();
				return;
			}
			if (field=="usernm") {
				fn_searchUsers(row);
			}
		}	
		</c:if>
	});
	
});



function formatProgress(value, row){
   	if (!value){ return '' }
   	
	var today = new Date();
	var tsstartdate = new Date(row.tsstartdate);
	var tsenddate = new Date(row.tsenddate);
/*  
  오늘 날짜가 시작일자보다 작으면 회색
  오늘 날짜가 종료일자를 지났으면 빨강
  오늘 날짜가 주어진 기간의 50% 미만이면 녹색
  오늘 날짜가 주어진 기간의 50% 이상이면 노랑
  진행율이 기간내에 100이 되었으면 녹색, 지난뒤에 100이면 검정색
*/	
	var bgcolor; 
	
	if (row.tsrate < 100) {
		if (tsstartdate > today) {
			bgcolor = "gray";
		} else if (tsenddate < today) {
			bgcolor = "red";
		} else if ((today.getTime() - tsstartdate.getTime()) < (tsenddate.getTime() - today.getTime()) ) {
			bgcolor = "green";
		} else if ((today.getTime() - tsstartdate.getTime()) >= (tsenddate.getTime() - today.getTime()) ) {
			bgcolor = "yellow";
		}
	} else {
		if (row.tsendreal && new Date(row.tsendreal) <= tsenddate) {
			bgcolor = "green";
		} else {
			bgcolor = "orange";
		}
	}
	var statusMsg = {"gray": "<s:message code="project.gray"/>", "red": "<s:message code="project.red"/>", "green": "<s:message code="project.green"/>"
				   , "yellow": "<s:message code="project.yellow"/>", "orange": "<s:message code="project.orange"/>"    		
				    }
   	var s = '<div style="width:100%;border:1px solid ' + bgcolor + '" title="' + statusMsg[bgcolor] + '">' +
   			'<div style="width:' + value + '%;background:' + bgcolor + '; color:#000000">' + value + '%' + '</div>'
   			'</div>';
   	return s;
}

var editingId;
function edit(){
	if (editingId != undefined){
		$('#tg').treegrid('select', editingId);
		return;
	}
	var row = $('#tg').treegrid('getSelected');
	if (row){
		editingId = row.id
		$('#tg').treegrid('beginEdit', editingId);
	}
}
function save(){
	if (editingId === undefined){return}
	var tg = $('#tg');
	
	var node = tg.treegrid('getSelected');
	if (!node.tsrate) {
		node.tsrate = 0;
	}
	if (node.tsrate==="100" && !node.tsendreal) {
		var d1 = new Date();
	
		tg.treegrid('update', {
			id : node.id,
			row : {tsendreal: $.fn.datebox.defaults.formatter(d1)}
		});		
	}
	tg.treegrid('endEdit', editingId);
	
	var parent = tg.treegrid('getParent', editingId);
	var parentId=null;

	if (parent) {
		parentId = parent.id;
	}	
	
	if (node.id!=='N'){
		node.tsno=node.id;
	}
	node.prno='<c:out value="${prno}" />';
	node.tsparent=parentId;
	$.ajax({
		url : "taskSave",
		type: "post",
		dataType: "json",
		data: node
	}).done(function(data){
		if (node.id !== "N") return;
		$('#tg').treegrid('update', {
			id : "N",
			row : {id : data}
		});		
	});
	
	editingId = undefined;
}

function cancel(){
	if (editingId != undefined){
		$('#tg').treegrid('cancelEdit', editingId);
	}
	if (editingId === 'N'){
		$('#tg').treegrid('remove', editingId);
	}
	editingId = undefined;
}

function appendNode(){
	if (editingId) {return}
	
	var parent = null;
	var node   = $('#tg').treegrid('getSelected');
	if (node) parent = $('#tg').treegrid('getParent', node.id);
	
	if (parent) {
		append(parent.id);
	}else{
		append();
	}
}
function appendChildNode(){
	if (editingId) {return}
	
	var node = $('#tg').treegrid('getSelected');
	if (node) {
		append(node.id);
	}
}
	
function append(parentid){
	var d1 = new Date();
	$('#tg').treegrid('append',{
		parent: parentid,
		data: [{
			id: 'N',
			tstitle: 'New Task',
			tsstartdate: $.fn.datebox.defaults.formatter(d1),
			tsenddate: $.fn.datebox.defaults.formatter(d1),
			tsendreal: "",
			tsrate: 0,
			userno: "", usernm:""
		}]
	})
	editingId = 'N';
	$('#tg').treegrid('select', editingId);
	$('#tg').treegrid('beginEdit', editingId);
}
function removeIt(){
	var node = $('#tg').treegrid('getSelected');
	if (!node) {return;}
	if ($('#tg').treegrid('getChildren',node.id).length>0){
		alert("<s:message code="msg.canNotDelete4task"/>");
		return;
	}
	if (!confirm("<s:message code="ask.Delete"/>")) {return;}
	
	$.ajax({
		url : "taskDelete",
		cache : false,
		dataType : "json",
		data : {tsno:node.id}
	}).done(function(data){
		$('#tg').treegrid('remove', node.id);
	});
}

////////////////////////////////////////////////
function fn_searchUsers(row){
    $.ajax({
    	url: "popupUsers",
		type: "post"    	
    }).success(function(result){
    			$("#popupUsers").html(result);
    			if (row.userno){
    				set_Users(row.userno, row.usernm); 
    			}
		}    		
    );
	$("#popupUsers").modal("show");
}
function deptTreeInUsersActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
    	url: "popupUsers4Users",
		type:"post", 
    	data: { deptno : node.data.key }    	
    }).success(function(result){
    			$("#userlist4Users").html(result);
		}    		
    );
}

function fn_selectUsers(usernos, usernms) {
	var node = $('#tg').treegrid('getSelected');
	
	$('#tg').treegrid('update', {
		id : node.id,
		row : {userno : usernos, usernm:usernms}
	});
	$('#tg').treegrid('endEdit', editingId);
	$('#tg').treegrid('beginEdit', editingId);

	$("#popupUsers").modal("hide");
}

var prno='<c:out value="${prno}" />';

function fn_copyTaskDialog() {
    $.ajax({
    	url: "projectList4Ajax",
		type: "post"    	
    }).success(function(result){
    			$("#projectList").html(result);
		}    		
    );
	$("#projectList").modal("show");
}
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
            			<a href="#" onclick="fn_copyTaskDialog()"><i class="fa fa-paste fa-fw" title="<s:message code="project.copy"/>"></i></a>
            		</c:if>
				</div>
            </div>     
            <p>&nbsp;</p>            
            <!-- /.row -->
            <div class="row">
            	<div class="col-lg-5">
		            <ul class="nav nav-pills">
	                     <li class="active"><a href='#'><i class="fa fa-tasks fa-fw"></i><s:message code="project.taskMgr"/></a></li>
	                     <li><a href="taskCalendar?prno=<c:out value="${prno}" />"><i class="fa fa-calendar  fa-fw"></i><s:message code="project.calendar"/></a></li>
	                     <li><a href="taskWorker?prno=<c:out value="${prno}" />"><i class="fa fa-user fa-fw"></i><s:message code="project.taskWorker"/></a></li>
	                     <li><a href="taskMine?prno=<c:out value="${prno}" />"><s:message code="project.taskMine"/></a></li>
	                 </ul>
                </div>
                <c:if test="${projectInfo.userno == sessionScope.userno}"> 
                <div class="col-lg-7">
			         <button type="button" class="btn btn-default pull-right" onclick="cancel()"><i class="fa fa-times fa-fw"></i><s:message code="common.btnCancel"/></button>      
			         <button type="button" class="btn btn-default pull-right" onclick="save()"><i class="fa fa-save fa-fw"></i><s:message code="common.btnSave"/></button>      
			         <button type="button" class="btn btn-default pull-right" onclick="edit()"><i class="fa fa-edit fa-fw"></i><s:message code="common.btnUpdate"/></button>      
			         <button type="button" class="btn btn-default pull-right" onclick="removeIt()"><i class="fa fa-minus fa-fw"></i><s:message code="common.btnDelete"/></button>    
			         <button type="button" class="btn btn-default pull-right" onclick="appendChildNode()"><i class="fa fa-plus fa-fw"></i><s:message code="board.append"/>(<s:message code="project.child"/>)</button>      
			         <button type="button" class="btn btn-default pull-right" onclick="appendNode()"><i class="fa fa-plus fa-fw"></i><s:message code="board.append"/></button>      
				</div>
				</c:if>
            </div>            
            
            <div class="row">
                <div class="col-lg-12">
					<table id="tg" class="easyui-treegrid" style="width:100%;height:500px"
						data-options="
							iconCls: 'icon-ok',
							rownumbers: true,
							animate: true,
							collapsible: true,
							fitColumns: true,
							method: 'get',
							idField: 'id',
							treeField: 'tstitle'
						">
					<thead>
						<tr>
							<th data-options="field:'tstitle',width:200,editor:'text'"><s:message code="project.task"/></th>
							<th data-options="field:'tsstartdate',width:80,editor:'datebox'"><s:message code="project.startdate"/></th>
							<th data-options="field:'tsenddate',width:80,editor:'datebox'"><s:message code="project.enddate"/></th>
							<th data-options="field:'tsendreal',width:80,editor:'datebox'"><s:message code="project.endreal"/></th>
							<th data-options="field:'tsrate',width:80,formatter:formatProgress,editor:'numberbox'"><s:message code="project.rate"/></th>
							<th data-options="field:'usernm',width:80"><s:message code="project.worker"/></th>
						</tr>
					</thead>
					</table>
				</div>			                
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
    <div id="popupUsers" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	</div>

    <div id="projectList" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	</div>
    
</body>

</html>
