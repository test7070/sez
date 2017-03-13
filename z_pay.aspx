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
			aPop = new Array(
				['txtXcno', '', 'acomp', 'noa,acomp,nick', 'txtXcno', "acomp_b.aspx"],
				['txtXpart', '', 'part', 'part,noa', 'txtXpart', "part_b.aspx"]
			);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			
			$(document).ready(function() {
				q_getId();
				$('#q_report').click(function(e) {
					if(q_getPara('sys.isAcccUs')!='1')
						$('#Xcoin').hide();
				});
				
				if(q_db.toUpperCase()=='DC'){
					q_gt('part', '', 0, 0, 0, "");
				}else{
					q_gt('flors_coin', '', 0, 0, 0, ""); //DC沒有flors_coin_load
				}
				
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_pay',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy + "_" + r_cno
					}, {
						type : '6', //[2]
						name : 'xcno'
					}, {
						type : '5', //[3]
						name : 'xpart',
						value: z_part.split(',')
					}, {
						type : '1', //[4][5]
						name : 'date'
					}, {
						type : '2', //[6][7]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '1', //[8][9]
						name : 'xdate'
					}, {
						type : '6', //[10]
						name : 'xmon'
					}, {
						type : '6', //[11]
						name : 'partno'
					}, {
						type : '2', //[12][13]
						name : 'xpartno',
						dbf : 'part',
						index : 'noa,part',
						src : 'part_b.aspx'
					}, {
						type : '0', //[14]
						name : 'xaccy',
						value : r_accy
					}, {
						type : '1', //[15][16]
						name : 'smon'
					}, {
						type : '2', //[17][18]
						name : 'sales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[19][20]
						name : 'product',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '2', //[21][22]
						name : 'xcardeal',
						dbf : 'cardeal',
						index : 'noa,comp',
						src : 'cardeal_b.aspx'
					}, {//[23]
						type : '8',
						name : 'xoption01',
						value : q_getMsg('toption01').split('&')
					}, {
						type : '5', //[24]
						name : 'xrc2stype',
						value : [q_getPara('report.all')].concat(q_getPara('rc2.stype').split(','))
					}, {
						type : '5', //[25]
						name : 'xcoin', //幣別
						value : z_coin.split(',')
					}, {
						type : '0', //[26]
						name : 'rc2taxtype',
						value : q_getPara('rc2.d4taxtype')
					}, {//DC
						type : '6', //[27]
						name : 'xaccno'
					}, {//DC
                        type : '2', //[28][29]
                        name : 'xacc1',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }]
				});
				q_popAssign();
				q_getFormat();
                q_langShow();
				
				$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();
				$('#txtXdate1').mask('99/99');
				$('#txtXdate2').mask('99/99');
				$('#txtXmon').mask(r_picm);
				$('#txtSmon1').mask(r_picm);
				$('#txtSmon2').mask(r_picm);
				
				$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtXmon').val(q_date().substr(0,r_lenm));
				$('#txtSmon1').val(q_date().substr(0,r_lenm));
				$('#txtSmon2').val(q_date().substr(0,r_lenm));
				$('#txtXdate1').val(q_date().substr(r_len+1,2) + '/01');
				
				$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				$('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1).substr(r_len+1));
               	
				if(q_getPara('sys.isAcccUs')!='1')
					$('#Xcoin').hide();
			}

			function q_boxClose(s2) {
			}

			var z_coin='',z_part='';
			function q_gtPost(t_name) {
                switch (t_name) {
                	case 'flors_coin':
                		z_coin='#non@本幣';
                		var as = _q_appendData("flors", "", true);
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						
						if(z_coin!='#non@本幣')//有外幣
							z_coin+=',ALL@全部';
							
						q_gt('part', '', 0, 0, 0, "");
                	break;
                	case 'part':
                		z_part='#non@全部';
                		var as = _q_appendData("part", "", true);
						for ( i = 0; i < as.length; i++) {
							z_part+=','+as[i].partno+'@'+as[i].part;
						}
						q_gf('', 'z_pay');
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
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>