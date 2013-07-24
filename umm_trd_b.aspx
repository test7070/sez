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
            var q_name = 'view_trd', t_bbsTag = 'tbbs', t_content = " field=noa,paysale,total,part,comp,memo  order=odate ", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'umm_trd_load';
            t_postname = q_name;
            brwCount2 = 0;
            brwCount = -1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var bbsNum = [['txtPaysale', 10, 0], ['txtTotal', 10, 0], ['txtOpay', 10, 0]];
            var i, s1;

            $(document).ready(function() {
                if (location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;^^1=0^^where[1]=^^1=0^^";
                    return;
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
                var Parent = window.parent.document;
                var x_custno=Parent.getElementById('txtCustno').value;
                var x_datea=Parent.getElementById('txtDatea').value;
                var x_custno2=Parent.getElementById('txtCustno2').value;
                var x_noa=Parent.getElementById('txtNoa').value;
                var x_custno=Parent.getElementById('txtCustno').value;
                
                var t_where='',t_where1='',t_where2='',t_where3='',t_where4='',t_where5='',t_where6='',t_where7='';
				if (!emp(x_custno)) {
                      //  var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
						t_where = "swhere=^^(a.custno='" + $.trim(x_custno) + "'";
						t_where6= " where[6]=^^ (a.custno='" + $.trim(x_custno) + "'";
						t_where3 = " where[3]=^^ (c.noa='" + x_custno + "' ";
						t_where5 = " where[5]=^^(((a.custno='" + x_custno + "' ";
						
						if(!emp(x_datea))
							t_where4 = " where[4]=^^ mon='"+x_datea.substr(0,6)+"' ^^";
						else
							t_where4 = " where[4]=^^ carno+mon in (select carno+MAX(mon) from cara group by carno) ^^";
						
                        if (!emp(x_custno2)) {
                            var t_custno2 = (x_custno2).split(",");
                            for (var i = 0; i < t_custno2.length; i++) {
                                t_where += " or a.custno ='" + t_custno2[i] + "'"
                                t_where6+=" or a.custno ='" + t_custno2[i] + "'"
                                t_where3 += " or c.noa ='" + t_custno2[i] + "'"
                                t_where5 += " or a.custno ='" + t_custno2[i] + "'"
                            }
                        }
                        t_where+=") and (a.unpay+isnull(b.paysale,0))!=0 ";
                        t_where6+=") and (a.unpay+isnull(b.paysale,0))!=0 and (CHARINDEX('會計',kind)=0 or a.datea<'102/04/01')";//1020410會計部從102/04/01開始用明細匯入
                        t_where1 = " where[1]=^^ a.noa='" + x_noa + "' and a.paysale!=0 ";
						
						if(!emp(x_datea))
							t_where2 = " where[2]=^^ left(a.datea,6)='" + x_datea.substr(0, 6) + "' and  a.noa='" + x_noa + "' ^^";
						else
							t_where2 = " where[2]=^^ 1=1 and a.noa='" + x_noa + "' ^^";
						
						t_where3 +=") ^^"
						
						//1020410會計部從102/04/01開始用明細匯入
						//1020509要不包含單據的立帳單
						t_where5 += " ) and (CHARINDEX('會計',kind)>0) and a.unpay!=0) or ((a.noa+isnull(b.product,'')+b.noq in (select vccno+memo2 from umms where noa='"+x_noa+"')))) and a.datea>='102/04/01' order by noa^^";
						t_where7 = " where[7]=^^ noa!='"+x_noa+"' ^^";
                        	
                       // 最後一個t_whereX 加 order by noa^^";

                       t_where += "^^";
                       t_where6 += "^^";
                       t_where1 += "^^";
                    } else {
                        t_where = "swhere=^^1=0^^";
                        t_where6 = " where[6]=^^ 1=0 ^^";
                        t_where1 = " where[1]=^^ 1=0 ^^";
                        t_where2 = " where[2]=^^ 1=1 ^^";
                        t_where3 = " where[3]=^^ 1=0 ^^";
                        t_where5 = " where[5]=^^ 1=0 order by noa ^^";
                        t_where4 = " where[4]=^^ carno+mon in (select carno+MAX(mon) from cara group by carno) ^^";
                        t_where7 = " where[7]=^^ 1=1 ^^";
                    }
                
                t_content=t_where+t_where1+t_where2+t_where3+t_where4+t_where5+t_where6+t_where7
                
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                
                $('#chkAll').click(function() {
                    for (var j = 0; j < q_bbsCount; j++) {
                        if (!emp($('#txtNoa_' + j).val()))
                            $('#chkSel_'+j)[0].checked = "true";
                    }
                });
                $('#btnNext').hide();
                $('#btnBott').hide();
                $('#btnPrev').hide();
                $('#btnTop').hide();
            }

            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!emp($('#txtNoa_' + j).val())) {
                        q_tr('txtPaysale_' + j, q_float('txtTotal_' + j) - q_float('txtUnpay_' + j));
                        q_tr('txtOpay_' + j, q_float('txtUnpay_' + j));
                        $('#txtComp_' + j).val($('#txtNick_' + j).val());
                    }
                }
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
            }

            function checkall() {
                var check1 = document.getElementById("chkAll");
                var check2 = document.getElementsByName("chkSel");

                for (var i = 0; i < check2.length; i++) {
                    check2[i].checked = check1.checked;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 18%;
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
                width: 80%;
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
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
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
					<td align="center" style="width: 3%;"></td>
					<td align="center" style="width: 15%;"><a id='lblVccno'></a></td>
					<td align="center" style="width: 15%;"><a id='lblTotal'></a></td>
					<td align="center" style="width: 15%;"><a id='lblPaysale'></a></td>
					<td align="center" style="width: 15%;"><a id='lblOpay'></a></td>
					<td align="center" style="width: 10%;"><a id='lblPart'></a></td>
					<td align="center"><a id='lblComp'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>
					<input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/>
					</td>
					<td>
					<input id="txtNoa.*" type="text" class="txt c1" />
					</td>
					<td>
					<input id="txtTotal.*" type="text" class="txt num c1"/>
					<input id="txtUnpay.*" type="text" style="display:none;"/>
					</td>
					<td>
					<input id="txtPaysale.*" type="text" class="txt num c1"/>
					</td>
					<td>
					<input id="txtOpay.*" type="text" class="txt num c1" />
					</td>
					<td>
					<input id="txtPart.*" type="text" class="txt c1"/>
					</td>
					<td>
					<input id="txtComp.*" type="text" class="txt c1"/>
					<input id="txtNick.*" type="text" style="display:none;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
					</td>
				</tr>
			</table>
			<input type="button"  id="chkAll" value="全選" onclick="checkall();" />
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
