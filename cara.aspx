<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "cara";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [['txtIprev', 15, 0, 1],['txtIset', 15, 0, 1],['txtBprev', 15, 0, 1],['txtInterest', 15, 0, 1],['txtBin', 15, 0, 1],['txtItotal', 15, 0, 1],['txtBtotal', 15, 0, 1],['txtTotal', 15, 0, 1]];
            var bbsNum = [['txtOutmoney', 15, 0, 1],['txtInmoney', 15, 0, 1],['txtPay', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc=1;
			//q_alias='a';
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,b.carowner', 'txtCarno,txtCarowner', "car2_b.aspx"],
				['textCarseek', 'lblCarseek', 'car2', 'a.noa,b.carowner', 'textCarseek', "car2_b.aspx"],
				['txtCaritemno_', 'lblCaritemno', 'caritem', 'noa,item', 'txtCaritemno_,txtCaritem_', 'caritem_b.aspx'], 
				['txtAcc1_', 'lblAcc2', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            			
			var dateimport=false;
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtMon', r_picm],['txtPdate', r_picd]];
                q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
                q_mask(bbsMask);
                
                q_cmbParse("cmbIsource", q_getPara('cara.isource'));
                
                $('#btnImport').click(function () {
                	if(emp($('#txtCarno').val())){
                		alert('車牌號碼請先輸入!!');
                		$('#txtCarno').focus();
                		return;
                	}
                	if(emp($('#txtMon').val())){
                		alert('月份請先輸入!!');
                		$('#txtMon').focus();
                		return;
                	}
                	dateimport=true;
                	//上期欠款
		            var t_where = "where=^^ carno ='"+$('#txtCarno').val()+"' ^^";
			        q_gt('cara', t_where , 0, 0, 0, "", r_accy);
		     	});
                $('#cmbIsource').change(function () {sum();});
                //速查
                $('#textCarseek').change(function () {
                	if(!emp($('#textCarseek').val())){
                		q_content= "where=^^ carno like '%" +$('#textCarseek').val() + "%'^^ ";
                		q_sqlCount = 10;
                		q_gt(q_name, q_content, q_sqlCount, 1)
                		q_boxClose2(q_content);
                	}	
                });
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'car2':
                		if(dateimport){
                			var as = _q_appendData("car2", "", true);
                			if(as[0]!=undefined){
                				if(dec(as[0].manage)>0){
                    				as[0].caritem='管理費'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,manage', 'txtCaritem');
                    			}
                    			if(dec(as[0].guile)>0){
                    				as[0].caritem='公會費'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,guile', 'txtCaritem');
                    			}
                    			if(dec(as[0].reserve)>0){
                    				as[0].caritem='準備金'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,reserve', 'txtCaritem');
                    			}
                    			if(dec(as[0].help)>0){
                    				as[0].caritem='互助金'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,help', 'txtCaritem');
                    			}
                    			
                    			//上牌照稅
                    			if(as[0].ulicensemon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,ulicense', 'txtCaritem');
                    			}
                    			//下牌照稅
                    			if(as[0].dlicensemon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,dlicense', 'txtCaritem');
                    			}
                    			
                    			//春燃料費
                    			if(as[0].springmon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,spring', 'txtCaritem');
                    			}
                    			//夏燃料費
                    			if(as[0].summermon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,summer', 'txtCaritem');
                    			}
                    			//秋燃料費
                    			if(as[0].fallamon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,falla', 'txtCaritem');
                    			}
                    			//冬燃料費
                    			if(as[0].wintermon==$('#txtMon').val().substr(4,2)){
                    				as[0].caritem='牌照稅'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,winter', 'txtCaritem');
                    			}
                			}
                			//保費
					        var t_where = "where=^^ noa ='"+$('#txtCarno').val()+"' and inmon='"+$('#txtMon').val()+"' ^^";
					        q_gt('carinsure', t_where , 0, 0, 0, "", r_accy);
					    }
                		break;
                	case 'carinsure':
                		var as = _q_appendData("carinsure", "", true);
                    		if(as[0]!=undefined){
                    			if(dec(as[0].money)>0){
                    				as[0].caritem='保費'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', 1, as, 'caritem,money', 'txtCaritem');
                    			}
                    		}
                    		sum();
                		break;
                    case q_name:
                    	if(dateimport){
                    		var as = _q_appendData("cara", "", true);
                    		if(as[0]!=undefined){
                    			for (var i = 1; i < as.length; i++) {//只取最後一筆
		                        	as.splice(i, 1);
		                        	i--;
                    			}
                    			q_tr('txtIprev',dec(as[0].itotal));//上月息額取上一張累計息額
                    			q_tr('txtBprev',dec(as[0].btotal));//上月借支餘額取上一張本月借支餘額
                    			if(dec(as[0].total)>0){
                    				as[0].caritem='上月欠款'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtCaritem,txtOutmoney', as.length, as, 'caritem,total', 'txtCaritem');
                    			}
                    		}
                    		//管理費,公會費,準備金,互助金,牌照稅,燃料費
					        var t_where = "where=^^ a.noa ='"+$('#txtCarno').val()+"' ^^";
					        q_gt('car2', t_where , 0, 0, 0, "", r_accy);
					        
                    	}
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cara_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtCaritemno_'+j).change(function () {sum();});
           				$('#txtOutmoney_'+j).change(function () {sum();});
           				$('#txtInmoney_'+j).change(function () {sum();});
           			}
           		}
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();     
            }

            function btnPrint() {
				q_box('z_cara.aspx', '', "90%", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];

                return true;
            }

            function sum() {
                var t_total = 0,t_bin=0;
                for(var j = 0; j < q_bbsCount; j++) {
                    t_total += dec($('#txtOutmoney_' + j).val()) - dec($('#txtInmoney_' + j).val());
                    
                    if($('#txtCaritemno_' + j).val()=='201')//借支
                    	t_bin+=dec($('#txtOutmoney_' + j).val());
                    if($('#txtCaritemno_' + j).val()=='102')//入款借支
                    	t_bin-=dec($('#txtInmoney_' + j).val());
                }
                if($('#cmbIsource').val()=='1')//累計息額
                	q_tr('txtItotal',dec($('#txtIprev').val())+dec($('#txtInterest').val()));
                else
                	q_tr('txtItotal',dec($('#txtIset').val())+dec($('#txtInterest').val()));
                	
                q_tr('txtBin',t_bin);//本月借支-入款
                q_tr('txtBtotal',dec($('#txtBprev').val())+dec($('#txtBin').val()));//本月借支餘額
                q_tr('txtTotal',t_total);//金額合計
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                /// 表身運算式
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" style="float: left;  width:25%;">
				<table class="tview" id="tview" border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width: 25%;"><a id='vewDatea'></a></td>
						<td align="center" style="width: 50%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea '>~datea</td>
						<td align="center" id='carno '>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblCarno" class="lbl btn"></a></td>
						<td class="td2" colspan="2">
							<input id="txtCarno"  type="text"  class="txt c2"/>
							<input id="txtCarowner"  type="text" class="txt c3"/>
						</td>
						<td class="td4"><span> </span><a id='lblCarseek' class="lbl"></a></td>
						<td class="td5"><input id="textCarseek"  type="text" class="txt c1"/></td>
						<td class="td6"><input id="btnImport" type="button" /></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblIprev' class="lbl"></a></td>
						<td class="td2"><input id="txtIprev" type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblIset' class="lbl"></a></td>
						<td class="td4"><input id="txtIset"  type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblIsource' class="lbl"></a></td>
						<td class="td6"><select id="cmbIsource" class="txt c1" style="font-size: medium;"></select></td>
						<td class="td7"><span> </span><a id='lblBprev' class="lbl"></a></td>
						<td class="td8"><input id="txtBprev"  type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblInterest' class="lbl"></a></td>
						<td class="td4"><input id="txtInterest"  type="text" class="txt num c1"/></td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td7"><span> </span><a id='lblBin' class="lbl"></a></td>
						<td class="td8"><input id="txtBin" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblPdate' class="lbl"></a></td>
						<td class="td2"><input id="txtPdate"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblItotal' class="lbl"></a></td>
						<td class="td4"><input id="txtItotal"  type="text" class="txt num c1"/></td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td7"><span> </span><a id='lblBtotal' class="lbl"></a></td>
						<td class="td8"><input id="txtBtotal"  type="text" class="txt num c1"/></td>
					<!--直接讓速查顯示10筆
						<td class="td9"><span> </span><a id='lblLastmon' class="lbl"></a></td>
						<td class="td10"><input id="txtLastmon"  type="text" class="txt c2"/></td>
					-->
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td2"><input id="txtTotal"  type="text" class="txt num c1">	</td>
						<td class="td3"></td>
						<td class="td4"><input id="btnNextmon" type="button" /></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td6"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td8"><input id="txtNoa"  type="text" class="txt c1"/>	</td>
					</tr>
				</table>
			</div>

			<div class='dbbs'>
				<table id="tbbs" class='tbbs' border="1"  cellpadding='2' cellspacing='1'  style="width:100%;">
					<tr style='color:White; background:#003366;' >
						<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" class="ch2"><a id='lblDateas'></a></td>
						<td align="center" class="ch2"><a id='lblNoq'></a></td>
						<td align="center" class="ch2"><a id='lblCaritemno'></a></td>
						<td align="center" class="ch1"><a id='lblCaritem'></a></td>
						<td align="center" class="ch1"><a id='lblOutmoney'></a></td>
						<td align="center" class="ch1"><a id='lblInmoney'></a></td>
						<td align="center"><a id='lblMemo'></a></td>
						<td align="center" class="ch2"><a id='lblPay'></a></td>
						<td align="center" class="ch2"><a id='lblAcc1'></a></td>
						<td align="center" class="ch1"><a id='lblAcc2'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td >
						<input id="txtDatea.*" type="text" class="txt c1" />
						<input id="recno.*" type="hidden" />
						</td>
						<td >
						<input id="txtNoq.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtCaritemno.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtCaritem.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtOutmoney.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtInmoney.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtMemo.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtPay.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtAcc1.*" type="text"class="txt c1"/>
						</td>
						<td >
						<input id="txtAcc2.*" type="text" class="txt c1"/>
						</td>

					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
