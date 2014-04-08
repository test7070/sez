<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'ordbt', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = 'ordbt';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'no4'];
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
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtRdate', r_picd], ['txtFdate', r_picd]];
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function btnOk() {
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['ordeno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
			}

			function refresh() {
				_refresh();
			}

			function q_gtPost(t_postname) {
				switch (t_postname) {
					case q_name:
						break;
				}
			}

			function q_popPost(s1) {
				switch (s1) {
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.c2 {
				width: 85%;
			}
			.c3 {
				width: 71%;
			}
			.c4 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 2000px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>

    </head>
    <body>
        <div  id="dbbs" >
            <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
                <tr>
                    <th align="center" > </th>
                    <th align="center" style='color:blue;' ><a id='lblNoa'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblTggno'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblTgg'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblRdate'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblRprice'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblFdate'> </a></th>
                    <th align="center" style='color:blue;' ><a id='lblFprice'> </a></th>
                </tr>
                <tr>
                    <td style="width:2%;">
                    <input name="sel"  id="radSel.*" type="radio" />
                    </td>
                    <td style="width:20%;">
                    <input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
                    </td>
                    <td style="width:10%;">
                    <input class="txt" id="txtTggno.*" type="text" style="width:98%;"  readonly="readonly" />
                    </td>
                    <td style="width:20%;">
                    <input class="txt" id="txtTgg.*" type="text" style="width:98%;"  readonly="readonly" />
                    </td>
                    <td style="width:10%;">
                    <input class="txt" id="txtRdate.*" type="text" style="width:98%;"  readonly="readonly" />
                    </td>
                    <td style="width:10%;">
                    <input class="txt" id="txtRprice.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" />
                    </td>
                    <td style="width:10%;">
                    <input class="txt" id="txtFdate.*" type="text" style="width:98%;"  readonly="readonly" />
                    </td>
                    <td style="width:10%;">
                    <input class="txt" id="txtFprice.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" />
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/pop_modi.inc"-->
        </div>

    </body>
</html>