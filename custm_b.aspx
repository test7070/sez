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
			
			aPop = new Array(
				['txtAgentno', 'lblAgent', 'agent', 'noa,agent', 'txtAgentno,txtAgent', 'agent_b.aspx'],
				['txtBcompno', 'lblBcomp', 'tgg', 'noa,comp', 'txtBcompno,txtBcomp', 'tgg_b.aspx'],
				['txtForwarderno', 'lblForwarder', 'tgg', 'noa,comp', 'txtForwarderno,txtForwarder', 'tgg_b.aspx']
			);
			
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
				
				q_cmbParse("cmbStype", q_getPara('orde.stype'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbWtype", q_getPara('custm.wtype'));
                q_cmbParse("cmbQtype", q_getPara('custm.qtype'));
                q_cmbParse("cmbPayterms", q_getPara('sys.payterms'));
                q_gt('country', '', 0, 0, 0, "");
            }

            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#btnMinus_' + j).click(function() {
                        btnMinus($(this).attr('id'));
                    });
                } //j
                
                if(q_getPara('sys.isport')=='1') //外銷
                	$('.isport').show();
                else
                	$('.isport').hide();
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

            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'country':
						var as = _q_appendData("country", "", true);
		                var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].cname+' '+as[i].country;
						}
						q_cmbParse("cmbCountry", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbCountry").val(abbm[q_recno].country);
						break;
            	}
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
		<div class='dbbm' style="width: 100%;">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr style="height:1px;">
					<td style="width:20%;"> </td>
					<td style="width:30%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:3px;"> </td>
				</tr>
				<tr>
					<td><a id="lblStype" style="float:right;"> </a></td>
					<td><select id="cmbStype"  style='width:98%;'> </select></td>
					<td >
						<input id="chkStypefix" type="checkbox" style=' '/>
						<a id="vewChkstype"> </a>
					</td>
					<td> </td>
					<td><input id="txtNoa" type="hidden" /></td>
				</tr>
				<tr>
					<td><a id="lblTaxtype" style="float:right;"> </a></td>
					<td><select id="cmbTaxtype" style='width:98%;'> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblQtype" style="float:right;"> </a></td>
					<td><select id="cmbQtype" style='width:98%;'> </select></td>
					<td><a id="lblWtype" style="float:right;"> </a></td>
					<td><select id="cmbWtype" style='width:98%;'> </select></td>
					<td> </td>
				</tr>
				<tr>
					<td><a id="lblVccad" style="float:right;"> </a></td>
					<td><input id="txtVccad" type="text" style='width:98%;'/></td>
					<td><a id="lblP23" style="float:right;"> </a></td>
					<td><input id="txtP23"maxlength="10" type="text" style="width:98%;" /></td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblAgent" style="float:right;"> </a></td>
					<td colspan="3">
						<input id="txtAgentno" type="text" style='width:30%;'/>
						<input id="txtAgent" type="text" style='width:68%;'/>
					</td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblPayterms" style="float:right;"> </a></td>
					<td><select id="cmbPayterms" style='width:98%;'> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblCountry" style="float:right;"> </a></td>
					<td colspan="3"><select id="cmbCountry" style='width:98%;'> </select></td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblArea" style="float:right;"> </a></td>
					<td colspan="3"><input id="txtArea" type="text" style='width:98%;'/></td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblEdock" style="float:right;"> </a></td>
					<td colspan="3"><input id="txtEdock" type="text" style='width:98%;'/></td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblForwarder" style="float:right;"> </a></td>
					<td colspan="3">
						<input id="txtForwarderno" type="text" style='width:30%;'/>
						<input id="txtForwarder" type="text" style='width:68%;'/>
					</td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblBcomp" style="float:right;"> </a></td>
					<td colspan="3">
						<input id="txtBcompno" type="text" style='width:30%;'/>
						<input id="txtBcomp" type="text" style='width:68%;'/>
					</td>
					<td> </td>
				</tr>
				<tr class="isport">
					<td><a id="lblBoat" style="float:right;"> </a></td>
					<td><input id="txtBoat" type="text" style='width:98%;'/></td>
					<td><a id="lblDhl" style="float:right;"> </a></td>
					<td><input id="txtDhl" type="text" style='width:98%;'/></td>
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
