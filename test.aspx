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
            aPop = new Array(['txtXpart', '', 'part', 'noa,part', 'txtXpart', "part_b.aspx"]);
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_ummst');
                
                $('#q_report').click(function(e) {
                	if(q_getPara('sys.isAcccUs')!='1')
						$('#Xcoin').hide();
				});
            });
            
            function q_gfPost() {
            	q_gt('flors_coin', '', 0, 0, 0, "");
            }

            function q_boxClose(s2) {
            }

            var z_coin='';
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
						LoadFinish();
                	break;
                }
	         }
	         function LoadFinish(){
	         	$('#q_report').q_report({
                    fileName : 'z_ummst',
                    options : [{
                        type : '6', //[1]  1
                        name : 'xcno'
                    }, {
                        type : '6', //[2]    2
                        name : 'xpart'
                    }, {
                        type : '1', //[3][4]   3
                        name : 'date'
                    }, {
                        type : '2', //[5][6]  4
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '1', //[7][8]  5
                        name : 'xdate'
                    }, {
                        type : '0',
                        name : 'accy', //[9]
                        value : r_accy + "_" + r_cno
                    }, {
                        type : '0', //[10]  
                        name : 'xaccy',
                        value : r_accy
                    }, {
                        type : '2', //[11][12]  6
                        name : 'scno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    }, {
                        type : '1', //[13][14]  7
                        name : 'smon'
                    }, {
                        type : '2', //[15][16]   8
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[17][18]   9
                        name : 'product',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '6', //[19]   10
                        name : 'xmemo'
                    }, {
                        type : '6', //[20] 11
                        name : 'paytype'
                    }, {//[21]   12
                        type : '8',  
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }, {
						type : '0', //[22] //判斷vcc是內含或應稅 內含不抓vcca
						name : 'vcctax',
						value : q_getPara('sys.d4taxtype')
					},{
						type : '0', //[23]  圖片路徑
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ummst.aspx','')
					},{
						type : '0', //[24]
						name : 'db',
						value : q_db
					},{
						type : '0', //[25]
						name : 'proj',
						value : q_getPara('sys.project')
					}, {
                        type : '6', //[26]  13  本張單號    z_umm_rk01 用
                        name : 'curnoa'
                    }]
                });
                q_popAssign();
				q_getFormat();
				q_langShow();

				if (r_len == 4) {
					$.datepicker.r_len = 4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				}
				
                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                $('#txtXdate1').mask('99/99');
                $('#txtXdate2').mask('99/99');
                $('#txtSmon1').mask(r_picm);
                $('#txtSmon2').mask(r_picm);
                //$('#Xmemo').removeClass('a2').addClass('a1');
                /*$('#txtXmemo').css('width', '85%');
                $('.q_report .report').css('width', '420px');
                $('.q_report .report div').css('width', '200px');
				$('#Curnoa').removeClass('a2').addClass('a1');
                $('#txtCurnoa').css('width', '85%');
                */
                
                $('#txtDate1').val(q_date().substr(0, r_lenm) + '/01');
                $('#txtSmon1').val(q_date().substr(0, r_lenm));
                $('#txtSmon2').val(q_date().substr(0, r_lenm));
				
				var t_edate=q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 45).substr(0, r_lenm) + '/01', -1);	
                $('#txtDate2').val(t_edate);
                
                $('#txtXdate1').val(q_date().substr(r_len+1, 2)+ '/01');
                $('#txtXdate2').val(t_edate.substr(r_len+1));
                
                var tmp = document.getElementById("txtPaytype");
                var selectbox = document.createElement("select");
                selectbox.id="combPay";
                selectbox.style.cssText ="width:15px;font-size: medium;";
                //selectbox.attachEvent('onchange',combPay_chg);
                //selectbox.onchange="combPay_chg";
                tmp.parentNode.appendChild(selectbox,tmp);
                q_cmbParse("combPay", '全部,'+q_getPara('vcc.paytype')); 
                $('#txtPaytype').val('全部');
                
                $('#combPay').change(function() {
					var cmb = document.getElementById("combPay");
		                $('#txtPaytype').val(cmb.value);
				});
				
				if(q_getPara('sys.isAcccUs')!='1')
					$('#Xcoin').hide();
					
				if(q_getPara('sys.project').toUpperCase()!='BD'){
					var t_index=-1;
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data('info').reportData[i].report=='z_ummst14'){
							t_index=i;
							break;	
						}
					}
					if(t_index>-1){
						$('#q_report div div').eq(i).hide();
					}
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