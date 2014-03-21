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
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_workgg');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workgg',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'xdate'
					}]
				});
				q_langShow();
				q_popAssign();
				q_getFormat();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXbmon1').val()))
						$('#txtXbmon1').val(r_accy+'/01');
					if(emp($('#txtXbmon2').val()))
						$('#txtXbmon2').val(r_accy+'/12');
					if(emp($('#txtXemon1').val()))
						$('#txtXemon1').val(r_accy+'/01');
					if(emp($('#txtXemon2').val()))
						$('#txtXemon2').val(r_accy+'/12');
					var t_bdate='#non',t_edate='#non',t_bmon='#non',t_emon='#non',t_bcustno='#non',t_ecustno='#non';
					var t_bsalesno='#non',t_esalesno='#non',t_bproductno='#non',t_eproductno='#non';
					var t_xbbmon='#non',t_xbemon='#non',t_xebmon='#non',t_xeemon='#non';
					var t_xbyear='#non',t_xeyear='#non';
					if(!emp($('#txtCust1a').val()))
						t_bcustno=encodeURI($('#txtCust1a').val());
					if(!emp($('#txtCust2a').val()))
						t_ecustno=encodeURI($('#txtCust2a').val());
					if(!emp($('#txtSales1a').val()))
						t_bsalesno=encodeURI($('#txtSales1a').val());
					if(!emp($('#txtSales2a').val()))
						t_esalesno=encodeURI($('#txtSales2a').val());
					if(!emp($('#txtProduct1a').val()))
						t_bproductno=encodeURI($('#txtProduct1a').val());
					if(!emp($('#txtProduct2a').val()))
						t_eproductno=encodeURI($('#txtProduct2a').val());
					if(txtreport=='z_anavcc2_1' ||txtreport=='z_anavcc2_2' ||txtreport=='z_anavcc2_3'){
						if(!emp($('#txtDate1').val()))
							t_bdate=encodeURI($('#txtDate1').val());
						if(!emp($('#txtDate2').val()))
							t_edate=encodeURI($('#txtDate2').val());
						if(!emp($('#txtXmon1').val()))
							t_bmon=encodeURI($('#txtXmon1').val());
						if(!emp($('#txtXmon2').val()))
							t_emon=encodeURI($('#txtXmon2').val());
						q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_bdate + ';' + t_edate + ';' +
						t_bmon + ';' + t_emon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}else if(txtreport=='z_anavcc2_Compare1' ||txtreport=='z_anavcc2_Compare2'){
						if(!emp($('#txtXbmon1').val()))
							t_xbbmon=encodeURI($('#txtXbmon1').val());
						if(!emp($('#txtXbmon2').val()))
							t_xbemon=encodeURI($('#txtXbmon2').val());
						if(!emp($('#txtXemon1').val()))
							t_xebmon=encodeURI($('#txtXemon1').val());
						if(!emp($('#txtXemon2').val()))
							t_xeemon=encodeURI($('#txtXemon2').val());
						q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbbmon + ';' + t_xbemon + ';' +
						t_xebmon + ';' + t_xeemon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}else if(txtreport=='z_anavcc2_Custyear'||txtreport=='z_anavcc2_Productyear'){
						if(!emp($('#txtXyear1').val()))
							t_xbyear=encodeURI($('#txtXyear1').val());
						if(!emp($('#txtXyear2').val()))
							t_xeyear=encodeURI($('#txtXyear2').val());
							if(txtreport=='z_anavcc2_Custyear')
								q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbyear + ';' + t_xeyear + ';' + t_bcustno + ';' + t_ecustno + ';');
							else
								q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbyear + ';' + t_xeyear + ';' + t_bproductno + ';' + t_eproductno + ';');
					}
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
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
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container" style="width:2000px;">
				<div id="q_report"> </div>
				<input type="button" id="btnXXX" style="float:left; width:80px;font-size: medium;" value="權限"/>
			</div>
			<div id="chartCtrl" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='barChart2'> </div>
			</div>
			<div class="prt" style="margin-left: -40px;display:none;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="q_acDiv" style="display: none;"><div> </div></div>
	</body>
</html>