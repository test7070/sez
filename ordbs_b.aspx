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
			var q_name = 'ordbs', t_bbsTag = 'tbbs', t_content = " field=productno,product,unit,mount,noa,no3,price,total,weight,memo  order=odate ", afilter = [], bbsKey = ['noa', 'no3'], t_count = 0, as;
			var t_sqlname = 'ordbs';
			t_postname = q_name;
			//brwCount2 = 12;
			var isBott = false;
			/// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			brwCount = -1;
			$(document).ready(function() {
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
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProductno_' + t_id).val()))
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
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 15%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 100%;
                float: left;
            }
            .txt.c7 {
                float: left;
                width: 22%;
            }
            .txt.c8 {
                float: left;
                width: 65px;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
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
                    <input type="checkbox" id="checkAllCheckbox"/>
                    </td>
                    <td align="center"><a id='lblProductno'></a></td>
                    <td align="center"><a id='lblProduct'></a></td>
                    <!--<td align="center"><a id='lblSpec'></a></td>-->
                    <td align="center"><a id='lblUnit'></a></td>
                    <td align="center"><a id='lblMount'></a></td>
                    <!--<td align="center"><a id='lblWeight'></a></td>-->
                    <td align="center"><a id='lblPrice'></a></td>
                    <!--<td align="center"><a id='lblNotv'></a></td>-->
                    <td align="center"><a id='lblNoa'></a></td>
                    <td align="center"><a id='lblMemo'></a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td style="width:1%;" align="center">
                    <input class="btn"  id="chkSel.*" type="checkbox"  />
                    </td>
                    <td style="width:10%;">
                    <input class="txt"  id="txtProductno.*" type="text" style="width:98%;" />
                    </td>
                    <td style="width:15%;">
                    <input class="txt" id="txtProduct.*" type="text" style="width:98%;" />
                    </td>
                    <!--<td style="width:18%;"><input class="txt" id="txtSpec.*" type="text"  style="width:98%;" />
                    <input class="txt" id="txtDime.*" type="text"  style="width:25%;text-align:right;" />x
                    <input class="txt" id="txtWidth.*" type="text"  style="width:25%;text-align:right;" />x
                    <input class="txt" id="txtLengthb.*" type="text"  style="width:25%;text-align:right;" /></td>-->
                    <td style="width:4%;">
                    <input class="txt" id="txtUnit.*" type="text" style="width:94%;"/>
                    </td>
                    <td style="width:5%;">
                    <input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/>
                    </td>
                    <!--<td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>-->
                    <td style="width:8%;">
                    <input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/>
                    </td>
                    <!--<td style="width:8%;"><input class="txt" id="txtNotv.*" type="text" style="width:96%; text-align:right;"/></td>-->
                    <td style="width:8%;">
                    <input class="txt" id="txtNoa.*" type="text" style="width:98%;"/>
                    <input class="txt" id="txtNo3.*" type="text" style="width:98%;"/>
                    </td>
                    <td style="width:8%;">
                    <input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
                    <input id="recno.*" type="hidden" />
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/pop_ctrl.inc"-->
        </div>
    </body>
</html>
