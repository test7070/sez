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
                    balacc1 : null,
                    part : null
                }
            };
            t_data = new z_accc();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_accc');
            });

            function q_gfPost() {
                q_gt('balacc1', '', 0, 0, 0, "init1");
            }

            function q_gtPost(t_name) {

                switch (t_name) {
                    case 'init1':
                        t_data.data['balacc1'] = '';
                        var as = _q_appendData("balacc1", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['balacc1'] += (t_data.data['balacc1'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].balacc1;
                        }
    					q_gt('part', '', 0, 0, 0, "init2");
                        break;
                    case 'init2':
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
                    fileName : 'z_accc',
                    options : [{/*  [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    }, {/*1 [2][3]*/
                        type : '1',
                        name : 'date'
                    }, {/*2 [4][5]*/
                        type : '2',
                        name : 'acc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*3 [6][7]*/
                        type : '2',
                        name : 'part',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }, {/*4 [8][9]*/
                        type : '1',
                        name : 'xaccc3'
                    }, {/*5 [10]*/
                        type : '6',
                        name : 'xbal'
                    }, {/*6 [11]*/
                        type : '8', //checkbox
                        name : 'xaccc5',
                        value : t_data.data['balacc1'].split(',')
                    }, {/*7 [12]*/
                        type : '8', //checkbox
                        name : 'balance',
                        value : (('').concat(new Array("餘額"))).split(',')
                    },{/*[13]*/
                        type : '0',
                        name : 'accty',
                        value : r_accy 
                    }, {/*8-[14],[15]*/
                        type : '1',
                        name : 'ydate'
                    }, {/*9 [16][17]*/
                        type : '2',
                        name : 'yacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*10-[18]*/
                        type : '8',
                        name : 'ypart',
                        value : t_data.data['part'].split(',')
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#txtDate1').mask('99/99');
                $('#txtDate2').mask('99/99');
                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();
				$('#chkYpart').children('input').attr('checked', 'checked');
				
				$('#txtAcc1a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});
        		$('#txtAcc2a').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
        		});

                $('#chkXbalacc1').children('input').attr('checked', 'checked');
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate1').val(t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate2').val(t_month + '/' + t_day);
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
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>