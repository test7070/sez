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
		    var q_name = "acshareh";
		    var q_readonly = [];
		    var q_readonlys = ['txtTotal'];
		    var bbmNum = new Array();
		    var bbsNum = new Array();
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    //ajaxPath = "";
		    /*aPop = new Array(
		    	['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardno', 'txtCarno,txtDriverno,txtDriver,txtCardno', 'car2_b.aspx'],
		    	['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], 
		    	['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
		    	['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx'], 
		    	['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,typea,unit,inprice', 'txtProductno_,txtProduct_,txtTypea_,txtUnit_,txtPrice_', 'fixucc_b.aspx']);
		  	*/
		    q_desc = 1;
			brwCount2 = 3;
			var defaultTxt = ['期初餘額','員工股票紅利','本期損益','盈餘指撥及分配','提列法定盈餘公積','普通股現金股利'
				,'備供出售金融資產未實現損益增減','外幣財務報表換算所產生兌換差額增減','採權益法評價之被投資公司股權淨值增減','期末餘額'];

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
		    } 

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        q_mask(bbmMask);
		        
		        $('#btnImport').click(function(e){
		        	if($.trim($('#txtNoa').val()).length>0)
		        		q_gt('acshareh_import', '', 0, 0, 0, "", $.trim($('#txtNoa').val())+'_'+r_cno);
		        	else
		        		alert('請輸入'+q_getMsg('lblNoa'));
		        });
		    }

		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		            case q_name + '_s':
		                q_boxClose2(s2);
		                ///   q_boxClose 3/4
		                break;
		        }   /// end Switch
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		        	case 'acshareh_import':
		        		var as = _q_appendData("acccs", "", true);
                        if (as[0] != undefined) {
                        	for(var i=0;i<q_bbsCount;i++){
					    		if($('#txtTxt_'+i).val()==defaultTxt[0]){
					    			$('#txtA_'+i).val(as[0].a);
		                        	$('#txtB_'+i).val(as[0].b);
		                        	$('#txtC_'+i).val(as[0].c);
		                        	$('#txtD_'+i).val(as[0].d);
		                        	$('#txtE_'+i).val(as[0].e);
		                        	$('#txtF_'+i).val(as[0].f);
		                        	$('#txtG_'+i).val(as[0].g);
					    			break;
					    		}
					    	}
                        	sum();
                        }
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
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
	            sum();
		        var t_noa = trim($('#txtNoa').val());
	            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;
		        q_box('acshaerh_s.aspx', q_name + '_s', "550px", "560px", q_getMsg("popSeek"));
		    }
		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#txtA_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtA_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtB_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtC_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtD_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtE_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtF_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtG_' + i).change(function (e) {
		                    sum();
		                });
		            }
		        }
		        _bbsAssign();
		    }

		    function btnIns() {
                _btnIns();
                while(q_bbsCount<defaultTxt.length){
                	$('#btnPlus').click();
                }
                for(var i=0;i<defaultTxt.length;i++)
                	$('#txtTxt_'+i).val(defaultTxt[i]);
		    }

		    function btnModi() {
		    	if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
             		    return;
				_btnModi();
				sum();
		    }
		    function btnPrint() {
		    	q_box("z_acshareh.aspx?;;;;"+r_accy, 'z_acshareh', "95%", "95%", q_getMsg("popFixa"));
		    }
		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }
		    function bbsSave(as) {
		        if (!as['txt']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    function q_popPost(t_id) {
		    	if((q_cur==1  ||  q_cur==2) && t_id.substring(0,13).toUpperCase()=='TXTPRODUCTNO_'){
		    		sum();
		    	}
            }
		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		    	var endN = -1;
		    	for(var i=0;i<q_bbsCount;i++){
		    		if($('#txtTxt_'+i).val()==defaultTxt[defaultTxt.length-1]){
		    			endN = i;
		    			$('#txtA_'+i).val(0);
		    			$('#txtB_'+i).val(0);
		    			$('#txtC_'+i).val(0);
		    			$('#txtD_'+i).val(0);
		    			$('#txtE_'+i).val(0);
		    			$('#txtF_'+i).val(0);
		    			$('#txtG_'+i).val(0);
		    			break;
		    		}
		    	}
		    	if(endN>=0){
		    		for(var i=0;i<q_bbsCount;i++){
		    			if(i!=endN){
		    				$('#txtA_'+endN).val(q_float('txtA_'+endN)+q_float('txtA_'+i));
		    				$('#txtB_'+endN).val(q_float('txtB_'+endN)+q_float('txtB_'+i));
		    				$('#txtC_'+endN).val(q_float('txtC_'+endN)+q_float('txtC_'+i));
		    				$('#txtD_'+endN).val(q_float('txtD_'+endN)+q_float('txtD_'+i));
		    				$('#txtE_'+endN).val(q_float('txtE_'+endN)+q_float('txtE_'+i));
		    				$('#txtF_'+endN).val(q_float('txtF_'+endN)+q_float('txtF_'+i));
		    				$('#txtG_'+endN).val(q_float('txtG_'+endN)+q_float('txtG_'+i));
		    			}
		    		}
		    	}	
		    	for(var i=0;i<q_bbsCount;i++){
		    		$('#txtTotal_'+i).val(
		    			q_float('txtA_'+i)
		    			+q_float('txtB_'+i)
		    			+q_float('txtC_'+i)
		    			+q_float('txtD_'+i)
		    			+q_float('txtE_'+i)
		    			+q_float('txtF_'+i)
		    			+q_float('txtG_'+i)
		    		);
		    	}
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
                width: 470px;
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
                width: 480px;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNoa"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="noa" style="text-align: center;">~noa</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input id="btnImport" type="button" class="txt c1" value="匯入期初"/></td>
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
					<td align="center" style="width:250px;"><a id='lblTxt_s'>項目</a></td>
					<td align="center" style="width:100px;"><a id='lblA_s' tag="3110">普通股股本</a></td>
					<td align="center" style="width:100px;"><a id='lblB_s' tag="3300">資本公積</a></td>
					<td align="center" style="width:100px;"><a id='lblC_s' tag="3410">法定盈餘公積</a></td>
					<td align="center" style="width:100px;"><a id='lblD_s'>未提撥保留盈餘</a></td>
					<td align="center" style="width:100px;"><a id='lblE_s'>累積換算調整數</a></td>
					<td align="center" style="width:100px;"><a id='lblF_s'>庫藏股</a></td>
					<td align="center" style="width:100px;"><a id='lblG_s'>金融商品未實現損益</a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_s'>股東權益合計</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>

					<td><input class="txt" id="txtTxt.*" type="text" style="width:95%;"/></td>
					<td><input id="txtA.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtB.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtC.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtD.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtE.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtF.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtG.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtTotal.*" type="text"  style="width:95%;text-align:right;"/></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
