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
                },
                keyup : null
            };
            t_data = new z_accc();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_accc3');
            });

            function q_gfPost() {
                q_gt('acpart', '', 0, 0, 0, "init1", r_accy+'_'+r_cno);
            }
			function sortNumber(a, b){
				var n = parseInt(a.substring(0,3))*100+parseInt(a.substring(4,6));
				var m = parseInt(b.substring(0,3))*100+parseInt(b.substring(4,6));
				return m-n;
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init1':
                        t_data.data['part'] = '';
                        var as = _q_appendData("acpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        initfinish();
                        break;
                }
            }
            function initfinish(){
            	$('#q_report').q_report({
                    fileName : 'z_accc3',
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
                        name : 'wdate'
                    }, {/*2 [5],[6]*/
                        type : '1',
                        name : 'xdate'
                    }, {/*3 [7],[8]*/
                        type : '1',
                        name : 'ydate'
                    }, {/*4 [9]*/
                        type : '6',
                        name : 'wmon'
                    }, {/*5 [10]*/
                        type : '6',
                        name : 'xmon'
                    }, {/*6 [11]*/
                        type : '6',
                        name : 'ymon'
                    }, {/*7 [12][13] 含子科目*/
                        type : '2',
                        name : 'xacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*8 [14]*/
                        type : '8',
                        name : 'xpart',
                        value : ('zzzzz@無部門,'+t_data.data['part']).split(',')
                    }, {/*9 [15]*/
                        type : '6',
                        name : 'wyear'
                    }]
                });
				
                //$('#txtWyear').mask('999');
                $('#txtWyear').mask('9999');
				var t_date = new Date();
				var r_accya = t_date.getFullYear();
                $('#txtWyear').val(r_accya);
				
                $('#txtWmon').mask('999/99');
                $('#txtXmon').mask('999/99');
                $('#txtYmon').mask('999/99');
				
                $('#txtWdate1').mask('999/99/99');
                $('#txtWdate1').datepicker();
                $('#txtWdate2').mask('999/99/99');
                $('#txtWdate2').datepicker();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();
				$('#chkXpart').children('input').attr('checked', 'checked');
				var t_date = new Date();
				/*var t_year = t_date.getFullYear()-1911;*/
				var t_year = t_date.getFullYear();
				var t_month = t_date.getMonth()+1;
				$('#txtWmon').val(t_year+'/'+(t_month<10?'0':'')+t_month);
				$('#txtWdate1').val(t_year +'/01/01');
				$('#txtWdate2').val(t_year +'/12/31');
				$('#txtXdate1').val(t_year +'/01/01');
				$('#txtXdate2').val(t_year +'/12/31');
				$('#txtYdate1').val((t_year-1) +'/01/01');
				$('#txtYdate2').val((t_year-1) +'/12/31');
				
				$('#txtXacc1a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});
        		$('#txtXacc2a').change(function(e) {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                	if(patt.test($(this).val()))
                    	$(this).val($(this).val().replace(patt,"$1.$2"));
                    else if((/^(\d{4})$/).test($(this).val())){
                    	$(this).val($(this).val()+'.');
                    }
        		});	
        		q_popAssign();
        		q_langShow();
        		
        		if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$("#chkXpart").children('input').attr('Disabled','Disabled');
		        	$('#chkXpart').children('input').prop('checked',false);
		        	for(var i=0;i<$('#chkXpart').children('input').length;i++){
		        		if ($('#chkXpart').children('input')[i].value==r_partno || i==0){
		        			$('#chkXpart').children('input')[i].checked=true;
		        		}
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
		<div id="q_menu"> </div>
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