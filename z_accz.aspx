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
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
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
            
            var ssspart;
			$(document).ready(function() {
				q_getId();
				q_gt('acpart', '', 0, 0, 0, "", r_accy+'_'+r_cno);
                q_gt('ssspart', "where=^^noa='"+r_userno+"'^^", 0, 0, 0, "", r_accy+'_'+r_cno);
			});
			
			function q_gfPost() {
				init_finish=true;
				$('#q_report').q_report({
					fileName : 'z_accz',
					options : [{
						type : '0',
						name : 'accy',
						value : r_accy
					},{
						type : '2',
						name : 'xnoa',
						dbf : 'accz',
						index : 'noa,namea',
						src : 'accz_b.aspx'
					},{
						type : '1',
						name : 'xdate'
					},{
						type : '1',
						name : 'xindate'
					}, {
                        type : '8',
                        name : 'xpartno',
                        value : ('zzzzz@無部門,'+t_data.data['part']).split(',')
                    }]
				});
				q_popAssign();
                q_langShow();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
				t_noa  =  t_noa.replace('noa=','');
				$('#txtXnoa1').val(t_noa);
				$('#txtXnoa2').val(t_noa);
				var t_date,t_year,t_month,t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear()-1911;
				t_year = t_year>99?t_year+'':'0'+t_year;
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);
                var lastDays = $.datepicker._getDaysInMonth(q_date().substring(0,3),q_date().substring(4,6)-1);
                $('#txtXdate2').val(q_date().substring(0,7)+lastDays);
                
                if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$("#chkXpartno").children('input').attr('Disabled','Disabled');
		        	$('#chkXpartno').children('input').prop('checked',false);
		        	for(var i=0;i<$('#chkXpartno').children('input').length;i++){
		        		if ($('#chkXpartno').children('input')[i].value==r_partno || i==0){
		        			$('#chkXpartno').children('input')[i].checked=true;
		        			$('#chkXpartno').children('input')[i].disabled=false;
		        			continue;
		        		}
		        		for(var j=0;j<ssspart.length;j++){
		        			if ($('#chkXpartno').children('input')[i].value==ssspart[j].partno){
			        			$('#chkXpartno').children('input')[i].checked=true;
			        			$('#chkXpartno').children('input')[i].disabled=false;
			        			break;
			        		}
		        		}
		        	}
		        }

			}
			
			function q_boxClose(s2) {
			}
			
			var init_finish=false,init_acpart=false,init_ssspart=false;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acpart':
                        t_data.data['part'] = '';
                        var as = _q_appendData("acpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        
                        init_acpart=true;
                        break;
					case 'ssspart':
						ssspart = _q_appendData("ssspart", "", true);
						init_ssspart=true;
						break;
                }
                if(init_acpart&&init_ssspart&&!init_finish)
                	q_gf('', 'z_accz');
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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
           
          