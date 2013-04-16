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
		 function z_contdc() {
            }
            z_contdc.prototype = {
                isInit : false,
                data : {
                    conttype : null
                },
                isLoad : function() {
                    var isLoad = true;
                    for (var x in this.data) {
                        isLoad = isLoad && (this.data[x] != null);
                    }
                    return isLoad;
                }
            };
            t_data = new z_contdc();
            
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_contdc');
            });
            function q_gfPost() {
                q_gt('conttype', '', 0, 0, 0);
            }
             function q_gtPost(t_name) {
           	switch (t_name) {
                    case 'conttype':
                        t_data.data['conttype'] = '';
                        var as = _q_appendData("conttype", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['conttype'] += (t_data.data['conttype'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].typea;
                        }
                        break;
                }

                if (t_data.isLoad() && !t_data.isInit) {
                    t_data.isInit = true;
                $('#q_report').q_report({
                    fileName : 'z_contdc',
                    options : [{
                        type : '6',
                        name : 'xnoa'//[1]
                    }, {
                        type : '6',
                        name : 'xcustno'//[2]
                    }, {
                        type : '2',
                        name : 'addrno',//[3][4]
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b2.aspx'
                    }, {
                        type : '6',
                        name : 'xcno'//[5]
                    },{
                        type : '1',
                        name : 'date'//[6][7]
                    },{
                            type : '8',
                            name : 'xstype',//[8]
                            value : t_data.data['conttype'].split(',')
                    },{
                            type : '5',
                            name : 'xetype',//[9]
                            value : [q_getPara('report.all')].concat(new Array("存入","存出"))
                    },{
                        type : '6',
                        name : 'xpaydate'//[10]
                    }, {/*28*/
                            type : '5',
                            name : 'xsort1',//[11]
                            value : q_getMsg('tsort1').split('&')
                        }]
                });
                q_popAssign();
                q_langShow();
				 $('#chkXstype').children('input').attr('checked', 'checked');
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtXpaydate').mask('999/99/99');
                $('#txtDate2').datepicker();
                
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');
                
                var t_noa=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa').val(t_noa);
                
                $('#Xcustno').css("width","410px");
            	$('#txtXcustno').css("width","320px");
            	$('#txtXcustno').focus(function() {
            		q_msg( $(this), '輸入格式為：客戶.客戶.客戶.......');
                }).blur(function () {
					q_msg();
	        	});
	        	$('#Xcno').css("width","410px");
            	$('#txtXcno').css("width","320px");
            	$('#txtXcno').focus(function() {
            		q_msg( $(this), '輸入格式為：公司.公司.公司.......');
                }).blur(function () {
					q_msg();
	        	});
                
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
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
