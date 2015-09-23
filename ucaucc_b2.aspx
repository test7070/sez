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
            var q_name = 'view_ucaucc', t_content = ' field=noa,product,spec,unit order=odate', bbsKey = ['noa'], as;
            var t_sqlname = 'ucaucc_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            brwCount2 = 30;

            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);

                $('#btnSearch').click(function() {
                    var t_where = "1=1";
                    if (!emp($('#txtNoa').val())) {
                        t_where += " and charindex('" + $('#txtNoa').val() + "',noa)>0";
                    }
                    if (!emp($('#txtProductno').val())) {
                        t_where += " and charindex('" + $('#txtProductno').val() + "',product)>0";
                    }
                    var t_noa = '';
                    for (var i = 0; i < abbs.length; i++) {
                        if (abbs[i].sel == true || abbs[i].sel == "true") {
                            t_noa = t_noa + (t_noa.length > 0 ? ',' : '') + "'" + abbs[i].noa + "'";
                        }
                    }
                    if (t_noa.length > 0)
                        t_where += " or noa in (" + t_noa + ")";

                    //t_where="where=^^"+t_where+"^^"
                    location.href = location.origin + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";" + t_where + ";" + r_accy;
                });
            }

            function q_gtPost() {
            }

            var xuccno = ''
            function bbsAssign() {
                _bbsAssign();
                if (isbtnBott && !isbtnTop) {
                    isbtnTop = true;
                    for (var i = 0; i < t_noa.length; i++) {
                        for (var j = 0; j < abbs.length; j++) {
                            if (t_noa[i] == abbs[j].noa) {
                                abbs[j].sel = true
                                break;
                            }
                        }
                    }
                    $('#btnTop').click();
                    _refresh();
                    if(brwNowPage==0)
                    	brwNowPage=1
                }
                if (t_noa.length > 0 && !isbtnBott && !isbtnTop) {
                    isbtnBott = true;
                    setTimeout(function() {
                        $('#btnBott').click()
                    }, 1000);
                    //$('#btnBott').click();
                }
                if (q_getPara('sys.project').toUpperCase() == 'RB') {
                    $('.rbhide').hide();
                }
            }

            var isbtnBott = false, isbtnTop = false, t_noa = "";
            function refresh() {
                for (var i = 0; i < q_getHref().length; i++) {
                    if (q_getHref()[i] != undefined) {
                        if (q_getHref()[i].indexOf('or noa in') > -1) {
                            t_noa = q_getHref()[i].substring(q_getHref()[i].indexOf('or noa in'));
                            t_noa = t_noa.replace("or noa in ('", '');
                            t_noa = t_noa.replace("')", '');
                            t_noa = t_noa.split("','");
                            break;
                        }
                    }
                }
                _refresh();

                if (q_getPara('sys.project').toUpperCase() == 'RB') {
                    $('.rbhide').hide();
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" border="2" cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblProduct'> </a></th>
					<th align="center" style='color:blue;' class="rbhide"><a id='lblSpec'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;"><input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;" readonly="readonly" /></td>
					<td style="width:40%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" readonly="readonly" /></td>
					<td style="width:40%;" class="rbhide"><input class="txt" id="txtSpec.*" type="text" style="width:98%;" readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
			<div>
				<a>物品編號</a>
				<input class="txt" id="txtNoa" type="text" style="width:130px;" />
				<a>物品名稱 </a>
				<input class="txt" id="txtProductno" type="text" style="width:200px;" />
				<input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			</div>
		</div>
	</body>
</html>