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

		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "bcc";
            var q_readonly = [];
            var bbmNum = [['txtPrice', 12, 2, 1], ['txtTax', 12, 2, 1], ['txtTotal', 12, 0, 1],['txtSafemount', 12, 0, 1],['txtYears', 2, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            
            aPop = new Array(
            	['txtAcc1', 'lblAcc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            	,['txtDeplacc', 'lblDeplacc', 'acc', 'acc1,acc2', 'txtDeplacc,txtDeplname', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            	,['txtAcczno', 'lblAcczno', 'acc', 'acc1,acc2', '0txtAcczno,txtAcczname', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            	//,['txtAcczno', 'lblAcczno', 'accz', 'acc1,namea', '0txtAcczno,txtAcczname', "accz_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            );
       
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                bbmMask = [['txtExpirationdate', r_picd]];
                q_mask(bbmMask);
                if(q_getPara('sys.project').toUpperCase()=='DC' || q_db=='dc'){ //105/07/11 DC 和 ST 共用同一ASPX
                	q_cmbParse("cmbTypea", q_getPara('bcc.type'));
                }else{
                	q_gt('bcctype', '', 0, 0, 0, "bcctype");
                }
				q_cmbParse("cmbTaxtype", '含稅,自訂');
				//q_gt('store', '', 0, 0, 0, "");
                $("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbTaxtype").change(function() {
                	sum();
                }).click(function() {
                	sum();
                });
                $('#txtPrice').change(function() {
                	sum();
                });
                $('#txtTax').change(function() {
                	sum();
                });
                $('#txtTotal').change(function() {
                	sum();
                });
                $('#txtAcc1').change(function(e) {
                    if($('#txtAcc1').val().length==4 && $('#txtAcc1').val().indexOf('.')==-1){
                    	$('#txtAcc1').val($('#txtAcc1').val()+'.');	
                    }else if($('#txtAcc1').val().length>4 && $('#txtAcc1').val().indexOf('.')==-1){
                    	$('#txtAcc1').val($('#txtAcc1').val().substring(0,4)+'.'+$('#txtAcc1').val().substring(4));	
                    }
                });
               $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
                    	q_gt('bcc', t_where, 0, 0, 0, "checkBccno_change", r_accy);
					}
                });
                
                $('#txtAcczno').change(function() {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
				});
				
				$('#txtDeplacc').change(function() {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
				});
                
                if(q_getPara('sys.project').toUpperCase()=='DC'){
                	$('.safe').hide();
                	$('.year').hide();
                }else{
                	$('.exp').hide();
                }
                
                if(q_getPara('sys.project').toUpperCase()=='YP'){
                	$('.accz').show();
                }
                
            }
            function sum(){
            	if(!(q_cur==1 || q_cur==2))
					return;	
				$('#txtPrice').attr('readonly',true);			
				$('#txtTax').attr('readonly',true);	
				$('#txtTotal').attr('readonly', true);
				$('#txtPrice').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTax').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTotal').css('background-color','rgb(237,237,238)').css('color','green');
				var t_price=0,t_tax=0,t_total=0,t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;;
            	switch($('#cmbTaxtype').val()){
            		case '自訂':
            			$('#txtPrice').attr('readonly',false);			
						$('#txtTax').attr('readonly',false);	
						$('#txtPrice').css('background-color','white').css('color','black');
						$('#txtTax').css('background-color','white').css('color','black');
						t_price = q_float('txtPrice');
						t_tax = q_float('txtTax');
						t_total = t_price + t_tax;
            			break;
            		case '含稅':
            			$('#txtTotal').attr('readonly',false);
            			$('#txtTotal').css('background-color','white').css('color','black');
            			t_total = q_float('txtTotal');
            			t_price = round(t_total / (1 + t_taxrate), 0);
			            t_tax = t_total - t_price;
			            break;
			        default:
			       	 	break;
            	}
            	$('#txtPrice').val(t_price);
            	$('#txtTax').val(t_tax);
            	$('#txtTotal').val(t_total);
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
                	case 'bcctype':
						var as = _q_appendData("bcctype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
                	case 'checkBccno_change':
                		var as = _q_appendData("bcc", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                        }
                		break;
                	case 'checkBccno_btnOk':
                		var as = _q_appendData("bcc", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    case 'store':
		                var as = _q_appendData("store", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
		                    }
		                    q_cmbParse("cmbStoreno", t_item);
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('bcc_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                sum();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNoa').attr('disabled', 'disabled');
				sum();
                $('#txtProduct').focus();
            }

            function btnPrint() {
            	if(q_getPara('sys.comp').indexOf('祥興')>-1){
                	q_box('z_bcc5_rs.aspx', '', "95%", "95%", q_getMsg("popPrint"));
				}else{
                	q_box('z_bcc5.aspx', '', "95%", "95%", q_getMsg("popPrint"));
               }
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
               Lock(); 
                $('#txtExpirationdate').val($.trim($('#txtExpirationdate').val()));
                if (!q_cd($('#txtExpirationdate').val())) {
                    alert(q_getMsg('lblExpirationdate') + '錯誤。');
                    Unlock();
                    return;
                }
                
                var patt = /^(\d{4})([^\.,.]*)$/g;
				$('#txtAcczno').val($('#txtAcczno').val().replace(patt,"$1.$2"));
                
                if($('#txtAcczno').val().length>0 && $('#txtAcczno').val().length<5){
                	alert(q_getMsg('lblAcczno')+'長度錯誤!!');
                	Unlock();
                    return;
                }
                
               $('#txtNoa').val($.trim($('#txtNoa').val()));
            	
				if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('bcc', t_where, 0, 0, 0, "checkBccno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
				refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
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
            
            function q_popPost(s1) {
				switch(s1) {
					
                }
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 330px; 
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
                width: 620px;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='product' style="text-align: left;">~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td colspan="3"><input id="txtProduct" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype"  class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="exp"><span> </span><a id='lblExpirationdate' class="lbl"> </a></td>
						<td class="exp"><input id="txtExpirationdate" type="text" class="txt c1" /></td>
						<td class="year"><span> </span><a id='lblYears' class="lbl"> </a></td>
						<td class="year"><input id="txtYears" type="text" class="txt num c1" /></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblStoreno' class="lbl"> </a></td>
						<td><select id="cmbStoreno" class="txt c1"></td>
					</tr>-->
					<tr class="safe">
						<td><span> </span><a id='lblSafemount' class="lbl"> </a></td>
						<td><input id="txtSafemount"  type="text" class="txt num c1"/></td>
					</tr>
					<tr class="acc" style="display: none;"><!--0712之後不顯示 -->
						<td><span> </span><a id='lblAcc' class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1" /></td>
						<td><input id="txtAcc2" type="text" class="txt c1" /></td>
					</tr>
					<tr class="accz" style="display: none;">
						<td><span> </span><a id='lblAcczno' class="lbl btn"> </a></td>
						<td><input id="txtAcczno" type="text" class="txt c1" /></td>
						<td><input id="txtAcczname" type="text" class="txt c1" /></td>
					</tr>
					<tr class="accz" style="display: none;">
						<td><span> </span><a id='lblDeplacc' class="lbl btn"> </a></td>
						<td><input id="txtDeplacc" type="text" class="txt c1" /></td>
						<td><input id="txtDeplname" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo2' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
