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
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_tranorde');
            });
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], 
            ['txtAddrno', '', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx'],
            ['txtSssno', '', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'], 
            ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_tranorde',
                    options : [{/*[1]-年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*[2]*/
                        type : '0',
                        name : 'namea',
                        value : r_name
                    }, {/*[3][4] 1-1*/
                        type : '1',
                        name : 'strdate'
                    }, {/*[5][6] 1-2*/
                        type : '1',
                        name : 'dldate'
                    }, {/*[7][8] 1-4*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{/*[9][10] 1-8*/
                        type : '1',
                        name : 'odate'
                    }, {/*[11][12] 2-1*/
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {/*[13][14] 2-2*/
                        type : '2',
                        name : 'addrno',
                        dbf : 'addr',
                        index : 'noa,namea',
                        src : 'addr_b.aspx'
                    }, {/*[15] 2-4*/
                         	type : '8',
                            name : 'xdetail',
                            value : q_getMsg('tdetail').split('&')
                    },{/*[16] 2-8*/
                        type : '8',
                        name : 'xctype',
                        value : (('').concat(new Array("貨櫃","平板","散裝"))).split(',')
                    }, {/*[17] 3-1*/
                        type : '5',
                        name : 'xsort1',//[11]
                        value : q_getMsg('tsort1').split('&')
                    },{/*[18] 3-2*/
                    	type : '6',
                    	name : 'xnoa'
                    }]
                });
                q_popAssign();

                $('#txtStrdate1').mask('999/99/99');
                $('#txtStrdate2').mask('999/99/99');
				$('#txtDldate1').mask('999/99/99');
                $('#txtDldate2').mask('999/99/99');
				$('#txtOdate1').mask('999/99/99');
                $('#txtOdate2').mask('999/99/99');
                
                var t_noa=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa').val(t_noa);
                
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtStrdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtStrdate2').val(t_year + '/' + t_month + '/' + t_day);
            }

            function q_boxClose(s2) {
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

