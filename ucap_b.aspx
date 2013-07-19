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
            var q_name = 'ucap', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'ucap_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;

            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtPrice',15,2,1],['txtWages_fee',15,2,1],['txtMakes_fee',15,2,1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea','999/99/99'],['txtMon','999/99']];
           aPop = new Array(
        	['txtProductno_', '', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
        	['txtOrdeno_', '', 'ordes', 'noa,productno,product', 'txtOrdeno_,txtProductno_,txtProduct_', 'ordes_b.aspx']
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
                mainBrow(6, t_content, t_sqlname, t_postname);
            }
            function bbsAssign() {
                _bbsAssign();
            }

            function btnOk() {
                sum();

                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea'] ) {
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

            function sum() {
            }

            function q_gtPost(t_postname) { 
                
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
		<div id="dbbs" style="width: 100%;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:6%;"><a id='lblDatea'></a></td>
					<!--<td align="center" style="width:6%;"><a id='lblMon'></a></td>-->
					<td align="center" style="width:15%;"><a id='lblOrdeno'></a></td>
					<td align="center" style="width:15%;"><a id='lblProductno'></a></td>
					<!--<td align="center" style="width:6%;"><a id='lblPrice'></a></td>-->
					<td align="center" style="width:8%;"><a id='lblWages_fee'></a></td>
					<td align="center" style="width:8%;"><a id='lblMakes_fee'></a></td>
					<td align="center" style="width:20%;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td style="width:1%;">	<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  /></td>
					<td><input class="txt"  id="txtDatea.*" type="text" style="width:98%;"  /></td>
					<!--<td><input class="txt" id="txtMon.*" type="text" style="width:98%;"   /></td>-->
					<td><input class="txt"  id="txtOrdeno.*" type="text" style="width:98%;"  /></td>
					<td><input class="txt"  id="txtProductno.*" type="text" style="width:98%;"  />
						<input class="txt"  id="txtProduct.*" type="text" style="width:98%;"  />
					</td>
					<!--<td><input class="txt"  id="txtPrice.*" type="text" style="width:98%;text-align: right;"  /></td>-->
					<td><input class="txt"  id="txtWages_fee.*" type="text" style="width:98%;text-align: right;"  /></td>
					<td><input class="txt"  id="txtMakes_fee.*" type="text" style="width:98%;text-align: right;"  /></td>
					<td><input class="txt"  id="txtMemo.*" type="text" style="width:98%;"  /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
