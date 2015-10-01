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
            var q_name = 'cust', t_content = ' field=noa,comp,tel,zip_fact,addr_fact,trantype,zip_invo,addr_invo,paytype,nick,conn,conntel', bbsKey = ['noa'], as;
            var t_sqlname = 'cust_load';
            t_postname = q_name;
            brwCount2 = 20;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            $(document).ready(function() {
                main();
            });
            /// end ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                //mainBrow(0, t_content);
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                
                $('#btnSearch').click(function() {
                    var t_where = "1=1";
                    if (!emp($('#txtNoa').val())) {
                        t_where += " and charindex('" + $('#txtNoa').val() + "',noa)>0";
                    }
                    if (!emp($('#txComp').val())) {
                        t_where += " and charindex('" + $('#txComp').val() + "',comp)>0";
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
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
				</tr>
				<tr>
					<td style="width:2%;">
					<input name="chk"  id="chkSel.*" type="checkbox" />
					</td>
					<td style="width:20%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:75%;">
					<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
			<div>
				<a>客戶編號</a>
				<input class="txt" id="txtNoa" type="text" style="width:130px;" />
				<a>客戶名稱 </a>
				<input class="txt" id="txComp" type="text" style="width:200px;" />
				<input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			</div>
		</div>
	</body>
</html>

