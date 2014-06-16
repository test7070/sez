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
					options : [{/* [1]*/
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {/*1 [2][3]*/
						type : '1',
						name : 'xnoa'
					}, {/*2 [4]*/
						type : '5',
						name : 'xkind',
						value : [q_getPara('report.all')].concat(q_getPara('ordb.kind').split(','))
					}, {/*3 [5][6]*/
						type : '1',
						name : 'xdate'
					}, {/*4 [7][8]*/
						type : '2',
						name : 'xcno',
						dbf : 'acomp',
						index : 'noa,acomp',
						src : 'acomp_b.aspx'
					}, {/*5 [9][10]*/
						type : '2',
						name : 'xtggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {/*6 [11][12]*/
						type : '2',
						name : 'xproductno',
						dbf : 'bcc',
						index : 'noa,product',
						src : 'bcc_b.aspx'
					}, {/*7 [13][14]*/
						type : '1',
						name : 'yodate'
					}, {/*8 [15][16]*/
						type : '2',
						name : 'yproductno',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {/*9 [17]*/
						type : '6',
						name : 'yordbno'
					}, {/*10 [18]*/
						type : '6',
						name : 'yordeno'
					}, {/*11 [19]*/
						type : '6',
						name : 'yworkgno'
					}, {/* [20]*/
						type : '0',
						name : 'ykind',
						value : q_getPara('ordb.kind')
					}
					//---追蹤表用----------------------------------------------------------
					, {/*12 [21][22]*/
						type : '1',
						name : 'zdatea'
					}, {/*13 [23][24]*/
						type : '1',
						name : 'zldate'
					}, {/*14 [25][26]*/
						type : '2',
						name : 'zproductno',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {/*15 [27]*/
						type : '5',
						name : 'zordc',
						value : [q_getPara('report.all')].concat('1@已採購,2@未採購'.split(','))
					}
					//---追蹤表用----------------------------------------------------------
					, {/*16 [28]*/
						type : '5',
						name : 'showquat',
						value : '#non@未詢價或未議價,1@未詢價,2@未議價'.split(',')
					}, {/*17 [29]*/
						type : '6',
						name : 'zordbno'
					}, {/*18 [30][31]*/
						type : '1',
						name : 'znoa'
					}, {/*19 [32]*/
						type : '5',
						name : 'sort08',
						value : 'p@物品,pm@物品+月份,pd@物品+三旬,tp@廠商+物品,tpm@廠商+物品+月份,tpd@廠商+物品+三旬'.split(',')
					}, {/*20[33]*/
						type : '5',
						name : 'option08',
						value : ' @全部,ordb@未採購量,ordc@已採購量,cancel@採購取消'.split(',')
					}, {/*21[34]*/
						type : '8',
						name : 'isdetails',
						value : '1@明細'.split(',')
					}]
				});
				q_popAssign();

				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();

				$('#txtYodate1').mask('999/99/99');
				$('#txtYodate1').datepicker();
				$('#txtYodate2').mask('999/99/99');
				$('#txtYodate2').datepicker();

				$('#txtZdatea1').mask('999/99/99');
				$('#txtZdatea1').datepicker();
				$('#txtZdatea2').mask('999/99/99');
				$('#txtZdatea2').datepicker();

				$('#txtZldate1').mask('999/99/99');
				$('#txtZldate1').datepicker();
				$('#txtZldate2').mask('999/99/99');
				$('#txtZldate2').datepicker();

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
				var t_para = ( typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3]).split('&');
				for (var i = 0; i < t_para.length; i++) {
					if (t_para[i].indexOf('noa=') >= 0) {
						t_no = t_para[i].replace('noa=', '');
						if (t_no.length > 0) {
							$('#txtZordbno').val(t_no);
							$('#txtZnoa1').val(t_no);
							$('#txtZnoa2').val(t_no);
						}
					} else if (t_para[i] == 'action=z_ordbp06') {
						$('#q_report').find('span.radio').eq(5).parent().click();
						$('#q_report').data('info').execute($('#q_report'));
					}
				}
				$('.c4').css("width", "120px");
				$('#Sort08 select').val('tpm');
				$('#Option08 select').val('ordb');
				//-------------------------------------------------------------------------------
				$('#textDatea').mask('999/99/99');
				$('#textDatea').datepicker();
				$('#textDatea').val(q_date);
				$('#q_report .report').find('.radio').click(function(e) {
					$('#lblDatea').hide();
					$('#textDatea').hide();
					$('#btnOrdc').hide();
				});
				$('#q_report .report').find('.text').click(function(e) {
					$('#lblDatea').hide();
					$('#textDatea').hide();
					$('#btnOrdc').hide();
				});
				$('#q_report .report').find('.radio').eq(7).click(function(e) {
					$('#lblDatea').show();
					$('#textDatea').show();
					$('#btnOrdc').show();
				});
				$('#q_report .report').find('.text').eq(7).click(function(e) {
					$('#lblDatea').show();
					$('#textDatea').show();
					$('#btnOrdc').show();
				});
				//-------------------------------------------------------------------------------
				$('#textDatea_a').mask(r_picd);
				$('#textBodate_a').mask(r_picd);
				$('#textEodate_a').mask(r_picd);
				$('#textBldate_a').mask(r_picd);
				$('#textEldate_a').mask(r_picd);
				$('#textBedate_a').mask(r_picd);
				$('#textEedate_a').mask(r_picd);
				$('#textBfdate_a').mask(r_picd);
				$('#textEfdate_a').mask(r_picd);

				$('#textDatea_a').datepicker();
				$('#textDatea_a').val(q_date);
				$('#textBodate_a').datepicker();
				$('#textEodate_a').datepicker();
				$('#textBldate_a').datepicker();
				$('#textEldate_a').datepicker();
				$('#textBedate_a').datepicker();
				$('#textEedate_a').datepicker();
				$('#textBfdate_a').datepicker();
				$('#textEfdate_a').datepicker();

				$('#btnOrdc').click(function(e) {
					var t_datea = $('#textDatea').val();
					var t_kind = $('#Xkind select').val();
					var t_btggno = $('#txtXtggno1a').val();
					var t_etggno = $('#txtXtggno2a').val();
					var t_bproductno = $('#txtXproductno1a').val();
					var t_eproductno = $('#txtXproductno2a').val();
					var t_bodate = $('#txtYodate1').val();
					var t_eodate = $('#txtYodate2').val();
					var t_ordbno = $('#txtYordbno').val();
					var t_bldate = $('#txtZldate1').val();
					var t_eldate = $('#txtZldate2').val();
					var t_option = $('#Option08 select').val();

					if (t_datea.length > 0) {
						Lock(1, {
							opacity : 0
						});
						q_func('qtxt.query.ordb', 'ordb.txt,ordc,' + r_userno + ';' + encodeURI(r_name) + ';' + encodeURI(q_getPara('key_ordc')) + ';' + encodeURI(t_datea) + ';' + encodeURI(t_kind) + ';' + encodeURI(t_btggno) + ';' + encodeURI(t_etggno) + ';' + encodeURI(t_bproductno) + ';' + encodeURI(t_eproductno) + ';' + encodeURI(t_bodate) + ';' + encodeURI(t_eodate) + ';' + encodeURI(t_ordbno) + ';' + encodeURI(t_bldate) + ';' + encodeURI(t_eldate) + ';' + encodeURI(t_option) + ';' + encodeURI(q_getPara('ordb.sign')));
					} else
						alert('請輸入採購日期。');

					/*$('#exportordc').toggle();
					 $('#textBno_a').val($('#txtNoa').val());
					 $('#textEno_a').val($('#txtNoa').val());*/
				});
				$('#btnExport_a').click(function(e) {
					var t_tggno = $('#textTggno_a').val();
					var t_datea = $('#textDatea_a').val();
					var t_bedate = $('#textBedate_a').val();
					var t_eedate = $('#textEedate_a').val();
					var t_bfdate = $('#textBfdate_a').val();
					var t_efdate = $('#textEfdate_a').val();
					var t_bodate = $('#textBodate_a').val();
					var t_eodate = $('#textEodate_a').val();
					var t_bldate = $('#textBldate_a').val();
					var t_eldate = $('#textEldate_a').val();
					var t_bproductno = $('#textBproductno_a').val();
					var t_eproductno = $('#textEproductno_a').val();
					var t_workgno = $('#textWorkgno_a').val();
					var t_bno = $('#textBno_a').val();
					var t_eno = $('#textEno_a').val();
					if (t_datea.length > 0) {
						Lock(1, {
							opacity : 0
						});
						q_func('qtxt.query.ordb', 'ordb.txt,ordc,' + r_userno + ';' + encodeURI(r_name) + ';' + encodeURI(q_getPara('key_ordc')) + ';' + encodeURI(t_datea) + ';' + encodeURI(t_tggno) + ';' + t_bedate + ';' + t_eedate + ';' + t_bfdate + ';' + t_efdate + ';' + t_workgno + ';' + t_bno + ';' + t_eno + ';' + t_bodate + ';' + t_eodate + ';' + t_bldate + ';' + t_eldate + ';' + t_bproductno + ';' + t_eproductno);
					} else
						alert('請輸入採購日期。');
				});
				$('#btnClose_a').click(function(e) {
					$('#exportordc').toggle();
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.ordb':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_msg = '';
							var MsgCount = 0;
							for (var i = 0; i < as.length; i++) {
								var thisMsg = $.trim(as[i].memo);
								if (thisMsg.substring(0, 4) != 'noa=') {
									t_msg += (t_msg.length > 0 ? '\r\n' : '') + as[i].memo;
								}else{
									var thisOrdcNoa = $.trim(thisMsg.substr(4));
									q_func('sign.q_signForm', 'ordc,'+r_accy+','+ thisOrdcNoa);
									MsgCount++;
								}
							}
							alert(t_msg);
							if (as.length > (MsgCount+1))
								window.open("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";action=z_ordbp06;" + r_accy);
						} else {
							alert('無資料!');
						}
						Unlock(1);
						break;
					default:
						break;
				}
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