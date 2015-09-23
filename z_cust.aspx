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
            
            var custtypeItem='';
            
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                if (custtypeItem.length == 0) {
					q_gt('custtype', '', 0, 0, 0, "");
				}
                
                $('#q_report').click(function(e) {
					if(q_getPara('sys.project').toUpperCase()=='RB'){
						var delete_report=999;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report=='z_cust03')
								delete_report=i;
						}
						if($('#q_report div div').text().indexOf('員工基本資料')>-1){
							$('#q_report div div').eq(delete_report).hide();
						}
					}
				});
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_cust',
                    options : [{//[1]
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {//[2]
                        type : '0',
                        name : 'namea',
                        value : r_name
                    }, {/*1 [3],[4]*/
                        type : '2',
                        name : 'custno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*2 [5],[6]*/
                        type : '2',
                        name : 'tggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {/*3 [7],[8]*/
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {/*4-[9]*/
                        type : '5',
                        name : 'xsort01',
                        value : q_getMsg('tsort01').split('&')
                    }, {/*5-[10]*/
                        type : '5',
                        name : 'xsort02',
                        value : q_getMsg('tsort02').split('&')
                    }, {/*6-[11]*/
                            type : '8',
                            name : 'xoption03',
                        value : q_getMsg('toption03').split('&')
                    }, {/*7-[12]*/
                        type : '5',
                        name : 'xsort03',
                        value : q_getMsg('tsort03').split('&')
                    }, {/*8-[13]*/
                        type : '5',
                        name : 'xcusttype', 
                        value : custtypeItem.split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#chkXoption03').children('input').attr('checked', 'checked');
                
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
				switch (t_name) {
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						custtypeItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							custtypeItem = custtypeItem + (custtypeItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
						}
						q_gf('', 'z_cust');
						break;
				}
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
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
