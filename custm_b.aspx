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
			var q_name = 'custm', t_bbsTag = 'tbbs', t_content = " ", afilter = [], t_count = 0, as, brwCount2 = 15;
			var t_sqlname = 'custm_load'; t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbmKey = ['noa'], bbsKey = ['noa', 'noq'];
			q_tables = 's';
			
            $(document).ready(function() {
                if (location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }

                if (!q_paraChk()) {
                    return;
                }

                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').val(q_getHref()[1]);

                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbWtype", q_getPara('custm.wtype'));
                q_cmbParse("cmbQtype", q_getPara('custm.qtype'));
            }

            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#btnMinus_' + j).click(function() {
                        btnMinus($(this).attr('id'));
                    });
                } //j
            }

            function btnOk() {
                sum();

                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                // (key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['account'] && !as['bankno'] && !as['bank']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    /// noa  empty --> dont save
                    return;
                }

                t_key = q_getHref();
                as[bbmKey[0]] = t_key[1];
                q_getId2('', as);
                // write keys to as
                return true;
            }

            function btnModi() {
                var t_key = q_getHref();
                if (!t_key)
                    return;
                _btnModi();
            }

            function refresh() {
                _refresh();
            }

            function sum() {
            }

            function q_gtPost() {
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
            }

		</script>
	</head>
	<body>
		<div class='dbbm' style="width: 68%;">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr>
					<td><a id="lblStype" > </a></td>
					<td><input id="txtStype" maxlength='14' type="text" style='width:98%;'/></td>
					<td >
						<input id="chkStypefix" type="checkbox" style=' '/>
						<a id="vewChkstype"> </a>
					</td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblTaxtype"> </a></td>
					<td><select id="cmbTaxtype"  style='width:98%;'> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblQtype"> </a></td>
					<td><select id="cmbQtype" style='width:98%;'> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblWtype"> </a></td>
					<td><select id="cmbWtype"   style='width:98%;'> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblVccad" > </a></td>
					<td><input id="txtVccad" type="text" style='width:98%;'/></td>
					<td><a id="lblP23"> </a></td>
					<td><input id="txtP23"maxlength="10" type="text" style="width:98%;" /></td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblBcomp" > </a></td>
					<td><input id="txtBcomp" maxlength='40' type="text" style='width:98%;'/></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblBoat" > </a></td>
					<td><input id="txtBoat" maxlength='20' type="text" style='width:98%;'/></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
			</table>
		</div>
		<div id="dbbs" class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center"><a id='lblAccount'> </a></td>
					<td align="center"><a id='lblBankno'> </a></td>
					<td align="center"><a id='lblBank'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoa.*" type="hidden" />
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td style="width:10%;"><input class="txt" id="txtAccount.*" maxlength='23'type="text" style="width:98%;"/></td>
					<td style="width:10%;"><input class="txt" id="txtBankno.*" maxlength='16'type="text" style="width:98%;"/></td>
					<td style="width:10%;"><input class="txt" id="txtBank.*" maxlength='28'type="text" style="width:98%;"/></td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
