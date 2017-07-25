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
            var q_name = 'custms', t_bbsTag = 'tbbs', t_content = "field=noa", afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = 'custms_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            q_desc=1;
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

            function q_gtPost() {

            }
            
            function bbsAssign() {
                _bbsAssign();
            }

            function refresh() {
                _refresh();
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
		</style>
	</head>

	<body>
		<div id="dbbs" >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:95%;' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;'><a id='lblBankno'>金融代號</a></th>
					<th align="center" style='color:blue;'><a id='lblBank'>銀行名稱</a></th>
					<th align="center" style='color:blue;'><a id='lblAccount'>銀行帳戶</a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:25%;">
                    <input class="txt" id="txtBankno.*" type="text" style="width:95%;"  readonly="readonly" />
                    </td>
					<td style="width:25%;">
					<input class="txt" id="txtBank.*" type="text" style="width:95%;"  readonly="readonly" />
					</td>
					<td style="width:35%;">
                    <input class="txt" id="txtAccount.*" type="text" style="width:95%;"  readonly="readonly" />
                    </td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>

