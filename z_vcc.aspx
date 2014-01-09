<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
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
            var gfrun = false;
            var uccgaItem = '';
            var sss_state = false;
            var issale = '0';
            var job = '';
            var sgroup = '';

            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }
            
            $(document).ready(function() {
                q_getId();
                if (uccgaItem.length == 0) {
                    q_gt('uccga', '', 0, 0, 0, "");
                }
                if (!sss_state) {
                    q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 0, 0, "");
                }
                
                $('#q_report').click(function(e) {
					if(q_getPara('sys.comp').indexOf('永勝') > -1){//沒有發票系統
	                	$('#Xshowinvono').hide();
	                }
				});
            });
            
            function q_gfPost() {
            	var ucctype=q_getPara('ucc.typea') + ',' + q_getPara('uca.typea');
	            if(q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
	            {
	            	ucctype= q_getPara('ucc.typea_it');
	            }
	            var vccstype=q_getPara('vcc.stype');
	            if(q_getPara('sys.comp').indexOf('永勝') > -1){
	            	vccstype=q_getPara('vcc.stype_uu');
	            }
            	
                $('#q_report').q_report({
                    fileName : 'z_vcc',
                    options : [{
                        type : '0', //[1] 
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '0', //[2] //判斷vcc是內含或應稅
                        name : 'vcctax',
                        value : q_getPara('sys.d4taxtype')
                    }, {
                        type : '0', //[3] //判斷顯示小數點
                        name : 'acomp',
                        value : q_getPara('sys.comp')
                    }, {
                        type : '1', //[4][5]//1
                        name : 'date'
                    }, {
                        type : '1', //[6][7]//2
                        name : 'mon'
                    }, {
                        type : '2', //[8][9]//4
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[10][11]//8
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[12][13]//10
                        name : 'product',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{
                        type : '2', //[14][15]//原廠//20
                        name : 'tggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    },{
                        type : '5',
                        name : 'xtype', //[16]//40
                        value : [q_getPara('report.all')].concat(ucctype.split(','))
                    },{
                        type : '5', //[17]//80
                        name : 'xgroupano',
                        value : uccgaItem.split(',')
                    }, {
                        type : '5',
                        name : 'xstype', //[18]//100
                        value : [q_getPara('report.all')].concat(vccstype.split(','))
                    }, {
                        type : '6', //[19]//200
                        name : 'salesgroup'
                    },{
                        type : '8', //[20]//顯示發票號碼//400
                        name : 'xshowinvono',
                        value : "1@顯示發票資料".split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();

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
                $('#txtMon1').val(r_accy + '/01').mask('999/99');
                $('#txtMon2').val(r_accy + '/12').mask('999/99');
                $('#txtXbmon1').val(r_accy + '/01').mask('999/99');
                $('#txtXbmon2').val(r_accy + '/12').mask('999/99');
                $('#txtXemon1').val(r_accy + '/01').mask('999/99');
                $('#txtXemon2').val(r_accy + '/12').mask('999/99');
                $('#Xmemo').removeClass('a2').addClass('a1');
                $('#txtXmemo').css('width', '85%');
                $('#Xgroupano select').css('width', '150px');
                $('.q_report .report').css('width', '420px');
                $('.q_report .report div').css('width', '200px');

                if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) {
                    if (issale == 'true' && job.indexOf('經理') < 0 && r_rank <= '5') {//一般業務只能看到自己的業績
                        $('#txtSales1a').val(r_userno);
                        $('#txtSales1b').val(r_name);
                        $('#txtSales2a').val(r_userno);
                        $('#txtSales2b').val(r_name);
                        $('#btnSales1').hide();
                        $('#btnSales2').hide();
                        $('#txtSales1a').attr('disabled', 'disabled');
                        $('#txtSales2a').attr('disabled', 'disabled');
                        $('#txtSalesgroup').val(sgroup)
                        $('#txtSalesgroup').attr('disabled', 'disabled');
                    } else if (issale == 'true' && job.indexOf('經理') > -1 && r_rank <= '5') {
                        $('#txtSales1a').val(r_userno);
                        $('#txtSales1b').val(r_name);
                        $('#txtSales2a').val(r_userno);
                        $('#txtSales2b').val(r_name);
                        $('#txtSalesgroup').val(sgroup)
                        $('#txtSalesgroup').attr('disabled', 'disabled');
                    }
                }
                
                $('#Xshowinvono').css('width', '300px').css('height', '30px');
                $('#Xshowinvono .label').css('width','0px');
                $('#chkXshowinvono').css('width', '220px').css('margin-top', '5px');
                $('#chkXshowinvono span').css('width','180px')
                
                if(q_getPara('sys.comp').indexOf('永勝') > -1){//沒有發票系統
	                $('#Xshowinvono').hide();
				}
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'sss':
                        var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined) {
                            issale = as[0].issales;
                            job = as[0].job;
                            sgroup = as[0].salesgroup;
                        }
                        sss_state = true;
                        break;
                    case 'uccga':
                        var as = _q_appendData("uccga", "", true);
                        uccgaItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                        }
                        break;
                }
                if (uccgaItem.length > 0 && sss_state && !gfrun) {
                    gfrun = true;
                    q_gf('', 'z_vcc');
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