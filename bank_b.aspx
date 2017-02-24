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
            var q_name = 'bank',
                t_content = '',
                bbsKey = ['noa'],
                as;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [],
                afield,
                t_data,
                t_htm,
                t_bbsTag = 'tbbs';
            var i,
                s1;
            $(document).ready(function() {
                main();
                r_accy = '';
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow();

                $('#btnSearch').click(function() {
                    var t_where = "1=1";
                    if ($.trim($('#txtBankno').val()).length>0) {
                        t_where += " and charindex('" + $('#txtBankno').val() + "',noa)>0";
                    }
                    if ($.trim($('#txtBank').val()).length>0) {
                        t_where += " and charindex('" + $('#txtBank').val() + "',bank)>0";
                    }
                    for (var i = 0; i < abbs.length; i++) {
                        if (abbs[i].sel == true || abbs[i].sel == "true") {
                            t_noa = t_noa + (t_noa.length > 0 ? ',' : '') + "'" + abbs[i].noa + "'";
                        }
                    }
                    //t_where="where=^^"+t_where+"^^"
                    location.href = "http://" + location.host + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";" + t_where + ";" + r_accy;
                });
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div id="dbbs" >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:95%;' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;'><a id='lblNoa'> </a></th>
					<th align="center" style='color:blue;'><a id='lblBank'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:35%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:95%;"  readonly="readonly" />
					</td>
					<td style="width:50%;">
					<input class="txt" id="txtBank.*" type="text" style="width:95%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<div>
				<a>銀行編號</a>
				<input class="txt" id="txtBankno" type="text" style="width:130px;" />
				<a>銀行名稱 </a>
				<input class="txt" id="txtBank" type="text" style="width:200px;" />
				<input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			</div>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>

