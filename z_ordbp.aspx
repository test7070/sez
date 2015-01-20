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
            	q_getId();
            	q_gf('', 'z_ordbp');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_ordbp',
                        options : [{/*[1][2]*/
							type : '1',
							name : 'noa'
						},{/*[3]*/
	                        type : '5',
	                        name : 'xkind',
	                        value : [q_getPara('report.all')].concat(q_getPara('ordb.kind').split(','))
                    	},{/*[4][5]*/
							type : '1',
							name : 'date'
						}, {/*[6][7]*/
	                        type : '2',
	                        name : 'xcno',
	                        dbf : 'acomp',
	                        index : 'noa,acomp',
	                        src : 'acomp_b.aspx'
	                    }, {/*[8][9]*/
	                        type : '2',
	                        name : 'xpartno',
	                        dbf : 'part',
	                        index : 'noa,part',
	                        src : 'part_b.aspx'
	                    }, {/*[10][11]*/
	                        type : '2',
	                        name : 'xtggno',
	                        dbf : 'tgg',
	                        index : 'noa,comp',
	                        src : 'tgg_b.aspx'
	                    }, {/*[12][13]*/
	                        type : '2',
	                        name : 'xproductno',
	                        dbf : 'bcc',
	                        index : 'noa,product',
	                        src : 'bcc_b.aspx'
	                    },{/*[14]*/
	                        type : '5',
	                        name : 'apv',
	                        value : [q_getPara('report.all')].concat('Y@核准,N@未核准'.split(','))
                    	},{/*[15]*/
	                        type : '5',
	                        name : 'enda',
	                        value : [q_getPara('report.all')].concat('1@結案,0@未結案'.split(','))
                    	}]
                    });
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
	                    
				if (window.parent.q_name == 'ordb') {
					var wParent = window.parent.document;
					
					$('#txtNoa1').val(wParent.getElementById("txtNoa").value);
					$('#txtNoa2').val(wParent.getElementById("txtNoa").value);
				}
				
            }
            
            function q_boxClose(s2) {
            }
            
            function q_gtPost(s2) {
            }
            
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<a id="lblDatea" style="display:none;">採購日期</a>
			<input id="textDatea" type="text" class="txt c1" style="display:none;width:120px;"/>
			<input id="btnOrdc" type="button" class="txt c1" style="display:none;" value="批次轉採購單" />
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="exportordc" style="background:pink;display:none; position: absolute;top:100px;left:200px;width:600px;height:400px;">
			<table style="width:100%;height:100%;border: 2px white double;">
				<tr style="height:1px;">
					<td style="width:40%;"></td>
					<td style="width:60%;"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center; color:darkblue;"><a>已匯出至採購單的,須先刪除採購單才可重新匯出</a></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>採購日期</a></td>
					<td><input id="textDatea_a" type="text" style="width:40%;"/></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>廠商</a></td>
					<td>
						<input id="textTggno_a" type="text" style="width:45%;float:left;"/>
						<input id="textTgg_a" type="text" style="width:45%;float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>請購單號</a></td>
					<td>
						<input id="textBno_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEno_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>請購日期</a></td>
					<td>
						<input id="textBodate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEodate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>最慢需求日</a></td>
					<td>
						<input id="textBldate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEldate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>物品編號</a></td>
					<td>
						<input id="textBproductno_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEproductno_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>合約有效日期</a></td>
					<td>
						<input id="textBedate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEedate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>成交日期</a></td>
					<td>
						<input id="textBfdate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEfdate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>轉來</a></td>
					<td><input id="textWorkgno_a" type="text" style="width:80%;"/></td>
				</tr>
				<tr>
					<td align="center"><input id="btnExport_a" type="button" style="width:100px;" value="匯出採購"/></td>
					<td align="center"><input id="btnClose_a" type="button" style="width:100px;" value="關閉"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>