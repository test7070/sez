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
             var q_name = 'carspec', t_bbsTag = 'tbbs', t_content = " field=noa,spec  order=odate ", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = q_name;
            t_postname = q_name;
            brwCount = -1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var bbsNum = [];
            var i, s1;

            $(document).ready(function() {
            	if (!q_paraChk())
                    return;
                main();
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                $('#chkAll').click(function() {
                    for (var j = 0; j < brwCount2; j++) {
                        if (!emp($('#txtNoa_' + j).val()))
                            $('#chkSel_'+j)[0].checked = "true";
                    }
                });
            }

            function q_gtPost() {
            }
            function refresh(){
            	_refresh();
            }
             function bbsAssign() { 
        		_bbsAssign();
	   	
    		}
    		function checkall() {
                var check1 = document.getElementById("chkAll");
                var check2 = document.getElementsByName("chkSel");

                for (var i = 0; i < check2.length; i++) {
                    check2[i].checked = check1.checked;
                }
            }
		</script>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" ></th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
					<th align="center" style='color:Blue;' ><a id='lblSpec'></a></th>
				</tr>
				<tr>
					<td style="width:2%;">
					<input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/>
					</td>
					<td style="width:20%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:75%;">
					<input class="txt" id="txtSpec.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<input type="button"  id="chkAll" value="全選" onclick="checkall();" />
			<!--#include file="../inc/pop_ctrl.inc"--> 
		</div>
	</body>
</html>
