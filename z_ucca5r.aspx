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
            aPop = new Array();
            
            var t_make='',t_pno='',t_init=true;
            $(document).ready(function() {
                q_getId();
                q_gt('make', '', 0, 0, 0);
                //q_gt('ucc', '', 0, 0, 0);
                
            });
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ucca5r',
                    options : [{/* [1]*/
                        type : '0', //數量的小數位數
                        name : 'mount_precision',
                        value : q_getPara('rc2.mountPrecision')
                    },{/* [2]*/
                        type : '0', //重量的小數位數
                        name : 'weight_precision',
                        value : q_getPara('rc2.weightPrecision')
                    },{/* [3]*/
                        type : '0', //價格的小數位數
                        name : 'price_precision',
                        value : q_getPara('rc2.pricePrecision')
                    },{
                        type : '0',//[4]
                        name : 'xstype',
                        value : q_getPara('vccst.stype')
                    },{
                        type : '0',//[5]
                        name : 'stktype',
                        value : q_getPara('sys.stktype')
                    },{
                        type : '5',//[6] 產品用途
                        name : 'xmake',
                        value : t_make.split(',')
                    },{
                        type : '5',//[7] 類別
                        name : 'xkind',
                        value : ('#non@全部,'+q_getPara('sys.stktype')).split(',')
                    },{
                        type : '5',//[8]  材質
                        name : 'xpno',
                        value : ('全部,CR,HR,PO,其他').split(',') //祥興版本除了CR、HR、PO,其餘皆為其他
                    },{
                        type : '1',//[9]][10] //組別
                        name : 'xgroup'
                    }, {
						type : '2', //[11][12] 業務員
						name : 'xsss',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[13][14] 客戶
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
                        type : '1',//[15][16] //厚
                        name : 'xdime'
                    },{
                        type : '1',//[17][18] //短
                        name : 'xradius'
                    },{
                        type : '1',//[19][20] //寬                                           
                        name : 'xwidth'
                    },{
                        type : '1',//[21][22] //長
                        name : 'xlengthb'
                    },{
                        type : '1',//[23][24] //銷售日期
                        name : 'xdate'
                    },{
                        type : '6',//[25] //年利率
                        name : 'xrate'
                    },{
                        type : '6',//[26] //訂單編號
                        name : 'xordeno'
                    },{
                        type : '6',//[27] //訂序
                        name : 'xno2'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate2').mask('999/99/99');
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                
                $('#Xkind .cmb').change(function() {
                	var t_kind=$('#Xkind .cmb').val().substr(0,1);
                	if(t_kind=='B'){
                		$('#lblXradius').text('短徑');
                		$('#lblXwidth').text('長徑');
                	}else{
                		$('#lblXradius').text(q_getMsg('lblXradius'));
                		$('#lblXwidth').text(q_getMsg('lblXwidth'));
                	}
				});
				
				$('#txtXdime1').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXdime2').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXradius1').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXradius2').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXwidth1').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXwidth2').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXlengthb1').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXlengthb2').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				$('#txtXrate').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'make':
                	 	t_make = '#non@全部';
                        var as = _q_appendData("make", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_make += (t_make.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
					break;
					case 'ucc':
					 	t_pno = '#non@全部';
                        var as = _q_appendData("ucc", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_pno += (t_pno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].product;
                        }
					break;
                }
                
                if(t_make.length>0  && t_init){//&& t_pno.length>0
                	t_init=false;
                	q_gf('', 'z_ucca5r');
                }
	         }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>