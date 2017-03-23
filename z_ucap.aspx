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
			var uccgaItem = '',uccgbItem='',coinItem='';
			var firstRun = false;
			var t_first=true;
			aPop = new Array(
				['txtXproductno', '', 'ucaucc', 'noa,product', 'txtXproductno', 'ucaucc_b.aspx'],
				['txtXgroupe', 'lblGroupeno', 'adsize', 'noa,mon,memo1,memo2', '0txtXgroupe', ''],
				['txtXgroupf', 'lblGroupfno', 'adsss', 'noa,mon,memo1,memo2', '0txtXgroupf', ''],
				['txtXgroupg', 'lblGroupgno', 'adknife', 'noa,mon,memo1,memo2', '0txtXgroupg', ''],
				['txtXgrouph', 'lblGrouphno', 'adpipe', 'noa,mon,memo1,memo2', '0txtXgrouph', ''],
				['txtXgroupi', 'lblGroupino', 'adtran', 'noa,mon,memo1,memo2', '0txtXgroupi', ''],
				
				['txtXucolor','','adspec','noa,mon,memo,memo1,memo2','0txtXucolor',''],
				['txtXscolor','','adly','noa,mon,memo,memo1,memo2','0txtXscolor',''],
				['txtXclass','','adly','noa,mon,memo,memo1,memo2','0txtXclass',''],
				['txtXclassa','','adly','noa,mon,memo,memo1,memo2','0txtXclassa',''],
				['txtXzinc','','adly','noa,mon,memo,memo1,memo2','0txtXzinc',''],
				['txtXsizea','','adoth','noa,mon,memo,memo1,memo2','0txtXsizea',''],
				['txtXsource','','adpro','noa,mon,memo,memo1,memo2','0txtXsource',''],
				['txtXhard','','addime','noa,mon,memo,memo1,memo2','0txtXhard','']
			);
			var t_auth=undefined,t_isucap2=false;
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				
				//106/03/14 成本表需有uca執行權限才能看
				if(r_rank<'8'){
					q_gt('authority', "where=^^ a.noa='uca' and a.pr_run=1 and a.sssno='"+r_userno+"' ^^", 0, 0, 0, "getauthority",r_accy,1);
					t_auth = _q_appendData("authority", "", true);
					if(t_auth[0]!=undefined){
						t_isucap2=true;
					}
				}else{
					t_isucap2=true;
				}
				
				if (uccgaItem.length == 0) {
					q_gt('uccga', '', 0, 0, 0, "");
				}
				
				 $('#q_report').click(function(e) {
				 	for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data().info.reportData[i].report=='z_ucap2' && !t_isucap2)
							$('#q_report div div').eq(i).hide();
					}
				 	
					if(!(q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO')){
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report=='z_ucap6')
								$('#q_report div div').eq(i).hide();
						}
					}
					
					$('#q_report div div .radio').parent().each(function(index) {
						if(!$(this).is(':hidden') && t_first){
							$(this).children().removeClass('nonselect').addClass('select');
							t_first=false;
						}
						if($(this).is(':hidden') && t_first){
							$(this).children().removeClass('select').addClass('nonselect');
						}
					});
				});
				
			});
			
			function imgshow(img) {
				q_box(img.src+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
			}
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ucap',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy
					}, {
						type : '6', //[2]
						name : 'xproductno'
					}, {
						type : '2', //[3][4]
						name : 'spno',
						dbf : 'uca',
						index : 'noa,product',
						src : 'uca_b.aspx'
					}, {
						type : '6', //[5]
						name : 'xmon'
					}, {
						type : '5', //[6]
						name : 'xtypea',
						value : [q_getPara('report.all')].concat(q_getPara('uca.typea').split(','))
					}, {
						type : '5', //[7]
						name : 'xgroupano',
						value : uccgaItem.split(',')
					}, {
						type : '0', //[8]
						name : 'worker',
						value : r_name
					}, {
						type : '8', //[9]
						name : 'isprice',
						value : '1@顯示單價'.split(',')
					}, {
						type : '2', //[10][11]
						name : 'xstationgno',
						dbf : 'stationg',
						index : 'noa,namea',
						src : 'stationg_b.aspx'
					}, {
						type : '6', //[12]
						name : 'xstyle'
					}, {
						type : '6', //[13]
						name : 'xspec'
					}, {
						type : '6', //[14]
						name : 'xgroupe'
					}, {
						type : '6', //[15]
						name : 'xgroupf'
					}, {
						type : '6', //[16]
						name : 'xgroupg'
					}, {
						type : '6', //[17]
						name : 'xgrouph'
					}, {
						type : '6', //[18]
						name : 'xgroupi'
					}, {
						type : '6', //[19]
						name : 'xucolor'
					}, {
						type : '6', //[20]
						name : 'xscolor'
					}, {
						type : '6', //[21]
						name : 'xclass'
					}, {
						type : '6', //[22]
						name : 'xclassa'
					}, {
						type : '6', //[23]
						name : 'xzinc'
					}, {
						type : '6', //[24]
						name : 'xsizea'
					}, {
						type : '6', //[25]
						name : 'xsource'
					}, {
						type : '6', //[26]
						name : 'xhard'
					}, {
						type : '5', //[31]
						name : 'xgroupd',
						value : '#non@全部,ODM,OBM,OEM'.split(',')
					}, {
						type : '1', //[27][28]
						name : 'xsize1'
					}, {
						type : '1', //[29][30]
						name : 'xsize2'
					}, {
						type : '2', //[32][33]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[34][35]
						name : 'xprocess',
						dbf : 'process',
						index : 'noa,process',
						src : 'process_b.aspx'
					}, {
						type : '2', //[36][37]
						name : 'xstation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '6', //[38]
						name : 'zproduct'
					}, {
						type : '8', //[39]
						name : 'xsbcost',
						value : '1@顯示實際大於標準成本'.split(',')
					}, {
						type : '5', //[40]
						name : 'xorder',
						value : '#non@依階層,rate@依毛利'.split(',')
					}, {
						type : '1', //[41][42]
						name : 'xrate'
					}, {
						type : '8', //[43]
						name : 'xgno0',
						value : '1@顯示子階成本'.split(',')
					},{
						type : '0', //[44] //標準成本bdate//抓上上的月-1年
						name : 'stbdate',
						value : q_cdn(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',-1).substr(0,r_lenm)+'/01',-1),-365).substr(0,r_lenm)+'/01'
					},{
						type : '0', //[45] //標準成本edate//抓上上的月
						name : 'stedate',
						value : q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',-1).substr(0,r_lenm)+'/01',-1)
					}, {
						type : '8', //[46]
						name : 'xproserch',
						value : '1@模糊查詢*'.split(',')
					}, {
						type : '5', //[47]
						name : 'xgroupbno',
						value : uccgbItem.split(',')
					}, {
						type : '5', //[48]
						name : 'xcoin',
						value : coinItem.split(',')
					}, {
						type : '6', //[49]
						name : 'xvccnum'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXmon').mask(r_picm);
				$('#txtXmon').val(q_cdn(q_date().substr(0, r_lenm)+'/01',-1).substr(0, r_lenm));
				/*if (window.parent.q_name == 'uca') {
					var wParent = window.parent.document;
					$('#txtSpno1a').val(wParent.getElementById("txtNoa").value);
					$('#txtSpno2a').val(wParent.getElementById("txtNoa").value);
					$('#txtSpno1b').val(wParent.getElementById("txtProduct").value);
					$('#txtSpno2b').val(wParent.getElementById("txtProduct").value);
					$('#txtXproductno').val(wParent.getElementById("txtNoa").value);
				}*/
				
				if(q_getHref() && window.parent.q_name == 'uca'){
					$('#txtSpno1a').val(q_getHref()[1]);
					$('#txtSpno2a').val(q_getHref()[1]);
					$('#txtSpno1b').val(q_getHref()[3]);
					$('#txtSpno2b').val(q_getHref()[3]);
					$('#txtXproductno').val(q_getHref()[1]);
					$('#btnOk').click();
				}else{
					$('#Xtypea select').val('2');
				}
				
				firstRun = false;
				
				$('#txtSpno1a').blur(function() {
					if(!emp($('#txtSpno1a').val()) &&!emp($('#txtSpno2a').val())){
						if($('#txtSpno2a').val()<$('#txtSpno1a').val()){
							//alert('【'+$('#txtSpno2a').val()+'】編號小於【'+$('#txtSpno1a').val()+'】編號');
							$('#txtSpno2a').val($('#txtSpno1a').val());
							$('#txtSpno2b').val($('#txtSpno1b').val());
						}
					}
				});
				$('#txtSpno2a').blur(function() {
					if(!emp($('#txtSpno1a').val()) &&!emp($('#txtSpno2a').val())){
						if($('#txtSpno2a').val()<$('#txtSpno1a').val()){
							//alert('【'+$('#txtSpno2a').val()+'】編號小於【'+$('#txtSpno1a').val()+'】編號');
							$('#txtSpno1a').val($('#txtSpno2a').val());
							$('#txtSpno1b').val($('#txtSpno2b').val());
						}
					}
				});
				$('.option').css('width','700px');
				$('.option .a1').css('width','690px');
				$('.option .a2').css('width','340px');
				$('.q_report .option div .c2').css('width','130px');
				$('.q_report .option div .c3').css('width','130px');
				$('.q_report .option div .c5').css('width','245px');
				$('.q_report .option div .c4').css('width','250px');
				$('#Isprice').css('width','340px');
				$('#chkIsprice').css('width','200px');
				$('#chkIsprice span').css('width','150px');
				$('#Isprice').css('height','30px');
				
				$('#Xsize1').css('width','340px');
				$('#txtXsize11').css('width','110px');
				$('#txtXsize12').css('width','110px');
				$('#Xsize2').css('width','340px');
				$('#txtXsize21').css('width','110px');
				$('#txtXsize22').css('width','110px');
				
				$('#txtXrate1').css('text-align','right');
				$('#txtXrate2').css('text-align','right');
				$('#txtXsize11').css('text-align','right');
				$('#txtXsize12').css('text-align','right');
				$('#txtXsize21').css('text-align','right');
				$('#txtXsize22').css('text-align','right');
				
				$('#Xsbcost').css('width','340px');
				$('#chkXsbcost').css('width','250px');
				$('#chkXsbcost span').css('width','200px');
				$('#Xsbcost .label').css('width','0px');
				$('#Xsbcost').css('height','30px');
				
				$('#Xrate').css('width','340px');
				$('#txtXrate1').css('width','110px');
				$('#txtXrate2').css('width','110px');
				
				$('#Xgno0').css('width','340px');
				$('#chkXgno0').css('width','250px');
				$('#chkXgno0 span').css('width','200px');
				$('#Xgno0 .label').css('width','0px');
				$('#Xgno0').css('height','30px');
				//$('#Xgno0 [type="checkbox"]').prop('checked',true);
				
				$('#Xproserch').css('width','340px');
				$('#chkXproserch').css('width','250px');
				$('#chkXproserch span').css('width','200px');
				$('#Xproserch .label').css('width','0px');
				$('#Xproserch').css('height','30px');
				
				$('#lblXvccnum').css('font-size','12px');
				$('#txtXvccnum').css('text-align','right');
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						uccgaItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						q_gt('uccgb', '', 0, 0, 0, "");
						break;
					case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						uccgbItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgbItem = uccgbItem + (uccgbItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						coinItem = "#non@本幣";
						for ( i = 0; i < as.length; i++) {
							coinItem = coinItem + (coinItem.length > 0 ? ',' : '') + as[i].coin + '@' + as[i].coin;
						}
						firstRun = true;
						break;
				}
				if ((uccgaItem.length > 0) && (uccgbItem.length > 0) && firstRun) {
					q_gf('', 'z_ucap');
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
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>