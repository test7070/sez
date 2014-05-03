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
			//********************************************
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var isInit = false;
            var t_carkind = null;
            var t_carteam = null;
            var t_calctypes = null;
            var sssno='';
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
            , ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('carteam', '', 0, 0, 0, "init1");
                
            });
            function q_gfPost() {
                initFinish();
            }
            function q_gtPost(t_name) {
                switch (t_name) {
            		case 'init1':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "init2");
                        break;
                    case 'init2':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        q_gt('carkind', '', 0, 0, 0, "init3");
                        break;
                    case 'init3':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
	                        for ( i = 0; i < as.length; i++) {
	                            t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
	                        }
	                        t_carkind += (t_carkind.length > 0 ? ',' : '') +  'all@外車(客戶分析表用)';
                        }
						q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "init4", r_accy);
                        break;
                    case 'init4':
            			var as = _q_appendData("sss", "", true);
            			for (var i = 0; i < as.length; i++) {
            				sssno+=as[i].noa+'.';
            			}
            			sssno=sssno.substr(0,sssno.length-1);
            			
            			q_gf('', 'z_trana');
            			break;
                    default:
                    	break;
                }
            }
            function q_boxClose(t_name) {
            }
            function initFinish(){
            	$('#q_report').q_report({
                    fileName : 'z_trana',
                    options : [{/*[1]-會計年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*1-[2],[3]-登錄日期*/
                        type : '1',
                        name : 'date'
                    }, {/*2-[4],[5]-交運日期*/
                        type : '1',
                        name : 'trandate'
                    }, {/*3-[6],[7]-客戶*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4-[8],[9]-起迄地點*//*01*/
                        type : '2',
                        name : 'addr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*5-[10],[11]-司機*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*6-[12]-車牌*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*7-[13]-PO*/
                        type : '6',
                        name : 'xpo'
                    }, {/*8-[14]-車種*//*02*/
                     	type : '8',
                        name : 'xcarkind',
                        value : t_carkind.split(',')
                    }, {/*9-[15]-車隊*/
                        type : '8',
                        name : 'xcarteam',
                        value : t_carteam.split(',')
                    }, {/*10-[16]-計算類別*/
                        type : '8',
                        name : 'xcalctypes',
                        value : t_calctypes.split(',')
                    }, {/*11-[17]-耗油比(%)*/
                        type : '6',
                        name : 'xcheckrate'
                    }, {/*12-[18]-排序依耗油比、交運日期、收入、年份、司機、淨利*//*03*/
                        type : '5',
                        name : 'xsort01',
                        value : q_getMsg('tsort01').split('&')
                    }, {/*13-[19]-其他設定(出車明細、加油明細)*/
                     	type : '8',
                        name : 'xfilter01',
                        value : q_getMsg('tfilter01').split('&')
                    }, {/*14-[20]-其他設定(指定車牌)*/
                     	type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }, {/*15-[21]-排序依車種、年份、耗油比、淨利*/
                        type : '5',
                        name : 'xsort02',
                        value : q_getMsg('tsort02').split('&')
                    }, {/*16-[22]-其他設定(出車明細)*//*04*/
                     	type : '8',
                        name : 'xfilter04',
                        value : q_getMsg('tfilter04').split('&')
                    }, {/*17-[23]-排序依客戶、收入、淨利*/
                        type : '5',
                        name : 'xsort04',
                        value : q_getMsg('tsort04').split('&')
                    }, {/*18-[24][25]-車主*/
                        type : '2',
                        name : 'carowner',
                        dbf : 'carowner',
                        index : 'noa,namea',
                        src : 'carowner_b.aspx'
                    }, {/*19-[26]-月份*/
                        type : '6',
                        name : 'xmon'
                    }, {/*20-[27]-管理帳號*//*05*/
                        type : '8', //select
                        name : 'sssno',
                        value : (sssno).split('.')
                    }, {/*21-[28][29]-金額範圍*/
                        type : '1',
                        name : 'xmoney'
                    }, {/*22-[30]-排序依車主、金額*/
                        type : '5', //select
                        name : 'zorder',
                        value : ('車主,金額').split(',')
                	}, {/*23-[31][32]-帳款月份*/
						type : '1',
						name : 'xxmon'
					}, {/*24[33]-請款單號*//*06*/
						type : '6',
						name : 'xtrdno'
					}, {/*25[34]-排序方式*/
						type : '5',
						name : 'xsort05',
						value : q_getMsg('tsort05').split('&')
					}, {/*26[35][36]-收款日期*/
						type : '1',
						name : 'ummdate'
					}, {/*27-[37]-請款單號*/
						type : '6',
						name : 'xvccno'
					}, {/*28-[38]-排序方式*//*07*/
						type : '5',
						name : 'xsort06',
						value : q_getMsg('tsort06').split('&')
					}, {/*29-[39]-排序方式*//*08*/
						type : '8',
						name : 'xoption08',
						value : q_getMsg('toption08').split('&')
					}]
                });
                

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate2').mask('999/99/99');
                /*$('#txtTrandate1').datepicker();
                $('#txtTrandate2').datepicker();*/
                $('#txtMon1').mask('999/99');
				$('#txtMon2').mask('999/99');
				$('#txtUmmdate1').mask('999/99/99');
				$('#txtUmmdate2').mask('999/99/99');
				$('#txtUmmdate1').datepicker();
				$('#txtUmmdate2').datepicker();
				$('#txtXmoney1').val(-99999999);
                $('#txtXmoney2').val(99999999);
                
                $('#txtBxxmon').mask('999/99');
                $('#txtExxmon').mask('999/99');
				
				$('#txtXcheckrate').val(q_getMsg('trate1'));
                $('#chkXcarkind').children('input').attr('checked', 'checked');
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcalctypes').children('input').attr('checked', 'checked');
                $('#chkSssno').children('input').attr('checked', 'checked');
    			
    			var t_date,t_year,t_month,t_day;
    			t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtMon1').val(t_year + '/' + t_month);

    			t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                $('#txtMon2').val(t_year + '/' + t_month);
                $('#txtXmon').val(t_year+'/'+t_month);
                
                t_date = new Date();
                t_day = t_date.getDay();
                t_date1 = new Date(t_date.getTime()- 60*60*1000*(t_day+7)*24);
                t_date2 = new Date(t_date.getTime()- 60*60*1000*(t_day+1)*24);
                $('#txtTrandate1').val((t_date1.getFullYear()-1911)+'/'+((t_date1.getMonth()+1)<10?'0':'')+(t_date1.getMonth()+1)+'/'+(t_date1.getDate()<10?'0':'')+t_date1.getDate());
                $('#txtTrandate2').val((t_date2.getFullYear()-1911)+'/'+((t_date2.getMonth()+1)<10?'0':'')+(t_date2.getMonth()+1)+'/'+(t_date2.getDate()<10?'0':'')+t_date2.getDate());
                //預設 車隊分析表
                $('#q_report').find('span.radio').eq(4).parent().click();
                $('#q_report').data('info').execute($('#q_report'));
                q_popAssign();
                q_langShow();
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