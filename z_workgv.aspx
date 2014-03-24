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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }

            var txtreport = '';

            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_workgv');

                $('#q_report').click(function(e) {
                    var t_index = $('#q_report').data('info').radioIndex;
                    txtreport = $('#q_report').data('info').reportData[t_index].report;

                    if (txtreport == 'z_workgv1' || txtreport == 'z_workgv2') {
                        $('#dataSearch').hide();
                        $('#svg_search').show();
                        $('#chart').show();
                    } else {
                        $('#dataSearch').show();
                        $('#svg_search').hide();
                        $('#chart').hide();
                    }
                });

                $("#btnNext").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').next($('#' + $(this).data('chart')));
                });

                $("#btnPrevious").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').previous($('#' + $(this).data('chart')));
                });
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workgv',
                    options : [{
                        type : '6',
                        name : 'xmon'
                    }, {
                        type : '2',
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }]
                });
                q_popAssign();
                $('#txtXmon').mask('999/99');
                $('#txtXmon').val(q_date().substr(0, 6));

                //SVG
                $("#btnRun").click(function(e) {
                    var t_xmon = emp($('#txtXmon').val()) ? '#non' : $('#txtXmon').val();
                    var t_bpno = emp($('#txtXproduct1a').val()) ? '#non' : $('#txtXproduct1a').val();
                    var t_epno = emp($('#txtXproduct2a').val()) ? '#non' : $('#txtXproduct2a').val();
                    var t_index = $('#q_report').data('info').radioIndex;
                    var t_report = $('#q_report').data('info').reportData[t_index].report;

                    $(".z_cugp.chart").html('').height(0);
                    $("#txtCurPage").val(0);
                    $("#txtTotPage").val(0);

                    switch(txtreport) {
                        case 'z_workgv1':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.z_workgv1', 'z_workgv.txt,' + txtreport + ',' + t_xmon + ';' + t_bpno + ';' + t_epno);
                            break;
                        case 'z_workgv2':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.z_workgv2', 'z_workgv.txt,' + txtreport + ',' + t_xmon + ';' + t_bpno + ';' + t_epno);
                            break;
                        default:
                            alert('錯誤：未定義報表');
                    }
                });
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.z_workgv1':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined) {
                            $('#Loading').hide();
                            Unlock();
                        } else {
                            var n = -1;
                            t_data = new Array();
                            for (var i in as) {
                                if (as[i].productno != undefined) {
                                    n = -1;
                                    m = -1;
                                    for (var j = 0; j < t_data.length; j++)
                                        if (t_data[j].productno == as[i].productno) {
                                            n = j;
                                            for (var k = 0; k < t_data[j].mon.length; k++)
                                                if (t_data[j].mon[k].mon == as[i].mon)
                                                    m = k;
                                        }

                                    if (n == -1) {
                                        t_data.push({
                                            prodcutno : as[i].prodcutno,
                                            prodcut : as[i].prodcut,
                                            mon : new Array({
                                                mon : as[i].mon,
                                                detail : new Array({
                                                    mount : as[i].mount,
                                                    orde : as[i].orde,
                                                    stk : as[i].stk,
                                                    sch : as[i].sch,
                                                    safem : as[i].safem
                                                })
                                            })
                                        });
                                       
                                    } else if (m == -1) {
                                        t_data[n].mon.push({
                                            mon : as[i].mon,
                                            detail : new Array({
                                                mount : as[i].mount,
												orde : as[i].orde,
												stk : as[i].stk,
												sch : as[i].sch,
												safem : as[i].safem
                                            })
                                        });
                                        
                                    } else {
                                        t_data[n].mon[m].detail.push({
                                            mount : as[i].mount,
											orde : as[i].orde,
											stk : as[i].stk,
											sch : as[i].sch,
											safem : as[i].safem
                                        });
                                        
                                    }
                                }
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart01').barChart01({
                                data : t_data
                            });

                            $('#txtTotPage').val(t_data.length);
                            $('#txtCurPage').data('chart', 'chart01').val(1).change(function(e) {
                                $(this).val(parseInt($(this).val()));
                                $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                            });
                            $("#btnNext").data('chart', 'chart01');
                            $("#btnPrevious").data('chart', 'chart01');
                            $(".control").show();
                        }
                        break;
                    default:
                        alert(t_func + ':q_funcPost undefined');
                        break;
                }
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
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
			<div id="svg_search" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='Loading' class="z_cugp chart"></div>
				<div id='chart01' class="z_cugp chart"></div>
			</div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

