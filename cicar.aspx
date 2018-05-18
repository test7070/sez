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
            var q_name = "cicar";
            var q_readonly = ['txtWorker','txtWorker2','txtCust','txtSale','txtBirthday','txtId','txtMobile','txtTel1','txtTel2','txtFax','txtAddr1','txtAddr2'];
            var bbmNum = [];
            var bbmMask = [["txtYear", "9999/99"],["txtPassdate", "999/99/99"],["txtIndate", "999/99/99"],["txtOutdate", "999/99/99"],["txtRefdate", "999/99/99"],["txtSuspdate", "999/99/99"],["txtWastedate", "999/99/99"],["txtEnddate", "999/99/99"]];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            q_alias = 'a';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSaleno', '', 'cisale', 'noa,namea', 'txtSaleno,txtSale', 'cisale_b.aspx'],
			['txtCustno', 'lblCarno', 'cicust', 'noa,cust,birthday,id,mobile,tel1,tel2,fax,addr1,addr2', 'txtCustno,txtCust,txtBirthday,txtId,txtMobile,txtTel1,txtTel2,txtFax,txtAddr1,txtAddr2', 'cicust_b.aspx'])
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                q_gt('cicardeal', '', 0, 0, 0, "");
                
                $(".custdetail").hide();
                $("#btnCustdetail").val("＋");
				$("#btnCustdetail").toggle(function(e) {
					$(".custdetail").show();
					$("#btnCustdetail").val("－");
				}, function(e) {
					$(".custdetail").hide();
					$("#btnCustdetail").val("＋");
				});
				
				$(".carnochange").hide();
				$("#btnNoachange").toggle(function(e) {
					$(".carnochange").show();
				}, function(e) {
					$(".carnochange").hide();
				});
				
				$('#btnInsui').click(function(e) {
					q_box("ciinsui.aspx?;;;carno='" + $('#txtNoa').val() + "'", 'ciinsui', "90%", "95%", q_getMsg("popInsui"));
				});
				$('#btnClaim').click(function(e) {
					q_box("ciclaim.aspx?;;;carno='" + $('#txtNoa').val() + "'", 'ciinsui', "90%", "95%", q_getMsg("popInsui"));
				});
				$('#btnChange').click(function(e) {
					q_box("cichange.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'cichange', "90%", "95%", q_getMsg("popChange"));
				});
                $('#btnCust').click(function(e) {
					q_box("cicust.aspx?;;;noa='" + $('#txtCustno').val() + "'", 'cicust', "90%", "95%", q_getMsg("popCust"));
				});
                $('#btnSale').click(function(e) {
					q_box("cisale.aspx?;;;noa='" + $('#txtSaleno').val() + "'", 'cisale', "90%", "95%", q_getMsg("popSale"));
				});
				
				//更換車牌
				$('#btnChangecarno').click(function(e) {
					if(emp($('#txtChangecarno').val())&&q_cur==2){
						alert('請輸入'+q_getMsg('lblChangecarno')+'!!');
						return;
					}
					
					//先檢查是否有重複車牌
					if(!emp($('#txtChangecarno').val())&&q_cur==2){
                		var t_where = "where=^^ a.noa ='"+$('#txtChangecarno').val()+"' ^^";
						q_gt('cicar', t_where, 0, 0, 0, "");
					}
				});
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }
            var changenoa=false;
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cicardeal':
                		var as = _q_appendData("cicardeal", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        q_cmbParse("cmbCardealno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCardealno").val(abbm[q_recno].cardealno);
                		break;
                    case q_name:
                    	if(q_cur==2){
                    		var as = _q_appendData("cicar", "", true);
                    		if(as[0]==undefined){
	                    		if(!emp($('#txtChangecarno').val())){
	                    			changenoa=true;
	                				q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('noa') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI($('#txtChangecarno').val()) + ';' + encodeURI($('#txtCustno').val())+ ';' + encodeURI($('#txtCust').val()) + ';' + encodeURI(q_date())+ ';' + encodeURI(r_name));
								}
	                    	}else{
	                    		alert('車牌重覆!!');
	                    	}
                    	}
                    	
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            
            function q_funcPost(t_func, result) {
            	if(changenoa==true){
		        	location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";a.noa>='"+$('#txtChangecarno').val()+"';"+r_accy;
		        	alert('更換車牌成功!!');
		        	changenoa=false;
		        }
		    } //endfunction

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cicar_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }
			
			//暫存資料
			var t_custno='',t_cust='',t_refdate='',t_suspdate='',t_wastedate='',t_enddate=''
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                t_custno=$('#txtCustno').val();
                t_cust=$('#txtCust').val();
                t_refdate=$('#txtRefdate').val();
                t_suspdate=$('#txtSuspdate').val();
                t_wastedate=$('#txtWastedate').val();
                t_enddate=$('#txtEnddate').val();
                $('#txtNoa').attr('readonly','readonly');
                $('#txtNoa').focus();
            }

            function btnPrint() {
            	
            }
            function btnOk() { 
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(q_cur==1)
                	$('#txtWorker' ).val(r_name);
                if(q_cur==2)
                	$('#txtWorker2' ).val(r_name);
                	
                //判斷是否有變動資料
                if(q_cur==2){
                	//客戶過戶
                	if(t_custno!=$('#txtCustno').val()||t_cust!=$('#txtCust').val())
                		q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('cust') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI('non') + ';' + encodeURI(t_custno)+ ';' + encodeURI(t_cust) + ';' + encodeURI(q_date())+ ';' + encodeURI(r_name));
                	//復駛
                	if(t_refdate!=$('#txtRefdate').val() && !emp($('#txtRefdate').val()))
                		q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('refdate') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI('non') + ';' + encodeURI($('#txtCustno').val())+ ';' + encodeURI($('#txtCust').val()) + ';' + encodeURI($('#txtRefdate').val())+ ';' + encodeURI(r_name));
                	//停駛
                	if(t_suspdate!=$('#txtSuspdate').val() && !emp($('#txtSuspdate').val()))
                		q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('suspdate') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI('non') + ';' + encodeURI($('#txtCustno').val())+ ';' + encodeURI($('#txtCust').val()) + ';' + encodeURI($('#txtSuspdate').val())+ ';' + encodeURI(r_name));
                	//註銷
                	if(t_wastedate!=$('#txtWastedate').val() && !emp($('#txtWastedate').val()))
                		q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('wastedate') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI('non') + ';' + encodeURI($('#txtCustno').val())+ ';' + encodeURI($('#txtCust').val()) + ';' + encodeURI($('#txtWastedate').val())+ ';' + encodeURI(r_name));
                	//報廢
                	if(t_enddate!=$('#txtEnddate').val() && !emp($('#txtEnddate').val()))
                		q_func('qtxt.query','cichange.txt,cichange,'+encodeURI('enddate') + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI('non') + ';' + encodeURI($('#txtCustno').val())+ ';' + encodeURI($('#txtCust').val()) + ';' + encodeURI($('#txtEnddate').val())+ ';' + encodeURI(r_name));
                	
                }
                	
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
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
                width: 25%;
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
                width: 73%;
                margin: -1px;
                /*border: 1px black solid;*/
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 8%;
                float: left;
            }
            .txt.c5 {
                width: 90%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size: medium;
            }
			.tbbm .custdetail {
               background-color: #FFEC8B;
            }
            .tbbm .carnochange {
               background-color: #DAA520;
            }
            input[type="text"], input[type="button"] {
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
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewCust'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewSale'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='cust' style="text-align: center;">~cust</td>
						<td id='sale' style="text-align: center;">~sale</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCardeal" class="lbl"> </a></td>
						<td>	<select id="cmbCardealno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td><input id="txtCustno"  type="text"  class="txt c1"/></td>
						<td><input id="txtCust"  type="text"  class="txt c1"/></td>
						<td><input id="btnCustdetail" type="button" style="width:50%;"/></td>
						<td><input id="btnCust" type="button" style="width:80%;"/></td>
					</tr>
					<tr class="custdetail">
						<td><span> </span><a id='lblBirthday' class="lbl"> </a></td>
						<td><input type="text" id="txtBirthday" class="txt c1"/>	</td>
						<td><span> </span><a id='lblId' class="lbl"> </a></td>
						<td><input type="text" id="txtId" class="txt c1"/>	</td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input type="text" id="txtMobile" class="txt c1"/>	</td>
					</tr>
					<tr class="custdetail">
						<td><span> </span><a id='lblTel1' class="lbl"> </a></td>
						<td><input type="text" id="txtTel1" class="txt c1"/>	</td>
						<td><span> </span><a id='lblTel2' class="lbl"> </a></td>
						<td><input type="text" id="txtTel2" class="txt c1"/>	</td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input type="text" id="txtFax" class="txt c1"/>	</td>
					</tr>
					<tr class="custdetail">
						<td><span> </span><a id='lblAddr1' class="lbl"> </a></td>
						<td colspan="5"><input type="text" id="txtAddr1" class="txt c1"/>	</td>
					</tr>
					<tr class="custdetail">
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="5"><input type="text" id="txtAddr2" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSale' class="lbl btn"> </a></td>
						<td><input id="txtSaleno"  type="text"  class="txt c1"/></td>
						<td><input id="txtSale"  type="text"  class="txt c1"/></td>
						<td></td>
						<td><input id="btnSale" type="button" style="width:80%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblYear' class="lbl"> </a></td>
						<td><input type="text" id="txtYear" class="txt c1"/>	</td>
						<td><span> </span><a id='lblBrand' class="lbl"> </a></td>
						<td><input type="text" id="txtBrand" class="txt c1"/>	</td>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><input type="text" id="txtType" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPassdate' class="lbl"> </a></td>
						<td><input type="text" id="txtPassdate" class="txt c1"/>	</td>
						<td><span> </span><a id='lblCc' class="lbl"> </a></td>
						<td><input type="text" id="txtCc" class="txt c1"/>	</td>
						<td><span> </span><a id='lblEngineno' class="lbl"> </a></td>
						<td><input type="text" id="txtEngineno" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input type="text" id="txtIndate" class="txt c1"/>	</td>
						<td><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td><input type="text" id="txtOutdate" class="txt c1"/>	</td>
						<td><span> </span><a id='lblRefdate' class="lbl"> </a></td>
						<td><input type="text" id="txtRefdate" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSuspdate' class="lbl"> </a></td>
						<td><input type="text" id="txtSuspdate" class="txt c1"/>	</td>
						<td><span> </span><a id='lblWastedate' class="lbl"> </a></td>
						<td><input type="text" id="txtWastedate" class="txt c1"/></td>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input type="text" id="txtEnddate" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo" style="width:98%; height:100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><input id="btnInsui" type="button" style="width:80%;"/> </td>
						<td><input id="btnClaim" type="button" style="width:80%;"/> </td>
						<td><input id="btnChange" type="button" style="width:80%;"/> </td>
						<td><input id="btnNoachange" type="button" style="width:80%;"/> </td>
					</tr>
					<tr class="carnochange">
						<td><span> </span><a id="lblChangecarno" class="lbl"> </a></td>
						<td><input id="txtChangecarno"  type="text"  class="txt c1"/></td>
						<td><input id="btnChangecarno" type="button" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
