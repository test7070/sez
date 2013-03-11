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
            var q_name = 'ssspart', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'ssspart_load';
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

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa'];
                if (location.href.indexOf('?') < 0){}// debug
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
            }

            function bbsAssign() {/// 表身運算式
                _bbsAssign();
            }

            function btnOk() {
        		for(var i = 0; i < q_bbsCount; i++) {
        			if(desc($('#txtRank').val()) <1 or desc($('#txtRank').val()) > 8){
        				alert(q_getMsg('lblRank') + '輸入範圍為1~8');
        				return;
        			}
        		}
                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['rank']) {
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblPart'></a></td>
					<td align="center"><a id='lblRank'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold; "  />
					</td>
					<td style="width:6%;">
						<input class="txt" id="txtPart.*" type="text" maxlength='90' style="width:98%;"   />
					</td>
					<td style="width:6%;">
						<input class="txt" id="txtRank.*" type="text" maxlength='90' style="width:98%;"   />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
