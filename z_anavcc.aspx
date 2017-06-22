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
			var uccgaItem = '';
			var custtypeItem = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				if(uccgaItem.length == 0){
					q_gt('uccga', '', 0, 0, 0, "");
				}
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_anavcc',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'xdate'
					}, {
						type : '1', //[4][5]
						name : 'xmon'
					}, {
						type : '2', //[6][7]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[8][9]
						name : 'xsales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[10][11]
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '1', //[12][13]
						name : 'xbmon'
					}, {
						type : '1', //[14][15]
						name : 'xemon'
					}, {
						type : '6', //[16]
						name : 'xyear'
					}, {
                        type : '5', //[17]
                        name : 'xuccgroupano',
                        value : uccgaItem.split(',')
					}, {
                        type : '6', //[18]
                        name : 'xsalesgroupano'
					}, {
                        type : '5', //[19]
                        name : 'custtype',
                        value : custtypeItem.split(',')
					},{
                        type : '5', //[20]
                        name : 'vccstype',
                        value : (' @全部,'+q_getPara('vcc.stype')).split(',')
					}, {
						type : '6', //[21]
						name : 'lostdate'
					}, {
                        type : '5', //[22]
                        name : 'lostorder',
                        value : "0@交易日,1@業務".split(',')
					}, {
                        type : '5', //[23]
                        name : 'xorder',
                        value : "money@金額,mount@數量".split(',')
					},{
                        type : '6', //[24] //4-4
                      	name : 'multcust'
                    },{
                        type : '6', //[25] //5-1
                      	name : 'multucc'
                    },{
						type : '0', //[26]
						name : 'rlen',
						value : r_len
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				
				$('#txtXmon1').mask(r_picm);
				$('#txtXmon2').mask(r_picm);
				$('#txtXyear').mask(r_pic);
				$('#txtXyear').val(q_date().substr(0,r_len));
				$('#txtXbmon1').val(q_date().substr(0,r_len)+'/01').mask(r_picm);
				$('#txtXbmon2').val(q_date().substr(0,r_len)+'/12').mask(r_picm);
				$('#txtXemon1').val(q_date().substr(0,r_len)+'/01').mask(r_picm);
				$('#txtXemon2').val(q_date().substr(0,r_len)+'/12').mask(r_picm);
				$('#txtLostdate').val(100);
				//$('#Xuccgroupano select').css('width','150px');
				
				$('#Multcust').css("width","607px");
				$('#txtMultcust').css("width","515px");
				$('#lblMultcust').css("color","#0000ff");
				$('#lblMultcust').click(function(e) {
	                q_box("cust_b2.aspx?;;;;", 'cust', "600px", "90%", q_getMsg("popCust"));
	            });
	            
	            $('#Multucc').css("width","607px");
				$('#txtMultucc').css("width","515px");
				$('#lblMultucc').css("color","#0000ff");
				$('#lblMultucc').click(function(e) {
	                q_box("ucc_b2.aspx?;;;;", 'ucc', "600px", "90%", q_getMsg("popUcc"));
	            });
			}

			function q_boxClose(s2) {
				var ret;
                switch (b_pop) {
                	case 'cust':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xcust='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xcust+=ret[i].noa+'.'
                        	}
                        }
                        xcust=xcust.substr(0,xcust.length-1);
                        $('#txtMultcust').val(xcust);
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
                }	
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
                        var as = _q_appendData("uccga", "", true);
						uccgaItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }
						q_gt('custtype', '', 0, 0, 0, "");
                        break;
					case 'custtype':
                        var as = _q_appendData("custtype", "", true);
                        custtypeItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            custtypeItem = custtypeItem + (custtypeItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }
						q_gf('', 'z_anavcc');
						break;
				}
			}
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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