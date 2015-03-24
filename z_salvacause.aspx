<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_salvacause');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_salvacause',
                        options : [{
                        type : '6',
                        name : 'xnoa'
                    },{
                        type : '1',
                        name : 'xdate'
                    },{
                        type : '1',
                        name : 'ydate'
                    },{
                    	type : '2',
                        name : 'sss',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    },{
                    	type : '2',
                        name : 'xpart',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa').val(t_noa).width(100);
                
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();
                
                 if (r_rank < 8 && q_content==''){
					q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 1);
                }
            }

            function q_boxClose(s2) {
            }
            
            var ssspartno = '',ssspart='',sssgroup='',sssjob='';
            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'authority':
                        var as = _q_appendData('authority', '', true);
                        if (as[0] != undefined) {
                        	if(q_getPara('sys.comp').indexOf('大昌')>-1){
	                            if (r_rank >= 7 || r_userno=='020110'){//104/03/24 職務變動姮瑜可以看到全部的資料
	                                
	                            }else if (as.length > 0 && as[0]["pr_modi"] == "true"){
	                                $('#txtXpart1a').val(ssspartno).attr('disabled','disabled');
	                                $('#txtXpart1b').val(ssspart);
	                                $('#txtXpart2a').val(ssspartno).attr('disabled','disabled');
	                                $('#txtXpart2b').val(ssspart);
	                                $('#btnXpart1').hide();
	                                $('#btnXpart2').hide();
	                            }else{
	                                $('#txtSss1a').val(r_userno).attr('disabled','disabled');
	                                $('#txtSss1b').val(r_name);
	                                $('#txtSss2a').val(r_userno).attr('disabled','disabled');
	                                $('#txtSss2b').val(r_name);
	                                $('#btnSss1').hide();
	                                $('#btnSss2').hide();
	                                $('#txtXpart1a').val(ssspartno).attr('disabled','disabled');
	                                $('#txtXpart1b').val(ssspart);
	                                $('#txtXpart2a').val(ssspartno).attr('disabled','disabled');
	                                $('#txtXpart2b').val(ssspart);
	                                $('#btnXpart1').hide();
	                                $('#btnXpart2').hide();
								}
							}
                        }
                        
                        break;
	            	case 'sss':
	                        var as = _q_appendData('sss', '', true);
	                        if (as[0] != undefined) {
	                            ssspartno = as[0].partno;
	                            ssspart = as[0].part;
		                        q_gt('authority', "where=^^a.noa='z_salvacause' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1);
	                        }
	                        break;
				}
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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