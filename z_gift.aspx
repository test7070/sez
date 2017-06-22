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
		aPop = new Array(['txtSssno', '', 'sss', 'noa,namea', 'txtSssno', "sss_b.aspx"],
						 ['txtPartno', '', 'part', 'noa,part', 'txtPartno', "part_b.aspx"]);
			t_isinit = false;
            t_part = '';
            t_store = '';
			t_giftsendt = '';
            $(document).ready(function() {
            	q_getId();
            	q_gf('', 'z_gift');
            });
             function q_gfPost() {
                q_gt('store', '', 0, 0, 0);
                q_gt('part', '', 0, 0, 0);
				q_gt('giftsendt', '', 0, 0, 0, "");
            }
            function q_gtPost(t_name) {
            	 switch (t_name) {
                    case 'part':
                        t_part = '';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;
                    case 'store':
                        t_store = '';
                        var as = _q_appendData("store", "", true);
                        t_store += '99@全部';
                        for ( i = 0; i < as.length; i++) {
                            t_store += (t_store.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
                        }
                        break;
                    case 'giftsendt':
                        t_giftsendt = '';
                        var as = _q_appendData("giftsendt", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_giftsendt += (t_giftsendt.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
                        break;
                }
                     if (!t_isinit && t_giftsendt.length > 0 ) {
                	t_isinit = true;
                    $('#q_report').q_report({
                        fileName : 'z_gift',
                        options : [{
                        type : '1',
                        name : 'date'
                    }, {/*6*/
                            type : '5',
                            name : 'tsendmemo',
                            value : [q_getPara('report.all')].concat(t_giftsendt.split(','))
						}, {/*2*/
                            type : '2',
                            name : 'bcc',
                            dbf : 'gift',
                            index : 'noa,product',
                            src : 'gift_b.aspx'
                        },{/*3*/
							type : '5',
							name : 'xstore',
							value : t_store.split(',')
						},{/*4*/
							type : '8',
							name : 'xpart',
							value : t_part.split(',')
						}]
                    });
                q_langShow();
                q_popAssign();
                $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker(); 
	             var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
              
            }
            }

            function q_boxClose(s2) {
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