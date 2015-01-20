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
            var q_name = 'conn', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'conn_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
			brwCount2 = 0;
			brwCount = -1;			
            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

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
                mainBrow(6, t_content, t_sqlname, t_postname);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
            }

            function bbsAssign() {/// 表身運算式
                _bbsAssign();
            }

            function btnOk() {
                sum();

                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['namea'] && !as['tel'] && !as['addr'] && !as['mobile']) {
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
                $('#btnPlus').click();
            }

            function boxStore() {

            }

            function refresh() {
                //        refresh2();
                _refresh();
            }

            function sum() {
            }

            function q_gtPost(t_postname) {  /// 資料下載後 ...
                //        q_gtPost2(t_postname);
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
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: 14px;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblNamea'></a></td>
					<td align="center"><a id='lblJob'></a></td>
					<td align="center"><a id='lblPart'></a></td>
					<td align="center"><a id='lblTel'></a></td>
					<td align="center"><a id='lblExt'></a></td>
					<td align="center"><a id='lblFax'></a></td>
					<td align="center"><a id='lblMobile'></a></td>
					<td align="center"><a id='lblEmail'></a></td>
					<td align="center"><a id='lblAddr'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  />
					</td>
					<td style="width:6%;">
					<input class="txt"  id="txtNamea.*" type="text" style="width:98%;"  />
					</td>
					<td style="width:6%;">
					<input class="txt" id="txtJob.*" type="text" style="width:98%;"   />
					</td>
					<td style="width:6%;">
					<input class="txt" id="txtPart.*" type="text" style="width:98%;"   />
					</td>
					<td style="width:10%;">
					<input class="txt" id="txtTel.*" type="text" style="width:94%;"  />
					</td>
					<td style="width:5%;">
					<input class="txt" id="txtExt.*" type="text" style="width:94%; text-align:right"  />
					</td>
					<td style="width:10%;">
					<input class="txt" id="txtFax.*" type="text" style="width:94%;"  />
					</td>
					<td style="width:10%;">
					<input class="txt" id="txtMobile.*" type="text" style="width:98%;"   />
					</td>
					<td style="width:12%;">
					<input class="txt" id="txtEmail.*" type="text" style="width:98%;"   />
					</td>
					<td style="width:15%;">
					<input class="txt" id="txtAddr.*" type="text" maxlength='90' style="width:98%;"  />
					<input id="txtNoq.*" type="hidden" />
					<input id="recno.*" type="hidden" />
					</td>
					<td style="width:20%;">
					<input class="txt" id="txtMemo.*" type="text" style="width:98%;"  />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
