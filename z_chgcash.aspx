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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            function z_chgcash() {
            }


            z_chgcash.prototype = {
                isInit : false,
                data : {
                    carteam : null,
                    part : null,
                    chgpart : null
                },
                isLoad : function() {
                    var isLoad = true;
                    for (var x in this.data) {
                        isLoad = isLoad && (this.data[x] != null);
                    }
                    return isLoad;
                }
            };
            t_data = new z_chgcash();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_chgcash');
            });
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                q_gt('chgpart', '', 0, 0, 0);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carteam':
                        t_data.data['carteam'] = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        break;
                    case 'part':
                        t_data.data['part'] = '';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;
                    case 'chgpart':
                        t_data.data['chgpart'] = '';
                        var as = _q_appendData("chgpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['chgpart'] += (t_data.data['chgpart'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;
                }

                if (t_data.isLoad() && !t_data.isInit) {
                    t_data.isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_chgcash',
                        options : [{
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        },{
                            type : '0',
                            name : 'r_name',
                            value : r_name
                        }, {/*1*/
                            type : '6',
                            name : 'xnoa'
                        }, {/*2*/
                            type : '1',
                            name : 'date'
                        }, {/*3*/
                            type : '1',
                            name : 'mon'
                        }, {/*4*/
                            type : '2',
                            name : 'acc',
                            dbf : 'acc',
                            index : 'acc1,acc2',
                            src : 'acc_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_1'
                        }, {/*5*/
                            type : '2',
                            name : 'sss',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {/*6*/
                            type : '2',
                            name : 'driver',
                            dbf : 'driver',
                            index : 'noa,namea',
                            src : 'driver_b.aspx'
                        }, {/*7*/
                            type : '2',
                            name : 'cust',
                            dbf : 'cust',
                            index : 'noa,comp',
                            src : 'cust_b.aspx'
                        }, {/*8*/
                            type : '6',
                            name : 'xcarno'
                        }, {/*9*/
                            type : '6',
                            name : 'xpo'
                        }, {/*10*/
                            type : '8',
                            name : 'xcarteam',
                            value : t_data.data['carteam'].split(',')
                        }, {/*11*/
                            type : '8',
                            name : 'xpart',
                            value : t_data.data['part'].split(',')
                        }, {/*12*/
                            type : '8',
                            name : 'xchgpart',
                            value : t_data.data['chgpart'].split(',')
                        }, {/*13*/
                            type : '8',
                            name : 'xdc',
                            value : q_getPara('chgcash.typea').split(',')
                        }, {/*28*/
                            type : '5',
                            name : 'xtitle',//[11]
                            value : q_getMsg('ttitle').split('&')
                        }]
                    });
                    q_popAssign();
                    q_langShow();
                    
                    var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
	                t_noa  =  t_noa.replace('noa=','');
	                $('#txtXnoa').val(t_noa);

                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
					
					$('#txtMon1').mask('999/99');
                    $('#txtMon2').mask('999/99');
                    
                    /*$('#chkXcarteam').children('input').attr('checked', 'checked');
                    $('#chkXpart').children('input').attr('checked', 'checked');
                    $('#chkXchgpart').children('input').attr('checked', 'checked');
                    $('#chkXdc').children('input').attr('checked', 'checked');*/

                    var t_date, t_year, t_month, t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtMon1').val(t_year + '/' + t_month);
                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtMon2').val(t_year + '/' + t_month);
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