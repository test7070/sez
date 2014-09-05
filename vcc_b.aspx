<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'view_vcc', t_bbsTag = 'tbbs', t_content = " field=noa,typea,stype,datea,mon,cno,acomp,custno,comp,paytype,trantype,tel,fax,post,addr,post2,addr2,cardealno,cardeal,carno,salesno,sales,money,tax,total,memo,invono,invo", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'view_vcc';
            t_postname = q_name;
            brwCount = -1;
            //brwCount2 = 10;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            var bbsNum = [['txtTotal', 15, 0, 1]];
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
                
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#textTypea_'+j).val($('#txtTypea_'+j).val()=='1'?'出':'退');
                	$('#textTypea_'+j).attr('disabled', 'disabled');
		            $('#textTypea_'+j).css('background', t_background2);
                }

                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });

                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center"><a id='lblDatea'> </a></td>
					<td align="center"><a id='lblNoa'> </a></td>
					<td align="center"><a id='lblTypea'> </a></td>
					<td align="center"><a id='lblCustno'> </a></td>
					<td align="center"><a id='lblComp'> </a></td>
					<td align="center"><a id='lblTotal'> </a></td>
					<td align="center"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:8%;"><input class="txt"  id="txtDatea.*" type="text" style="width:98%;" /></td>
					<td style="width:12%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"/></td>
					<td style="width:5%;">
						<input class="txt" id="textTypea.*" type="text" style="width:98%;"/>
						<input class="txt" id="txtTypea.*" type="hidden"/>
					</td>
					<td style="width:10%;"><input class="txt" id="txtCustno.*" type="text" style="width:98%;"/></td>
					<td style="width:18%;"><input class="txt" id="txtComp.*" type="text" style="width:98%;"/></td>
					<td style="width:10%;"><input class="txt" id="txtTotal.*" type="text" style="width:94%; text-align:right;"/></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
						<input id="recno.*" type="hidden" />
						<input id="txtStype.*" type="hidden" />
						<input id="txtMon.*" type="hidden" />
						<input id="txtCno.*" type="hidden" />
						<input id="txtAcomp.*" type="hidden" />
						<input id="txtPaytype.*" type="hidden" />
						<input id="txtTrantype.*" type="hidden" />
						<input id="txtTel.*" type="hidden" />
						<input id="txtFax.*" type="hidden" />
						<input id="txtPost.*" type="hidden" />
						<input id="txtAddr.*" type="hidden" />
						<input id="txtPost2.*" type="hidden" />
						<input id="txtAddr2.*" type="hidden" />
						<input id="txtCardealno.*" type="hidden" />
						<input id="txtCardeal.*" type="hidden" />
						<input id="txtCarno.*" type="hidden" />
						<input id="txtSalesno.*" type="hidden" />
						<input id="txtSales.*" type="hidden" />
						<input id="txtMoney.*" type="hidden" />
						<input id="txtTax.*" type="hidden" />
						<input id="txtInvono.*" type="hidden" />
						<input id="txtInvo.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
