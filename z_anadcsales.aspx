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
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
            , ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx'],
            ['txtYcarno', 'lblYcarno', 'car2', 'a.noa,driverno,driver', 'txtYcarno', 'car2_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anadcsales');
            });
            function z_tran() {
            }


            z_tran.prototype = {
                isInit : false,
                data : {
                    carteam : null,
                    calctypes : null
                },
                isLoad : function() {
                    var isLoad = true;
                    for (var x in this.data) {
                        isLoad = isLoad && (this.data[x] != null);
                    }
                    return isLoad;
                }
            };
            t_data = new z_tran();
            function q_gfPost() {
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
             
            }
			var sssno='';
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carkind':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
	                        for ( i = 0; i < as.length; i++) {
	                            t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
	                        }
                        }
                        break;
                    case 'carteam':
                        t_data.data['carteam'] = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        break;
                    case 'calctypes':
                        t_data.data['calctypes'] = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['calctypes'] += (t_data.data['calctypes'].length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        break;
                }

                if (t_carkind!=null  && !isInit && t_data.isLoad() && !t_data.isInit) {
                    isInit = true;
                    t_data.isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_anadcsales',
                        options : [{/*[1]-會計年度*/
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        }, {/*1-[2],[3]-交運日期*///1-1
                            type : '1',
                            name : 'trandate'
                        }, {/*2-[4]-車牌*///1-2
                            type : '6',
                            name : 'xcarno'
                        }, {/*3-[5]-車種*///1-4
                         	type : '8',
                            name : 'xcarkind',
                            value : t_carkind.split(',')
                        }, {/*4-[6]-耗油比(%)*///1-8
                            type : '6',
                            name : 'xcheckrate'
                        }, {/*5-[7]-排序依耗油比、交運日期、收入、年份、司機、淨利*///2-1
                            type : '5',
                            name : 'xsort01',
                            value : q_getMsg('tsort01').split('&')
                        }, {/*6-[8]-其他設定(出車明細、加油明細)*///2-2
                         	type : '8',
                            name : 'xfilter01',
                            value : q_getMsg('tfilter01').split('&')
                        }, {/*7-[9]-其他設定2(指定車牌)*///2-4
                         	type : '8',
                            name : 'xoption01',
                            value : q_getMsg('toption01').split('&')
                        }, {/*8-[10]-排序依車種、年份、耗油比、淨利*///2-8
                            type : '5',
                            name : 'xsort02',
                            value : q_getMsg('tsort02').split('&')
                        }, {/*1-[11][12]登錄日期*///*3-1
                            type : '1',
                            name : 'ydate'
                        }, {/*2-[13][14]交運日期*///*3-2
                            type : '1',
                            name : 'ytrandate'
                        }, {/*3-[15][16]客戶*///*3-4
                            type : '2',
                            name : 'ycust',
                            dbf : 'cust',
                            index : 'noa,comp',
                            src : 'cust_b.aspx'
                        }, {/*4-[17][18]司機*///*3-8
                            type : '2',
                            name : 'ydriver',
                            dbf : 'driver',
                            index : 'noa,namea',
                            src : 'driver_b.aspx'
                        }, {/*5-[19]車牌*///*4-1
                            type : '6',
                            name : 'ycarno'
                        }, {/*6-[20]PO*///*4-2
                            type : '6',
                            name : 'ypo'
                        }, {/*7-[21][22]起迄地點*///*4-4
                            type : '2',
                            name : 'yaddr',
                            dbf : 'addr',
                            index : 'noa,addr',
                            src : 'addr_b.aspx'
                        }, {/*10-[23]其他選項-(含折扣)*///4-8
                            type : '8',
                            name : 'yoption2',
                            value : q_getMsg('toption2').split('&')
                        }, {/*12-[24]車隊*///5-1
                            type : '8',
                            name : 'ycarteam',
                            value : t_data.data['carteam'].split(',')
                        }, {/*14-[25]計算類別*///5-2
                            type : '8',
                            name : 'ycalctypes',
                            value : t_data.data['calctypes'].split(',')
                        }, {/*23-[26]排序(電腦編號、登錄日期、交運日期、車牌、客戶編號、司機編號、起迄地點)*///*5-4
                            type : '5',
                            name : 'ysort03',
                            value : q_getMsg('tsort03').split('&')
                        }]
                    });
                    q_popAssign();
                    q_langShow();

                    $('#txtTrandate1').mask('999/99/99');
                    $('#txtTrandate1').datepicker();
                    $('#txtTrandate2').mask('999/99/99');
                    $('#txtTrandate2').datepicker();
                    $('#txtXcheckrate').val(q_getMsg('trate1'));
                    $('#chkXcarkind').children('input').attr('checked', 'checked');
                    $('#txtYdate1').mask('999/99/99');
                    $('#txtYdate1').datepicker();
                    $('#txtYdate2').mask('999/99/99');
                    $('#txtYdate2').datepicker();
                    $('#txtYtrandate1').mask('999/99/99');
                    $('#txtYtrandate1').datepicker();
                    $('#txtYtrandate2').mask('999/99/99');
                    $('#txtYtrandate2').datepicker();

                    $('#chkYoption2').children('input').attr('checked', 'checked');
                    $('#chkYcarteam').children('input').attr('checked', 'checked');
                    $('#chkYcalctypes').children('input').attr('checked', 'checked');

                }
            }
            function q_boxClose(t_name) {
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