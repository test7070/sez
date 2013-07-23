<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            function z_accc() {
            }
            z_accc.prototype = {
                data : {
                    part : null
                }
            };
            t_data = new z_accc();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_accc2');
            });

            function q_gfPost() {
                q_gt('part', '', 0, 0, 0, "init1");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init1':
                        t_data.data['part'] = '';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        initfinish();
                        break;
                }
            }
            function initfinish(){
            	$('#q_report').q_report({
                    fileName : 'z_accc2',
                    options : [{/*  [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    },{/*  [2]*/
                        type : '0',
                        name : 'xrank',
                        value : r_rank
                    }, {/*1 [3],[4]*/
                        type : '1',
                        name : 'date'
                    }, {/*2 [5][6] 含子科目*/
                        type : '2',
                        name : 'xacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*3 [7][8] 不含子科目*/
                        type : '2',
                        name : 'yacc',
                        dbf : 'view_acc',
                        index : 'acc1,acc2',
                        src : "view_acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*4 [9]*/
                        type : '8',
                        name : 'xpart',
                        value : ('zzzzz@無部門,'+t_data.data['part']).split(',')
                    }, {/*5 [10]*/
                        type : '8',
                        name : 'xoption03',
                        value : q_getMsg('toption03').split('&')
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
				$('#chkXpart').children('input').attr('checked', 'checked');
				
				$('#txtXacc1a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});
        		$('#txtXacc2a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});	
        		$('#txtYacc1a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});
        		$('#txtYacc2a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});		
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
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>