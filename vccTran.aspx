<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            q_desc = 1;
            var q_name = "vcc";
            var q_readonly = ['txtNoa', 'txtAcomp', 'txtMoney', 'txtTotal','txtAccno','txtWorker','txtWorker2','txtKind'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0]];
            var bbsNum = [['txtPrice', 12, 3], ['txtMount', 9, 2], ['txtTotal', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
			brwCount2 = 10;
            
            aPop = new Array(
             ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,zip_invo,addr_invo,paytype', 'txtCustno,txtComp,txtNick,txtTel,txtZipcode,txtAddr,txtPaytype', 'cust_b.aspx']
            , ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']
            , ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            , ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm],['txtCarno', r_picd]];
                q_mask(bbmMask);
                //q_cmbParse("cmbStype", q_getPara('vcc.stype'));
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
                
                q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                $('#txtDatea').blur(function(e){
                	if($('#txtMon').val().length==0)
                		$('#txtMon').val($('#txtDatea').val().substring(0,6));
                });
				$("#cmbStype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbTaxtype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                }).change(function(e) {				
					sum();
				}).click(function(e) {			
					sum();
				});
				$("#cmbTrantype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbPartno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbPartno2").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
  				$("#combPaytype").change(function(e) {
  					if(q_cur==1 || q_cur==2)
					 $('#txtPaytype').val($('#combPaytype').find(":selected").text()); 
				});
				$("#txtPaytype").focus(function(e) {
  					var n=$(this).val().match(/[0-9]+/g);
  					var input = document.getElementById ("txtPaytype");
		            if (typeof(input.selectionStart) != 'undefined' && n != null) {	  
		                input.selectionStart = $(this).val().indexOf(n);
		                input.selectionEnd =$(this).val().indexOf(n)+n.length+1;
		            }
				});
				$("#txtTax").change(function(e) {				
					sum();
				});
              
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
                });
                $('#btnCustwork').click(function() {
					q_box("custtran.aspx?;;;noa='" + $('#txtCustno').val() + "'", 'cust', "95%", "95%", q_getMsg("popCust"));  
                });
				$('#lblInvono').click(function() {
                    var t_where = "";
                    var tmp = $('#txtInvono').val().split(',');
                    for (var i in tmp)
                    	t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
                    q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'vcca', 'noa', 'datea', "92%", "950px", q_getMsg('popVcca'), true);
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnModi();           
		                sum();
		                Unlock(1);
		                $('#txtDatea').focus();	
                		break;
                	case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item);
                            if (abbm[q_recno] != undefined) {
	                        	$("#cmbPartno").val(abbm[q_recno].partno);
	                        }
                            q_cmbParse("cmbPartno2", t_item);
                             if (abbm[q_recno] != undefined) {
	                        	$("#cmbPartno2").val(abbm[q_recno].partno2);
	                        }
                        }
                        break;
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
	                        var t_item = " @ ";
	                        for ( i = 0; i < as.length; i++) {
	                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
	                        }
	                        q_cmbParse("cmbCno", t_item);
	                        if (abbm[q_recno] != undefined) {
	                        	$("#cmbCno").val(abbm[q_recno].cno);
	                        }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
            	if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+r_accy+'】年度再作業。');
					Unlock(1);
            		return;
				}
            	if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
            		alert(q_getMsg('lblMon')+'錯誤。');
            		Unlock(1);
            		return;
            	}
                sum();
                if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!")
	            }
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());
                $('#txtPart2').val($('#cmbPartno2').find(":selected").text());
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcctran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('vcc_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
          		if (q_chkClose())
             		    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnModi',r_accy);
            }
            function btnPrint() {
            	q_box('z_vcctran.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "650px", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtAcc1_' + i).change(function() {
                            var patt = /^(\d{4})([^\.,.]*)$/g;
		                    $(this).val($(this).val().replace(patt,"$1.$2"));
                        });
                        $('#txtMount_' + i).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + i).change(function() {
                            sum();
                        });
                        $('#txtTotal_' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
            	t_err = '';
                if (parseFloat(as['total'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;	
            	var t_money = 0, t_tax = 0, t_total=0;
            	var t_moneys;
                for ( j = 0; j < q_bbsCount; j++) {
                	t_moneys = q_float('txtMount_'+j).mul(q_float('txtPrice_'+j)).round(0);
                	$('#txtTotal_'+j).val(FormatNumber(t_moneys));
                	t_money = t_money.add(t_moneys);
                }
                t_tax = q_float('txtTax');
                t_total = t_money.add(t_tax);
			    $('#txtMoney').val(FormatNumber(t_money));
			    $('#txtTax').val(FormatNumber(t_tax));
			    $('#txtTotal').val(FormatNumber(t_total));
            }
            function refresh(recno) {
                _refresh(recno);
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
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
				if (q_chkClose())
             		return;
            	Lock(1,{opacity:0});
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnDele',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
			
		
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 650px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewComp"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewTotal"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewUnpay"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input type="text" id="txtNoa" style="width:120px;" class="txt c1"/>	</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input type="text" id="txtMon" class="txt c1"/></td>						
					</tr>
					<tr>
						<td><span> </span><a id="lblCno" class="lbl"> </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input type="text" id="txtCustno" style="float:left;width:30%;"/>
							<input type="text" id="txtComp" style="float:left;width:70%;"/>
							<input type="text" id="txtNick" style="display:none;"/>
						</td>
						<td><input id="btnCustwork" type="button"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" style="float:left; width:20px;"> </select>
							<span> </span><a id='lblTrantype' class="lbl"> </a>
						</td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input type="text" id="txtTel" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="5">
							<input type="text" id="txtZipcode" style="float:left;width:10%;"/>
							<input type="text" id="txtAddr" style="float:left;width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno" style="float:left;width:40%;"/>
							<input type="text" id="txtSales" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart2" class="lbl btn"> </a></td>
						<td>
							<select id="cmbPartno2" class="txt c1"> </select>
							<input id="txtPart2"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id='lblSales2' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno2" style="float:left;width:40%;"/>
							<input type="text" id="txtSales2" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input type="text" id="txtCarno" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td colspan="3"><input type="text" id="txtInvono" class="txt c1"/></td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/>	</td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input type="text" id="txtAccno" class="txt c1"/></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><input type="text" id="txtKind" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input type="text" id="txtWorker" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input type="text" id="txtWorker2" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:300px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnProductno.*" type="button" value=".." style="float:left;width:20px;"/>
						<input id="txtProductno.*"type="text" style="float:left;width: 120px;"/>			
					</td>
					<td><input id="txtProduct.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtTotal.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
