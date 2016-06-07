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
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            aPop = new Array(['txtYacc1', '', 'acc', 'acc1,acc2', 'txtYacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_gqb');
                
                $('#q_report .report ').click(function(e) {
                	if($('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb4'
                	|| $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb11'
                	|| $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb13'
                	|| $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb14'){
                		$('#txtIndate1').val(q_date());
                		$('#txtIndate2').val(q_cdn(q_date(),90));
                		$('#txtYdate1').attr('disabled', 'disabled');
                		$('#txtIndate1').attr('disabled', 'disabled');
                	}else if($('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb5'
                	|| $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_gqb6'
                	){
                		$('#txtIndate1').val('');
                		$('#txtIndate2').val('');
                		$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                		$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                		$('#txtYdate1').removeAttr('disabled');
                		$('#txtIndate1').removeAttr('disabled');
                	}else{
                		$('#txtIndate1').val(q_date().substr(0,r_lenm)+'/01');
                		$('#txtIndate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',130).substr(0,r_lenm)+'/01',-1));
                		$('#txtYdate1').removeAttr('disabled');
                		$('#txtIndate1').removeAttr('disabled');
                		$('#txtDate1').val('');
                		$('#txtDate2').val('');
                	}
                });
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_gqb',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    }, {
                        type : '0',
                        name : 'ctypea',
                        value : q_getPara('gqb.typea')
                    }, {/*1*/
                        type : '5',
                        name : 'stype',
                        value : [q_getPara('report.all')].concat(q_getPara('gqb.typea').split(','))
                    }, {/*2*/
                        type : '5',
                        name : 'status',
                        value : [q_getPara('report.all')].concat(new Array('Y', 'N'))
                    }, {/*3*/
                        type : '1',
                        name : 'date'
                    }, {/*4*/
                        type : '1',
                        name : 'indate'
                    }, {/*5*/
                        type : '2',
                        name : 'bank',
                        dbf : 'bank',
                        index : 'noa,bank',
                        src : 'bank_b.aspx'
                    }, {/*6*/
                        type : '1',
                        name : 'gqbno'
                    }, {/*7*/
                        type : '5',
                        name : 'sort01',
                        value : q_getMsg('sort01').split('&')
                    }, {/*8*/
                        type : '1',
                        name : 'ydate'
                    }, {/*9 [16]*/
                        type : '6',
                        name : 'yacc1'
                    }, {/*10 [17][18]*/
                        type : '1',
                        name : 'xchkdate'
                    }, {/*11 [19][20]*/
                        type : '2',
                        name : 'xtcompno',
                        dbf : 'view_cust_tgg',
                        index : 'noa,comp',
                        src : 'view_cust_tgg_b.aspx'
                    }, {/*12 [21][22]*/
                        type : '2',
                        name : 'xcompno',
                        dbf : 'view_cust_tgg',
                        index : 'noa,comp',
                        src : 'view_cust_tgg_b.aspx'
                    }, {/*13 [23][24]*/
                        type : '1',
                        name : 'udate'
                    },{
						type : '0',
	                    name : 'r_tel',
	                    value : q_getPara('sys.tel')
					},{
	                    type : '0',
	                    name : 'r_addr',
	                    value : q_getPara('sys.addr')
					}, {/*14 [27][28]*/
                        type : '2',
                        name : 'xacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*[29]*/
                        type : '0', 
                        name : 'acomp',
                        value : q_getPara('sys.comp')
                    }, {/*5*/
                        type : '2',
                        name : 'xtbank',
                        dbf : 'bank',
                        index : 'noa,bank',
                        src : 'bank_b.aspx'
                    }, {/*[32]*/
                        type : '5',
                        name : 'xchk',
                        value : [q_getPara('report.all')].concat(new Array('Y', 'N'))
                    }, {/*[33]*/
                        type : '0', 
                        name : 'proj',
                        value : q_getPara('sys.project')
                    }, {/*[34][35]*/
                        type : '2',
                        name : 'xtacc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {/*[36]*/
                        type : '5',
                        name : 'xmerge',
                        value : new Array('整合', '區分')
                    }, {/*[37]*/
                        type : '8',
                        name : 'xnocollection',
                        value : new Array('1@未託收' )
                    }, {/*[38]*/
                        type : '5',
                        name : 'sort02',
                        value : 'tbank@託收銀行,indate@到期日,datea@收開日'.split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				$('#txtDate1').datepicker();
				$('#txtDate2').datepicker();
				$('#txtXchkdate1').datepicker();
				$('#txtXchkdate2').datepicker();
				$('#txtIndate1').datepicker();
				$('#txtIndate2').datepicker();
				$('#txtUdate1').datepicker();
				$('#txtUdate2').datepicker();
				$('#txtYdate1').datepicker();
				$('#txtYdate2').datepicker();
                
				$('#txtR_tel').val(q_getPara('sys.tel'));
	            $('#txtR_addr').val(q_getPara('sys.addr'));
                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                $('#txtXchkdate1').mask(r_picd);
                $('#txtXchkdate2').mask(r_picd);
                $('#txtIndate1').mask(r_picd);
                $('#txtIndate2').mask(r_picd);
                $('#txtUdate1').mask(r_picd);
                $('#txtUdate2').mask(r_picd);
                $('#txtYdate1').mask(r_picd);
                $('#txtYdate2').mask(r_picd);
                
                $('#txtYdate1').val(q_date());
				$('#txtIndate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtYdate2').val(q_cdn(q_date(),90));
                $('#txtIndate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',130).substr(0,r_lenm)+'/01',-1));

                $('#txtYacc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
                $('#Status option:eq(2)').attr('selected',true);
                $('#Stype select').val('1')     
                
                $('#Xnocollection').css('width','300px');
                $('#chkXnocollection').css('width','300px');
                $('#Xnocollection .label').css('width','0px');
                $('#chkXnocollection input').prop('checked',true);
                
                if(q_getPara('sys.project').toUpperCase()=='VU'){       
                	$('#Sort01 select').val('indate');
                }
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
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