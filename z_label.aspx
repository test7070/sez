<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_label');
            });

            function q_gfPost() {
                initfinish();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'getCust':
                        var as = _q_appendData("cust", "", true);
                        if(as[0]!=undefined){
                        	$('#txtCust1b').val(as[0].nick);
                    		$('#txtCust2b').val(as[0].nick);
                        }
                        break;
                    case 'getTgg':
                        var as = _q_appendData("tgg", "", true);
                        if(as[0]!=undefined){
                        	$('#txtTgg1b').val(as[0].nick);
                    		$('#txtTgg2b').val(as[0].nick);
                        }
                        break;
                }
            }

            function initfinish() {
                $('#q_report').q_report({
                    fileName : 'z_label',
                    options : [{/*1-[1]2]客戶*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*2-[3]4]廠商*/
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }]
                });
                $('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    if ($.trim($('#txtCust1a').val()).length == 0 && $.trim($('#txtCust2a').val()).length == 0 && $.trim($('#txtTgg1a').val()).length == 0 && $.trim($('#txtTgg2a').val()).length == 0)
                        alert(q_getMsg('errormsg'));
                    else
                        $('#btnOk').click();
                });
                q_popAssign();
                q_langShow();
                //cust.aspx,tgg.aspx
                var t_no = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
				
                if (t_no.indexOf('cust=') > 0) {
                    t_no = t_no.replace('cust=', '');
                    if(t_no.length>0){
	                    $('#txtCust1a').val(t_no);
	                    $('#txtCust2a').val(t_no);
	                    q_gt('cust', "where=^^ noa='"+t_no+"'^^", 0, 0, 0, 'getCust');
                    }
                } else {
                    t_no = t_no.replace('tgg=', '');
                    if(t_no.length>0){
                    	 $('#txtTgg1a').val(t_no);
	                    $('#txtTgg2a').val(t_no);
	                    q_gt('tgg', "where=^^ noa='"+t_no+"'^^", 0, 0, 0, 'getTgg');
                    }
                }
            }

            function q_boxClose(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>