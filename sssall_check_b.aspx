<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'sss', t_content = " field=noa,namea,partno,part", bbsKey = ['noa'], as;
            var t_sqlname = 'sssall_load'; t_postname = q_name; brwCount2 = 12;
            var isBott = false;
            //q_alias='a';
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            $(document).ready(function() {
                main();
            });
            // end ready

            function main() {
                if(dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
            	$('#btnClickall').click(function() {
            		if($('#btnClickall').val() == '全選'){
			 			for (var j = 0; j < brwCount2; j++) {
							if(!emp($('#txtNoa_'+j).val()))
								$('#chkSel_'+j).attr('checked',true);
						}
						$('#btnClickall').val('取消全選');
					}else if($('#btnClickall').val() == '取消全選'){
			 			for (var j = 0; j < brwCount2; j++) {
							if(!emp($('#txtNoa_'+j).val()))
								$('#chkSel_'+j).removeAttr('checked');
						}
						$('#btnClickall').val('全選');
					}
				});
            }
            
            function bbsAssign() {  /// checked 
		        _bbsAssign();
		    }
		</script>
		<style type="text/css">
			.chk{
				margin:0px;
			}
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" ><input id="btnClickall" type="button" value="全選"></th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
					<th align="center" style='color:Blue;' ><a id='lblNamea'></a></th>
				</tr>
				<tr>
					<td style="width:8%;">
						<input class="chk"  id="chkSel.*" type="checkbox"style="width:100%" name="chkSel"/>
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:60%;">
						<input class="txt" id="txtNamea.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
