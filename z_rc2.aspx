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
			aPop = new Array(['txtXy_custno', '', 'cust', 'noa,comp', 'txtXy_custno', 'cust_b.aspx']);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_rc2');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_rc2',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy
					}, {
						type : '1', //[2][3]
						name : 'date'
					}, {
						type : '1', //[4][5]
						name : 'mon'
					}, {
						type : '2', //[6][7]
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[8][9]
						name : 'sales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[10][11]
						name : 'product',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '5', //[12]
						name : 'xstype',
						value : [q_getPara('report.all')].concat(q_getPara('rc2.stype').split(','))
					}, {
                        type : '0', //[13] //判斷顯示小數點與其他判斷
                        name : 'acomp',
                        value : q_getPara('sys.comp')
                    }, {
                        type : '6', //[14]
                        name : 'multtgg'
                    }, {
                        type : '6', //[15]
                        name : 'multucc'
                    },{/* [16]*/
                        type : '0',
                        name : 'xproject',
                        value : q_getPara('sys.project').toUpperCase()
                    },{/* [17]*/
                        type : '0',
                        name : 'isspec',
                        value : q_getPara('sys.isspec')
                    }, {/*[18]*/
						type : '6',
						name : 'xy_custno'
					}]
				});
				q_popAssign();
				$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();
				$('#txtMon1').mask(r_picm);
				$('#txtMon2').mask(r_picm);
				
				 if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				
				$('#txtMulttgg').css("width","205px");
				$('#lblMulttgg').css("color","#0000ff");
				$('#lblMulttgg').click(function(e) {
                	q_box("tgg_b2.aspx?;;;;", 'tgg', "40%", "620px", q_getMsg("popTgg"));
                });
                $('#Multucc').css("width","605px");
				$('#txtMultucc').css("width","500px");
				$('#lblMultucc').css("color","#0000ff");
				$('#lblMultucc').click(function(e) {
                	q_box("ucc_b2.aspx?;;;;", 'ucc', "40%", "620px", q_getMsg("popUcc"));
                });
			}

			function q_boxClose(s2) {
				var ret;
                switch (b_pop) {
                	case 'tgg':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xtgg='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xtgg+=ret[i].noa+'.'
                        	}
                        }
                        xtgg=xtgg.substr(0,xtgg.length-1);
                        $('#txtMulttgg').val(xtgg);
                        break;	
                    case 'ucc':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xucc='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xucc+=ret[i].noa+'.'
                        	}
                        }
                        xucc=xucc.substr(0,xucc.length-1);
                        $('#txtMultucc').val(xucc);
                        break;	    
                }   /// end Switch
				b_pop = '';	
			}

			function q_gtPost(s2) {
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