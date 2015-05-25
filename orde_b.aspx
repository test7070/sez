<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'orde', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = 'orde_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
                setTimeout('parent.$.fn.colorbox.resize({innerHeight : "520px"})', 300);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

			function mainPost(){
                q_cmbParse("cmbKind", q_getPara('sys.stktype'),"s");
                q_cmbParse("cmbStype", q_getPara('orde.stype'),"s");
			}

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtNoa_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                
                if(q_getPara('sys.project').toUpperCase()=='RB'){
                	$('.odate').hide();
                	$('.stype').hide();
                	$('.cno').hide();
                	$('.custno').hide();
                	$('.enda').hide();
                	$('.money').hide();
                	$('.memo').hide();
                }else{
                	$('.datea').hide();
                }
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
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
						<!--<input type="checkbox" id="checkAllCheckbox"/>-->
					</td>
					<td align="center" style="width:12%;"><a id='lblNoa'> </a></td>
					<td align="center" style="width:8%;" class="odate"><a id='lblOdate'> </a></td>
					<td align="center" style="width:8%;" class="datea"><a id='lblDatea'> </a></td>
					<td align="center" style="width:8%;" class="stype"><a id='lblStype'> </a></td>
					<!--<td align="center" style="width:8%;"><a id='lblKind'> </a></td>-->
					<td align="center" style="width:18%;" class="cno"><a id='lblAcomp'> </a></td>
					<td align="center" style="width:20%;" class="custno"><a id='lblCust'> </a></td>
					<td align="center" style="width:5%;" class="enda"><a id='lblEnda'> </a></td>
					<td align="center" style="width:10%;" class="money"><a id='lblTotal'> </a></td>
					<td align="center" class="memo"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input name="sel"  id="radSel.*" type="radio" />
						<!--<input id="chkSel.*" type="checkbox"/>-->
					</td>
					<td><input class="txt"  id="txtNoa.*" type="text" style="width:98%;" /></td>
					<td class="odate"><input class="txt"  id="txtOdate.*" type="text" style="width:98%;" /></td>
					<td class="datea"><input class="txt"  id="txtDatea.*" type="text" style="width:98%;" /></td>
					<td class="stype"><select id="cmbStype.*" class="txt c1"> </select></td>
					<!--<td><select id="cmbKind.*" class="txt c1"> </select></td>-->
					<td class="cno">
						<input class="txt"  id="txtCno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtAcomp.*" type="text" style="width:70%;" />
					</td>
					<td class="custno">
						<input class="txt"  id="txtCustno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtComp.*" type="text" style="width:70%;" />
					</td>
					<td class="enda" align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td class="money" ><input class="txt"  id="txtMoney.*" type="text" style="width:98%;text-align: right;" /></td>
					<td class="memo" ><input class="txt"  id="txtMemo.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


