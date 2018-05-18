<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = 'bom', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'bom_load';
            t_postname = q_name;
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
            aPop = new Array(
					['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx'],
 					['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx'],
 					['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx']
           	);

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (location.href.indexOf('?') < 0)// debug
                {
                    // location.href = location.href + "?;;;noa='0015'";
                    // return;
                }
                if (!q_paraChk())
                    return;

                main();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
            }

            function bbsAssign() {/// 表身運算式
                _bbsAssign();
            }

            function btnOk() {
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['process'] && !as['product'] ) {
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

                for ( i = 0; i < abbsDele.length; i++) {
                    abbsDele[i][bbsKey[0]] = t_key[1];
                }
            }

            function boxStore() {

            }

            function refresh() {
                //        refresh2();
                _refresh();
            }
            function q_gtPost(t_postname) {  /// 資料下載後 ...
                //        q_gtPost2(t_postname);
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
                /// 表身運算式
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            .txt.num{
            	text-align: right;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:180%;font-size: 14px;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblProcess'></a></td>
					<td align="center"><a id='lblProductno'></a></td>
					<td align="center"><a id='lblProduct'></a></td>
					<td align="center"><a id='lblUnit'></a></td>
					<td align="center"><a id='lblMount'></a></td>
					<td align="center"><a id='lblOuts'></a></td>
					<td align="center"><a id='lblTggno'></a></td>
					<td align="center"><a id='lblTgg'></a></td>
					<td align="center"><a id='lblMechno'></a></td>
					<td align="center"><a id='lblMech'></a></td>
					<td align="center"><a id='lblModelno'></a></td>
					<td align="center"><a id='lblModel'></a></td>
					<td align="center"><a id='lblBase'></a></td>
					<td align="center"><a id='lblLoss'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
					<td align="center"><a id='lblUweight'></a></td>
					<td align="center"><a id='lblDaymount'></a></td>
					<td align="center"><a id='lblDayprod'></a></td>
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  />
					</td>
					<td>
						<input class="txt"  id="txtProcess.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtProductno.*" type="text" style="width:80%;"  />
						<input id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td>
						<input class="txt"  id="txtProduct.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtUnit.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtMount.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtOuts.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtTggno.*" type="text" style="width:80%;"  />
						<input id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td>
						<input class="txt"  id="txtTgg.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtMechno.*" type="text" style="width:80%;"  />
						<input id="btnMechno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td>
						<input class="txt"  id="txtMech.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtModelno.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtModel.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt num"  id="txtBase.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt num"  id="txtLoss.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt"  id="txtMemo.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt num"  id="txtUweight.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt num"  id="txtDaymount.*" type="text" style="width:98%;"  />
					</td>
					<td>
						<input class="txt num"  id="txtDayprod.*" type="text" style="width:98%;"  />
					</td>
					<td style="display:none;">
						<input id="txtNoq.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
