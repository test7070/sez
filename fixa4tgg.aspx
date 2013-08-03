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
		    var q_name = "fixa4tgg";
		    var q_readonly = ['txtNoa', 'txtWmoney', 'txtCmoney','txtMoney', 'txtTotal','txtWorker'];
		    var q_readonlys = ['txtMemo2'];
		    var bbmNum = new Array(['txtMoney', 10, 0]);
		    var bbsNum = new Array(['txtPrice', 10, 1], ['txtMount', 10, 1], ['txtMoney', 10, 0]);
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    //ajaxPath = "";
		    aPop = new Array(
		    	['txtCarno', '', 'car2', 'a.noa', 'txtCarno', 'car2_b.aspx'],	    
		    	['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
		    	['txtCarplateno', '', 'carplate', 'noa,carplate', 'txtCarplateno', 'carplate_b.aspx'], 
		    	['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,inprice', 'txtProductno_,txtProduct_,txtPrice_', 'fixucc_b.aspx',0,0,'txtTggno','noa']);
		    q_desc = 1;
	
		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_content="where=^^ tggno='"+r_userno+"'^^";
		        q_gt(q_name,q_content, q_sqlCount, 1);
		    });

		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);
		    } 

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd]];
		        q_mask(bbmMask);
		        $('#txtDatea').datepicker();
		    }

		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		            case q_name + '_s':
		                q_boxClose2(s2);
		                break;
		        }  
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
		            	if(t_name.substring(0,12)=='fixalasttime'){
		            		var sel = parseInt(t_name.split('_')[1]);
		            		var as = _q_appendData("fixa", "", true);
                        	if (as[0] != undefined) {
                        		$('#txtMemo2_'+sel).val(as[0].fixadate);
                        	}else{
                        		
                        	}
                        	sum();
                        	Unlock(1);
		            	}else if(t_name.substring(0,11)=='oillasttime'){
		            		var as = _q_appendData("oil", "", true);
                        	if (as[0] != undefined) {
                        		$('#txtMiles').val(FormatNumber(as[0].emiles));
                        	}else{
                        		$('#txtMiles').val('0');
                        	}
                        	Unlock(1);
		            	}
		            	break;
		        }  /// end switch
		    }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
		    function btnOk() {
		    	Lock(1,{opacity:0});
	            if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
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
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('fixa4tgg_s.aspx', q_name + '_s', "500px", "550px", q_getMsg("popSeek"));
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#cmbWtype_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });
		                //$('#txtMemo_' + i).data('info', { index: i });
		                $('#txtMemo_' + i).change(function (e) {
		                    if ($.trim($(this).val()).substring(0, 1) == '.')
		                        $('#txtMoney_' + i).removeAttr('readonly');
		                    else
		                        $('#txtMoney_' + i).attr('readonly', 'readonly');
		                    sum();
		                });
		                $('#txtMemo_' + i).change();
		            }
		        }
		        _bbsAssign();
		    }

		    function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                if($('#txtDatea').val().length==0)
               		$('#txtDatea').val(q_date());
		        $('#txtDatea').focus();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                t_where=" where=^^ rc2no='"+$('#txtNoa').val()+"'^^";
            	q_gt('paybs', t_where, 0, 0, 0, "btnModi", r_accy);
		    }

		    function btnPrint() {
				q_box("z_fixa4tgg.aspx?;;;;"+r_accy, 'z_fixa4tgg', "95%", "95%", q_getMsg("popFixa4tgg"));
		    }

		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }

		    function bbsSave(as) {
		        if (!as['productno'] && !as['product']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    function q_popPost(t_id) {
		    	switch(t_id){
		    		case 'txtCarno':
		    			Lock(1,{opacity:0});
		    			var t_fixadate = $.trim($('#txtFixadate').val());
		    			var t_carno = $.trim($('#txtCarno').val());
		    			if(t_fixadate.length==0){
		    				alert('請輸入'+q_getMsg('lblFixadate'));
		    				Unlock(1);
		    				return;
		    			}
		    			if(t_carno.length==0){
		    				alert('請輸入'+q_getMsg('lblCarno'));
		    				Unlock(1);
		    				return;
		    			}	
		    			var t_where = "where=^^ carno='"+t_carno+"' and oildate<'"+t_fixadate+"' ^^";
		    			q_gt('oil_lasttime', t_where, 0, 0, 0,'oillasttime', r_accy);
		    			break;
		    		case 'txtProductno_':
		    			Lock(1,{opacity:0});
		    			var t_noa = $.trim($('#txtNoa').val());
		    			var t_fixadate = $.trim($('#txtFixadate').val());
		    			var t_carno = $.trim($('#txtCarno').val());
		    			var t_carplateno = $.trim($('#txtCarplateno').val());
		    			var t_productno = $.trim($('#txtProductno_'+b_seq).val());
		    			$('#txtMemo2_'+b_seq).val('');
		    			if(t_fixadate.length==0){
		    				alert('請輸入'+q_getMsg('lblFixadate'));
		    				Unlock(1);
		    				return;
		    			}
		    			if(t_carno.length==0 && t_carplateno.length==0){
		    				alert('請輸入'+q_getMsg('lblCarno')+'或'+q_getMsg('lblCarplateno'));
		    				Unlock(1);
		    				return;
		    			}	
		    			if(t_productno.length==0){
		    				alert('請輸入'+q_getMsg('lblProduct_s'));
		    				Unlock(1);
		    				return;
		    			}
		    			var t_where ="";
		    			if(t_carplateno.length==0)
		    				t_where ="where=^^ (b.noa is not null) and b.noa!='"+t_noa+"' and b.productno='"+t_productno+"' and a.carno='"+t_carno+"' and len(isnull(a.carplateno,''))=0 and a.fixadate<'"+t_fixadate+"' ^^"
                		else
                			t_where ="where=^^ (b.noa is not null) and b.noa!='"+t_noa+"' and b.productno='"+t_productno+"' and a.carplateno='"+t_carplateno+"' and a.fixadate<'"+t_fixadate+"' ^^"
                		q_gt('fixa_lasttime', t_where, 0, 0, 0,'fixalasttime_'+b_seq, r_accy);
		    			break;
		    		default:
		    			break;
		    	}
            }

		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		        var t_mount, t_price, t_money = 0, t_wmoney = 0, t_cmoney = 0, t_tax,t_discount;
		        for (var j = 0; j < q_bbsCount; j++) {
		            if ($.trim($('#txtMemo_' + j).val()).substring(0, 1) != '.') {
						t_mount = q_float('txtMount_' + j);
						t_price = q_float('txtPrice_' + j);
						t_money = t_mount.mul(t_price).round(0);
		                $('#txtMoney_' + j).val(t_money);
		            } else {
		                t_money = q_float('txtMoney_' + j);
		            }
		            t_wmoney = t_wmoney + ($('#cmbWtype_' + j).val() == 'A' ? t_money : 0);
		            t_cmoney = t_cmoney + ($('#cmbWtype_' + j).val() == 'B' ? t_money : 0);
		        }
		        t_tax = q_float('txtTax');
		        t_discount = q_float('txtDiscount');
		        $('#txtWmoney').val(FormatNumber(t_wmoney));
		        $('#txtCmoney').val(FormatNumber(t_cmoney));
		        $('#txtMoney').val(FormatNumber(t_wmoney + t_cmoney));
		        $('#txtTotal').val(FormatNumber(t_wmoney + t_cmoney + t_tax - t_discount));
		    }

		    function refresh(recno) {
		        _refresh(recno);
		    }
		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		        for (var i = 0; i < q_bbsCount; i++) {
		            if ($.trim($('#txtMemo_' + i).val()).substring(0, 1) == '.')
		                $('#txtMoney_' + i).removeAttr('readonly');
		            else
		                $('#txtMoney_' + i).attr('readonly', 'readonly');
		        }
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
		        Lock(1,{opacity:0});
                t_where=" where=^^ rc2no='"+$('#txtNoa').val()+"'^^";
            	q_gt('paybs', t_where, 0, 0, 0, "btnDele", r_accy);
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
                width: 400px; 
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
                width: 550px;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:15%"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td align="center" id=datea>~datea</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm" >
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
							<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
							<input id="txtNick" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>			
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
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
					<td align="center" style="width:100px;"><a id='lblCarno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCarplateno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt num c1" id="txtCarno.*" type="text" /></td>
					<td><input class="txt num c1" id="txtCarplateno.*" type="text" /></td>
					<td>
						<input id="btnProductno.*" type="button" value="..." style="width: 10%;" />
						<input class="txt" id="txtProductno.*" type="text" style="width:25%;"/>
						<input class="txt" id="txtProduct.*"type="text" style="width:55%;"/>
					</td>
					<td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMount.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMoney.*" type="text" /></td>
					<td><input class="txt c1" id="txtMemo.*" type="text" /></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
