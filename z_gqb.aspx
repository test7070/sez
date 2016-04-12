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
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
		<script type="text/javascript">
            aPop = new Array(['txtYacc1', '', 'acc', 'acc1,acc2', 'txtYacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_gqb');
				
				$.datepicker.regional['zh-TW']={
				   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
				   dayNamesMin:["日","一","二","三","四","五","六"],
				   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   prevText:"上月",
				   nextText:"次月",
				   weekHeader:"週"
				};
				//將預設語系設定為中文
				$.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
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
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtDate2').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtXchkdate1').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtXchkdate2').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtIndate1').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtIndate2').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtUdate1').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtUdate2').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtYdate1').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtYdate2').datepicker({dateFormat: 'yy/mm/dd'});
                
				if(r_len==3){
					$('#txtDate1').change(function() {changechdate($(this));});
					$('#txtDate2').change(function() {changechdate($(this));});
					$('#txtXchkdate1').change(function() {changechdate($(this));});
					$('#txtXchkdate2').change(function() {changechdate($(this));});
					$('#txtIndate1').change(function() {changechdate($(this));});
					$('#txtIndate2').change(function() {changechdate($(this));});
					$('#txtUdate1').change(function() {changechdate($(this));});
					$('#txtUdate2').change(function() {changechdate($(this));});
					$('#txtYdate1').change(function() {changechdate($(this));});
					$('#txtYdate2').change(function() {changechdate($(this));});
				}
                
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
				$('#txtIndate1').val(q_date());
                $('#txtYdate2').val(q_cdn(q_date(),90));
                $('#txtIndate2').val(q_cdn(q_date(),90));

                $('#txtYacc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
                $('#Status option:eq(2)').attr('selected',true);
                $('#Stype select').val('1')     
            }
            
            function changechdate(a) {
            	if(a.val().length==10){
            		var t_year=('000'+(dec(a.val().substring(0,4))-1911).toString()).slice(-3);
					var t_date=a.val().substring(4,10)
					a.val(t_year+t_date);
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