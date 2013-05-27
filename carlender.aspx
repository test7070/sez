<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript">
            var q_name = 'carlender', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount = -1, brwCount2 = 0;
            var t_sqlname = 'carlender_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
            var decbbs = ['money','installment', 'installmentamount', 'bkmoney'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbmNum_comma = [];
            var bbsNum = [['txtMoney', 10, 0, 1], ['txtInstallment', 2, 0, 1], ['txtDay', 2, 0, 1], ['txtInstallmentamount', 10, 0, 1],['txtBkmoney', 10, 0, 1]];
            var bbsNum_comma = [];
            var bbmMask = [];
            var bbsMask = [['txtBdate', '999/99/99'], ['txtEdate', '999/99/99']];
			aPop = [['txtCardealno_', 'btnCardeal_', 'cardeal', 'noa,comp', 'txtCardealno_,txtCardeal_', 'cardeal_b.aspx'],['txtLenderno_', 'btnLender_', 'lender', 'noa,comp', 'txtLenderno_,txtLender_', 'lender_b.aspx']];
			
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='A0254'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
            }
			function mainPost(){
			}
            function q_gtPost(t_name) {

            }

            function bbsAssign() {
            	for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
            		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            			$('#txtBdate_' + j).blur(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtBdate_' + b_seq).val())&&!emp($('#txtEdate_' +b_seq).val())){
		                     	$('#txtInstallment_' +b_seq).val((dec($('#txtEdate_' +b_seq).val().substr(0,3))*12+dec($('#txtEdate_' +b_seq).val().substr(4,2)))-(dec($('#txtBdate_' + b_seq).val().substr(0,3))*12+dec($('#txtBdate_' + b_seq).val().substr(4,2)))+1);
		                     }
		                     if(!emp($('#txtInstallmentamount_' + b_seq).val())){
		                     	$('#txtBkmoney_' +b_seq).val(dec($('#txtInstallmentamount_' +b_seq).val())*dec($('#txtInstallment_' +b_seq).val()));
		                     }
		                 });
            			
		                 $('#txtEdate_' + j).blur(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtBdate_' + b_seq).val())&&!emp($('#txtEdate_' +b_seq).val())){
		                     	$('#txtInstallment_' +b_seq).val((dec($('#txtEdate_' +b_seq).val().substr(0,3))*12+dec($('#txtEdate_' +b_seq).val().substr(4,2)))-(dec($('#txtBdate_' + b_seq).val().substr(0,3))*12+dec($('#txtBdate_' + b_seq).val().substr(4,2)))+1);
		                     	$('#txtDay_' +b_seq).val($('#txtEdate_' +b_seq).val().substr(7,2));
		                     }
		                     if(!emp($('#txtInstallmentamount_' + b_seq).val())){
		                     	$('#txtBkmoney_' +b_seq).val(dec($('#txtInstallmentamount_' +b_seq).val())*dec($('#txtInstallment_' +b_seq).val()));
		                     }
		                     
		                 });
		                 
		                 $('#txtInstallmentamount_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtInstallment_' + b_seq).val())&&!emp($('#txtInstallmentamount_' + b_seq).val())){
		                     	$('#txtBkmoney_' +b_seq).val(dec($('#txtInstallmentamount_' +b_seq).val())*dec($('#txtInstallment_' +b_seq).val()));
		                     }
		                 });
		                 
		                 $('#txtInstallment_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtInstallmentamount_' + b_seq).val())&&!emp($('#txtInstallment_' + b_seq).val())){
		                     	$('#txtBkmoney_' +b_seq).val(dec($('#txtInstallmentamount_' +b_seq).val())*dec($('#txtInstallment_' +b_seq).val()));
		                     }
		                 });
		                 $('#btnCarnos_' + j).click(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
							t_where = "carownerno" + q_getId()[3].substr(q_getId()[3].indexOf('='));
                    		q_box("car2_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;;", 'car2', "95%", "650px", q_getMsg('popCar2'));
		                 });
					}
            	} //j
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['lender']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
            }

            function sum() {
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
                if(q_tables == 's')
                    bbsAssign();
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'car2':
                    	b_ret = getb_ret(); 
                        if (b_ret != null) { 
                        	 $('#txtCarnos_' + b_seq).val('');
                        	 var t_carno='';
                            for (var i = 0; i < b_ret.length; i++) {
                            	if(i == b_ret.length-1)
                                	t_carno+=b_ret[i].noa;
                                else
                                	t_carno+=b_ret[i].noa+',';
                            }
                            $('#txtCarnos_' + b_seq).val(t_carno);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
		</script>
		<style type="text/css">
			.dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:10%;"><a id='lblCardeal'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblLender'></a></td>
					<td class="td4" align="center" style="width:8%;"><a id='lblBdate'></a></td>
					<td class="td5" align="center" style="width:8%;"><a id='lblEdate'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblMoney'></a></td>
					<td class="td7" align="center" style="width:8%;"><a id='lblInstallmentamount'></a></td>
					<td class="td8" align="center" style="width:4%;"><a id='lblInstallment'></a></td>
					<td class="td9" align="center" style="width:8%;"><a id='lblBkmoney'></a></td>
					<td class="td10" align="center" style="width:3%;"><a id='lblDay'></a></td>
					<td class="td11" align="center" style="width:15%;"><a id='lblCarnos'></a></td>
					<td class="td11" align="center" style="width:15%;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					<input class="txt" id="txtNoq.*" type="text" style="display:none;"   />
					</td>
					<td class="td2">
					<input class="txt"  id="txtCardealno.*" type="text" style="width:75%;"  />
					<input id="btnCardeal.*" type="button" value="." style="width: 5%;" />
					<input class="txt" id="txtCardeal.*" type="text" style="width:98%;"   />
					</td>
					<td class="td3">
					<input class="txt"  id="txtLenderno.*" type="text" style="width:75%;"  />
					<input id="btnLender.*" type="button" value="." style="width: 5%;" />
					<input class="txt" id="txtLender.*" type="text" style="width:98%;"   />
					</td>
					<td class="td4">
					<input class="txt" id="txtBdate.*" type="text" style="width:95%; text-align: center;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtEdate.*" type="text" style="width:95%; text-align: center;"  />
					</td>
					<td class="td6">
					<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td7">
					<input class="txt" id="txtInstallmentamount.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td8">
					<input class="txt" id="txtInstallment.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td9">
					<input class="txt" id="txtBkmoney.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td10">
					<input class="txt" id="txtDay.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td11">
					<input class="txt" id="txtCarnos.*" type="text" style="width:85%;"  />
					<input class="btn"  id="btnCarnos.*" type="button" value='.' style=" font-weight: bold;width: 5%;" />
					</td>
					<td class="td12">
					<input class="txt" id="txtMemo.*" type="text" style="width:95%;"  />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
