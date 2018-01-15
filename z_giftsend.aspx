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

            t_isinit = false;
            t_giftsendt = '';
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_giftsend');
            });
            function q_gfPost() {
                q_gt('giftsendt', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'giftsendt':
                        t_giftsendt = '';
                        var as = _q_appendData("giftsendt", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_giftsendt += (t_giftsendt.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
                        break;
                }
                if (!t_isinit && t_giftsendt.length > 0) {
                    t_isinit = true;

                    $('#q_report').q_report({
                        fileName : 'z_giftsend',
                        options : [{
                            type : '1',
                            name : 'date'
                        }, {
                            type : '2',
                            name : 'custno',
                            dbf : 'giftcust',
                            index : 'noa,namea',
                            src : 'giftcust_b.aspx'
                        }, {
                            type : '2',
                            name : 'cno',
                            dbf : 'acomp',
                            index : 'noa,acomp',
                            src : 'acomp_b.aspx'
                        }, {
                            type : '2',
                            name : 'salesno',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {
                            type : '2',
                            name : 'giftno',
                            dbf : 'gift',
                            index : 'noa,product',
                            src : 'gift_b.aspx'
                        }, {/*6*/
                            type : '5',
                            name : 'tsendmemo',
                            value : [q_getPara('report.all')].concat(t_giftsendt.split(','))
                        }, {/*6*/
                            type : '6',
                            name : 'xnoa'
                        }, {
	                        type : '2',
	                        name : 'xpart',
	                        dbf : 'part',
	                        index : 'noa,part',
	                        src : 'part_b.aspx'
	                    }]
                    });
                    q_popAssign();
                    q_langShow();

                    $('#txtDate1').mask(r_picd);
                	$('#txtDate1').datepicker();
                	$('#txtDate2').mask(r_picd);
                	$('#txtDate2').datepicker();
                	$('#txtDate1').val(q_date().substr(0, r_lenm) + '/01');
					$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 35).substr(0, r_lenm) + '/01', -1));

                    var t_noa = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
                    t_noa = t_noa.replace('noa=', '');
                    $('#txtXnoa').val(t_noa);

                    if (r_rank < "8" && q_getPara('sys.project').toUpperCase() == 'DC') {
	                    var t_where = "where=^^ noa='" + r_userno + "' ^^";
	                    q_gt('sss', t_where, 0, 0, 0, 'getpartno', r_accy, 1);
	                    if (as[0] != undefined) {
	                        if (as[0].partno >= '08') {
	                            $('#txtXpart1a').attr('disabled', 'disabled');
	                            $('#txtXpart2a').attr('disabled', 'disabled');
	                            $('#btnXpart1').hide();
	                            $('#btnXpart2').hide();
	                            $('#txtXpart1a').val(as[0].partno);
	                            $('#txtXpart1b').val(as[0].part);
	                            $('#txtXpart2a').val(as[0].partno);
	                            $('#txtXpart2b').val(as[0].part);
	                        }
	                    }
	                }
                }
            }

            function q_boxClose(s2) {
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