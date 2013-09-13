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
		    var q_name = "fixall";
		    var q_readonly = ['txtNoa', 'txtWmoney', 'txtCmoney', 'txtDmoney','txtMoney','txtTax', 'txtDiscount', 'txtTotal','txtWorker','txtWorker2'];
		    var q_readonlys = ['txtMoney','txtMemo','txtFixano'];
		    var bbmNum = new Array(['txtWmoney', 10, 0, 1], ['txtCmoney', 10, 0, 1], ['txtDmoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtTotal', 10, 0, 1]);
		    var bbsNum = new Array(['txtPrice', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtDiscount', 10, 0, 1]);
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    //ajaxPath = "";
		    aPop = new Array(
		    	['txtCarno_', '', 'car2', 'a.noa,cardno,driverno,driver', 'txtCarno_,txtCardno_,txtDriverno_,txtDriver_', 'car2_b.aspx'],
		    	['txtDriverno_', '', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'], 
		    	['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
		    	['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,typea,inprice', 'txtProductno_,txtProduct_,txtUnit_,txtPrice_', 'fixucc_b.aspx']);
		    q_desc = 1;

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);

		    } ///  end Main()

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtFixadate', r_picd]];
		        q_mask(bbmMask);
		        
		        //export
		        $('#textBdate').datepicker();
                $('#divExport').mousedown(function(e) {
                	if(e.button==2){               		
	                	$(this).data('xtop',parseInt($(this).css('top')) - e.clientY);
	                	$(this).data('xleft',parseInt($(this).css('left')) - e.clientX);
                	}
                }).mousemove(function(e) {
                	if(e.button==2 && e.target.nodeName!='INPUT'){             	
                		$(this).css('top',$(this).data('xtop')+e.clientY);
                		$(this).css('left',$(this).data('xleft')+e.clientX);
                	}
                }).bind('contextmenu', function(e) {
	            	if(e.target.nodeName!='INPUT')
                		e.preventDefault();
		        });
                
                $('#btn2').click(function(e){
                	$('#divExport').toggle();
                	$('#textBdate').focus();
                });
                $('#btnDivexport').click(function(e){
                	$('#divExport').hide();
                });
                $('#textBdate').keydown(function(e){
                	if(e.which==13)
                		$('#btnDivexport').focus();			
                });
                $('#btnExport').click(function(e){
                	var t_bdate = $.trim($('#textBdate').val());
                	if(t_bdate.length==0){
                		alert('參數異常。');
                		return;
                	}
                	Lock();
                	q_func('qtxt.query.fixall', 'fixall.txt,fixall,' +encodeURI(q_getPara('sys.comp'))+';'+encodeURI(t_bdate));
                });
		    }
		    function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.fixall':
                    	location.reload();
                    break;
                }
            }    
			function browFixa(o){
				var t_fixano = $.trim($(o).val());
				if(t_fixano.length>0){
			    	q_box("fixa_ds.aspx?;;;noa='" + t_fixano + "';"+r_accy, 'fixa', "95%", "95%", q_getMsg("popFixa"));
			    }
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
		            	break;
		        }
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
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
					return;
				}
	            if($('#txtFixadate').val().length == 0 || !q_cd($('#txtFixadate').val())){
					alert(q_getMsg('lblFixadate')+'錯誤。');
            		Unlock(1);
            		return;
				}
 		        sum();
                if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!");
	            }
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixall') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;
		        q_box('fixall_s.aspx', q_name + '_s', "550px", "560px", q_getMsg("popSeek"));
		    }
		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtTax_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtDiscount_' + i).change(function (e) {
		                    sum();
		                });
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
                _btnModi();
                $('#txtDatea').focus();
		        sum();
		        
		        t_noa = abbm[q_recno].noa;
		        for(var i=0;i<abbs.length;i++){
		        	if(abbs[i].noa == t_noa && abbs[i].fixano.length>0){
		        		$('#tbbs').find('input[type="button"]').attr('disabled','disabled');
		        		break;
		        	}
		        }
		        
		    }
		    function btnPrint() {
		    	q_box("z_fixall.aspx?;;;;"+r_accy, 'z_fixall', "95%", "95%", q_getMsg("popFixa"));
		    }
		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }
		    function bbsSave(as) {
		        if (!as['carno'] && !as['productno'] && !as['product'] && !as['fixano']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    function q_popPost(t_id) {
		    	switch(t_id){
		    		case 'txtCarno_':
		    			$('#txtDriverno_'+b_seq).focus();
		    			break;
		    		case 'txtProductno_':
		    			$('#txtPrice_'+b_seq).focus();
		    			sum();
		    			break;
		    	}
            }
		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		        var t_money,t_wmoney,t_cmoney,t_dmoney,t_tax,t_discount,t_total;
		        var tot_wmoney = 0,tot_cmoney = 0,tot_dmoney = 0, tot_tax=0, tot_discount=0, tot_total=0;
		        for(var i=0;i<q_bbsCount;i++){
		        	t_money = q_float('txtMount_' + i).mul(q_float('txtPrice_' + i)).round(0);
		        	$('#txtMoney_'+i).val(FormatNumber(t_money));
		        	t_wmoney = 0;
		        	t_cmoney = 0;
		        	t_dmoney = 0;
		        	switch($.trim($('#txtTypea_' + i).val())){
		        		case '工資':
		        			t_wmoney = t_money;
		        			break;
		        		case '輪胎':
		        			t_cmoney = t_money;
		        			break;
		        		case '材料':
		        			t_dmoney = t_money;
		        			break;
		        		default:
		        			break;
		        	}
		        	t_tax = q_float('txtTax_'+i);
		        	t_discount = q_float('txtDiscount_'+i);
		        	t_total = t_wmoney.add(t_cmoney).add(t_dmoney).add(t_tax).sub(t_discount);
		        	
		        	tot_wmoney = tot_wmoney.add(t_wmoney);
		        	tot_cmoney = tot_cmoney.add(t_cmoney);
		        	tot_dmoney = tot_dmoney.add(t_dmoney);
					tot_tax = tot_tax.add(t_tax);
					tot_discount = tot_discount.add(t_discount);
					tot_total = tot_total.add(t_total);
							        	
		        	$('#txtWmoney_'+i).val(t_wmoney);
		        	$('#txtCmoney_'+i).val(t_cmoney);
		        	$('#txtDmoney_'+i).val(t_dmoney);
		        	$('#txtTax_'+i).val(t_tax);
		        	$('#txtDiscount_'+i).val(t_discount);
		        	$('#txtTotal_'+i).val(t_total);
		        }	        
		        t_tax = q_float('txtTax');
		        t_discount = q_float('txtDiscount');
		        $('#txtWmoney').val(FormatNumber(tot_wmoney));
		        $('#txtCmoney').val(FormatNumber(tot_cmoney));
		        $('#txtDmoney').val(FormatNumber(tot_dmoney));
		        $('#txtTax').val(FormatNumber(tot_tax));
		        $('#txtDiscount').val(FormatNumber(tot_discount));
		        $('#txtTotal').val(FormatNumber(tot_total));
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
		        _btnDele();
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
			    return Math.round(this.mul( Math.pow(10,arg))).div( Math.pow(10,arg));
			};
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			};
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length; } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length; } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""));
			        r2 = Number(arg2.toString().replace(".", ""));
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			};
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length; } catch (e) { }
			    try { m += s2.split(".")[1].length; } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			};
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
			    m = Math.pow(10, Math.max(r1, r2));
			    return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			};
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 600px;
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
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
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
                width: 100%;
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
		<div id="divExport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:120px;background:RGB(237,237,237);"> 
			<table style="border:4px solid gray; width:100%; height: 100%;">
				<tr style="height:1px;background-color: pink;">
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
				</tr>
				<tr>		
					<td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>登錄日期</a></td>
					<td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
						<input type="text" id="textBdate" style="float:left;width:50%;"/>
					</td>
				</tr>	
				<tr>
					<td colspan="2" align="center" style="background-color: pink;">
						<input type="button" id="btnExport" value="匯出"/>	
					</td>
					<td colspan="2" align="center" style=" background-color: pink;">
						<input type="button" id="btnDivexport" value="關閉"/>	
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewFixadate"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="fixadate" style="text-align: center;">~fixadate</td>
						<td id="nick" style="text-align: center;">~nick</td>
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
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblFixadate" class="lbl"> </a></td>
						<td><input id="txtFixadate" type="text" class="txt c1"/></td>	
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>				
					</tr>			
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="5">
						<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
						<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
						<input id="txtNick" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWmoney" class="lbl"> </a></td>
						<td><input id="txtWmoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblCmoney" class="lbl"> </a></td>
						<td><input id="txtCmoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblDmoney" class="lbl"> </a></td>
						<td><input id="txtDmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td> </td>
						<td><input id="btn2" type="button" class="c1" value="匯出"></td>
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
					<td align="center" style="width:100px;">車牌<BR>板證</td>
					<td align="center" style="width:100px;"><a id='lblDriver_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblTypea_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;">金額<br>折扣</td>
					<td align="center" style="width:100px;">稅額<BR>發票號碼</td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblFixano_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtCarno.*" type="text" style="width:95%;"/>
						<input id="txtCardno.*" type="text" style="width:95%;"/>
					</td>
					<td>
						<input id="txtDriverno.*" type="text" style="width:95%;float:left;"/>
						<input id="txtDriver.*"type="text" style="width:95%;float:left;"/>
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;"/>
						<input id="txtProduct.*"type="text" style="width:95%;"/>
					</td>
					<td><input id="txtTypea.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num" id="txtPrice.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input class="txt num" id="txtMount.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td>
						<input id="txtMoney.*" type="text"  style="float:left;width:95%;text-align:right;"/>
						<input id="txtDiscount.*" type="text"  style="float:left;width:95%;text-align:right;"/>
						<input id="txtWmoney.*" type="text"  style="display:none;"/>
						<input id="txtCmoney.*" type="text"  style="display:none;"/>
						<input id="txtDmoney.*" type="text"  style="display:none;"/>
					</td>
					<td>
						<input id="txtTax.*" type="text"  style="width:95%;text-align:right;"/>
						<input id="txtInvono.*" type="text" style="width:95%;"/>
					</td>
					<td><input id="txtMemo.*" type="text" style="width:95%;"/></td>
					<td><input id="txtFixano.*" onclick="browFixa(this)" type="text" style="width:95%;"/></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
