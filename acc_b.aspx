
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script type="text/javascript">
            var q_name = 'acc',
                t_content = ' field=acc1,acc2',
                bbsKey = ['acc1'],
                as;
            var isBott = false;
            var txtfield = [],
                afield,
                t_data,
                t_htm,
                t_bbsTag = 'tbbs';
            var i,
                s1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                var s2 = q_getId();
                var s3 = (s2 && s2.length > 3 ? s2[3] : '');
                //篩選科目
                var s1 = (s2 && s2.length > 3 ? s2[4] : '');
                //年度
                mainBrow(0, '', '', '', s1);
            
                $('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#textAcc1').val())){
						t_where+=" and charindex('"+$('#textAcc1').val()+"',acc1)>0";
					}
					if(!emp($('#textAcc2').val())){
						t_where+=" and charindex('"+$('#textAcc2').val()+"',acc2)>0";
					}
					
					//t_where="where=^^"+t_where+"^^"
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy+"_"+r_cno;
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
		<div  id="dbbs" >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" style='width:5%;'></th>
					<th align="center" style='color:blue;width:35%;' ><a id='lblAcc1'></a></th>
					<th align="center" style='color:blue;width:60%;' ><a id='lblAcc2'></a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:20%;">
					<input class="txt" id="txtAcc1.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:75%;">
					<input class="txt" id="txtAcc2.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<div>
				<a>會計科目</a>
				<input class="txt" id="textAcc1" type="text" style="width:150px;" />
				<a>科目名稱 </a>
				 <input class="txt" id="textAcc2" type="text" style="width:150px;" />
				 <input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			 </div>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>

