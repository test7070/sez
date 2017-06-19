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
            var q_name = 'cust',
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
					var t_where="1=1";
					var t_condition = $.trim($('#txtCondition').val());
					if(t_condition.length>0){
						t_where+=" and( charindex('"+t_condition+"',noa)>0"
							+ " or charindex('"+t_condition+"',comp)>0"
							+ " or charindex('"+t_condition+"',nick)>0"
							+ " or charindex('"+t_condition+"',serial)>0"
							+ " or charindex('"+t_condition+"',tel)>0"
							+ " or charindex('"+t_condition+"',fax)>0"
							+ " or charindex('"+t_condition+"',mobile)>0)";
					}
					for(var i=0; i<abbs.length; i++){
						if(abbs[i].sel==true || abbs[i].sel=="true"){
							t_noa=t_noa+(t_noa.length>0?',':'')+"'"+abbs[i].noa+"'"; 
						}
					}
					//t_where="where=^^"+t_where+"^^"
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
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
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblComp'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblNick'>簡稱</a></th>
					<th align="center" style='color:Blue;' ><a id='lblSerial'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
					<td style="width:15%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:40%;"><input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:20%;"><input class="txt" id="txtNick.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:15%;"><input class="txt" id="txtSerial.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<div>
				<a>編號、名稱 、統編、電話</a>
				<input class="txt" id="txtCondition" type="text" style="width:130px;" />
				<input type="button" id="btnSearch" style="border-style: none; width: 26px; height: 26px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;background-size: 100%;">
			 </div>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>

