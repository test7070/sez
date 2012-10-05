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
<<<<<<< HEAD
			//aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			function z_carchg() {
			}
			z_carchg.prototype = {
				isInit : false,
				data : {
					carteam : null
				},
				isLoad : function() {
					var isLoad = true;
					for (var x in this.data) {
						isLoad = isLoad && (this.data[x] != null);
					}
					return isLoad;
				}
			};
			t_data = new z_carchg();
			
            $(document).ready(function() {
            	_q_boxClose();
            	q_getId();
                q_gf('', 'z_carchg');
            });
            
            function q_gfPost() {
=======
			t_carteam = "";
			t_calctype  =  "";
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_carchg');
			});
			function q_gfPost() {
>>>>>>> c0214b9bedf293117f497d6cd8196d8aac9eb3ad
				q_gt('carteam', '', 0, 0, 0, "");
			}

			function q_boxClose(t_name) {
			}
<<<<<<< HEAD
			
            function q_gtPost(t_name) {
            	
					switch (t_name) {
					case 'carteam':
						t_data.data['carteam'] = '';
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						break;
				}
				if (t_data.isLoad() && !t_data.isInit) {
					t_data.isInit  =  true;
               $('#q_report').q_report({
                        fileName : 'z_carchg',
                        options : [ {
=======

			function q_gtPost(t_name) {

				switch (t_name) {
					case 'carteam':
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						break;
				}
				if (t_carteam.length > 0) {
					$('#q_report').q_report({
						fileName : 'z_carchg',
						options : [{
>>>>>>> c0214b9bedf293117f497d6cd8196d8aac9eb3ad
							type : '0',
							name : 'accy',
							value : q_getId()[4]
						}, {/*1*/
<<<<<<< HEAD
	                        type : '1',
	                        name : 'date'
	                    }, {/*2*/
	                        type : '2',
	                        name : 'driverno',
	                        dbf : 'driver',
	                        index : 'noa,namea',
	                        src : 'driver_b.aspx'
	                    },{/*3*/
							type : '6',
							name : 'zrc2no'
						},{/*4*/
							type : '8',
							name : 'xcarteam',
							value :  t_data.data['carteam'].split(',')
						}]
                    });
                q_popAssign();
                q_langShow();

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
=======
							type : '1',
							name : 'date'
						}, {/*3*/
							type : '2',
							name : 'driver',
							dbf : 'driver',
							index : 'noa,namea',
							src : 'driver_b.aspx'
						}, {/*4*/
							type : '6',
							name : 'zrc2no'
						},{/*8*/
							type : '8',
							name : 'xcarteam',
							value : t_carteam.split(',')
						}]
					});
					q_popAssign();
					q_langShow();

					$('#txtDate1').mask('999/99/99');
					$('#txtDate1').datepicker();
					$('#txtDate2').mask('999/99/99');
					$('#txtDate2').datepicker();

					var t_date, t_year, t_month, t_day;
					t_date = new Date();
					t_date.setDate(1);
					t_year = t_date.getUTCFullYear() - 1911;
					t_year = t_year > 99 ? t_year + '' : '0' + t_year;
					t_month = t_date.getUTCMonth() + 1;
					t_month = t_month > 9 ? t_month + '' : '0' + t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day > 9 ? t_day + '' : '0' + t_day;
					$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);

					t_date = new Date();
					t_date.setDate(35);
					t_date.setDate(0);
					t_year = t_date.getUTCFullYear() - 1911;
					t_year = t_year > 99 ? t_year + '' : '0' + t_year;
					t_month = t_date.getUTCMonth() + 1;
					t_month = t_month > 9 ? t_month + '' : '0' + t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day > 9 ? t_day + '' : '0' + t_day;
					$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);

					t_carteam  = '';
				}
			}
>>>>>>> c0214b9bedf293117f497d6cd8196d8aac9eb3ad
		</script>
	</head>
	<body>

		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
<<<<<<< HEAD
				<div id="qReport"></div>
=======
				<div id="q_report"></div>
>>>>>>> c0214b9bedf293117f497d6cd8196d8aac9eb3ad
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
