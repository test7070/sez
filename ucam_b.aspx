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
            var q_name = 'ucam', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'ucam_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;

            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
           aPop = new Array(['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']);

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (location.href.indexOf('?') < 0)// debug
                {
                    // location.href = location.href + "?;;;noa='0015'";
                    // return;
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
                mainBrow(6, t_content, t_sqlname, t_postname);
            }
            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtCustno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var Parent = window.parent.document;
                			var x_noa=Parent.getElementById('txtNoa').value;
							if (!emp(x_noa)) {
								var t_where = "where=^^ noa='"+x_noa+"' and custno='"+$('#txtCustno_'+b_seq).val()+"' ^^";
								q_gt('ucam', t_where , 0, 0, 0, "ucam_cust", r_accy);
							}
                		});
                	}
                }
                _bbsAssign();
            }
            
            function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtCustno_':							
							var Parent = window.parent.document;
                			var x_noa=Parent.getElementById('txtNoa').value;
							if (!emp(x_noa)) {
								var t_where = "where=^^ noa='"+x_noa+"' and custno='"+$('#txtCustno_'+b_seq).val()+"' ^^";
								q_gt('ucam', t_where , 0, 0, 0, "ucam_cust", r_accy);
							}
			        break;
		    	}
			}

            function btnOk() {
                sum();

                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['custno'] ) {
                    as[bbsKey[0]] = '';
                    return;
                }

                q_getId2('', as);

                return true;

            }

            function btnModi() {
                var t_key = q_getHref();

                if (!t_key)
                    return;

                _btnModi(1);

                for ( i = 0; i < abbsDele.length; i++) {
                    abbsDele[i][bbsKey[0]] = t_key[1];
                }
            }

            function boxStore() {

            }

            function refresh() {
                //        refresh2();
                _refresh();
            }

            function sum() {
            }

            function q_gtPost(t_postname) { 
                switch (t_postname) {
	            	case 'ucam_cust':
						var as = _q_appendData("ucam", "", true);
						if(as[0]!=undefined){
							alert($('#txtComp_'+b_seq).val()+" 重覆輸入!!");
							$('#txtCustno_'+b_seq).val('')
							$('#txtComp_'+b_seq).val('');
							break;
						}
						for(var j = 0; j < q_bbsCount; j++) {
							if(!emp($('#txtCustno_'+b_seq).val())&&!emp($('#txtCustno_'+j).val())&&$('#txtCustno_'+j).val()==$('#txtCustno_'+b_seq).val() &&j!=b_seq){
								alert($('#txtComp_'+b_seq).val()+" 重覆輸入!!");
								$('#txtCustno_'+b_seq).val('')
								$('#txtComp_'+b_seq).val('');
								break;
							}
						}
					 break;
	            }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                
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
		</style>
	</head>
	<body>
		<div id="dbbs" style="width: 100%;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:35%;"><a id='lblCust'></a></td>
					<td align="center" style="width:20%;"><a id='lblModel'></a></td>
					<td align="center" style="width:20%;"><a id='lblPack'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td style="width:1%;">	
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  />
						<input class="txt"  id="txtNoa.*" type="hidden"/>
						<input class="txt"  id="txtNoq.*" type="hidden"/>
					</td>
					<td>
						<input class="btn"  id="btnCustno.*" type="button" value='.' style=" font-weight: bold;" />
						<input class="txt"  id="txtCustno.*" type="text" style="width:30%;"  />
						<input class="txt"  id="txtComp.*" type="text" style="width:55%;"  />
					</td>
					<td><input class="txt"  id="txtModel.*" type="text" style="width:98%;"  /></td>
					<td><input class="txt"  id="txtPack.*" type="text" style="width:98%;"  /></td>
					<td><input class="txt"  id="txtMemo.*" type="text" style="width:98%;"  /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
