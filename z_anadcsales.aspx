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
            , ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anadcsales');
            });
            function q_gfPost() {
                q_gt('carkind', '', 0, 0, 0, "");
             
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
	                        t_carkind += (t_carkind.length > 0 ? ',' : '') +  'all@全部';
                        }
                        break;
                    default:
                    	break;
                }

                if (t_carkind!=null  && !isInit) {
                    isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_anadcsales',
                        options : [{/*[1]-會計年度*/
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        }, {/*1-[2],[3]-交運日期*/
                            type : '1',
                            name : 'trandate'
                        }, {/*2-[4]-車牌*/
                            type : '6',
                            name : 'xcarno'
                        }, {/*3-[5]-車種*//*02*/
                         	type : '8',
                            name : 'xcarkind',
                            value : t_carkind.split(',')
                        }, {/*4-[6]-耗油比(%)*/
                            type : '6',
                            name : 'xcheckrate'
                        }, {/*5-[7]-排序依耗油比、交運日期、收入、年份、司機、淨利*//*03*/
                            type : '5',
                            name : 'xsort01',
                            value : q_getMsg('tsort01').split('&')
                        }, {/*6-[8]-其他設定(出車明細、加油明細)*/
                         	type : '8',
                            name : 'xfilter01',
                            value : q_getMsg('tfilter01').split('&')
                        }, {/*7-[9]-其他設定2(指定車牌)*/
                         	type : '8',
                            name : 'xoption01',
                            value : q_getMsg('toption01').split('&')
                        }, {/*8-[10]-排序依車種、年份、耗油比、淨利*/
                            type : '5',
                            name : 'xsort02',
                            value : q_getMsg('tsort02').split('&')
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