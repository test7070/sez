<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

	    var q_name = 'salinsures', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = ['noa'], bbsKey = ['noa,noq'], as, brwCount2 = 12;
        var t_sqlname = 'salinsures_load';
        t_postname = q_name;
        var isBott = false;
		q_desc = 1;
		
        var afield, t_htm;
        var i, s1;
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];
        var bbsNum = [['txtHe_person', 15, 0, 1],['txtHe_comp', 15, 0, 1],['txtLa_person', 15, 0, 1],['txtLa_comp', 15, 0, 1],['txtRe_person', 15, 0, 1],['txtRe_comp', 15, 0, 1],['txtDisaster', 15, 0, 1],['txtTotal1', 15, 0, 1],['txtTotal2', 15, 0, 1],['txtPay', 15, 0, 1],['txtUnpay', 15, 0, 1],['txtSalary', 15, 0, 1],['txtSa_retire', 15, 0, 1],['txtSa_labor', 15, 0, 1],['txtSa_health', 15, 0, 1],['txtMount', 15, 0, 1]];
        var bbmMask = [];
	    var bbsMask = [['txtMon', '999/99']];
	    aPop = new Array(['txtCustno_', '', 'sssall', 'noa,namea', 'txtCustno_', 'sssall_b.aspx'],
	    	['txtCno_', 'btnCno_', 'acomp', 'noa,acomp', 'txtCno_,txtComp_', 'acomp_b.aspx']);
	    
        $(document).ready(function () {
			bbmKey = [];
			bbsKey = ['noa', 'noq'];
            main();
        });         /// end ready

        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }
            mainBrow(6, t_content, t_sqlname, t_postname);
            q_mask(bbmMask);
            bbsMask = [['txtMon', '999/99']];
         }
        function btnOk() {
			t_key = q_getHref();
			_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
		}
		function bbsSave(as) {
			if(!as['mon'] || !as['cno']) {// Dont Save Condition
				as[bbsKey[0]] = '';
				return;
			}
			q_getId2('', as);
			return true;
		}
		function bbsAssign() {
			for(var j = 0; j < q_bbsCount; j++) {
				$('#txtMon_'+j).blur(function() {
					t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					if(!emp($('#txtMon_'+b_seq).val()) &&!emp($('#txtCno_'+b_seq).val())){
						for(var k = 0; k < q_bbsCount; k++) { //檢查是否有重覆
							if(b_seq!=k&&!emp($('#txtMon_'+k).val()) &&!emp($('#txtCno_'+k).val())&& $('#txtMon_'+b_seq).val()==$('#txtMon_'+k).val() &&$('#txtCno_'+b_seq).val()==$('#txtCno_'+k).val()){
								alert('月份與公司重覆!!');
								$('#txtMon_'+b_seq).val('');
								return;
							}
						}
					}
					
					if(emp($('#txtNoq_'+b_seq).val()) && !emp($('#txtMon_'+b_seq).val())&&!emp($('#txtCno_'+b_seq).val()))
						$('#txtNoq_'+b_seq).val(replaceAll($('#txtMon_'+b_seq).val(),'/','')+$('#txtCno_'+b_seq).val());
				});
				
				$('#txtCno_'+j).blur(function() {
					t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					if(!emp($('#txtMon_'+b_seq).val()) &&!emp($('#txtCno_'+b_seq).val())){
						for(var k = 0; k < q_bbsCount; k++) { //檢查是否有重覆
							if(b_seq!=k&&!emp($('#txtMon_'+k).val()) &&!emp($('#txtCno_'+k).val())&& $('#txtMon_'+b_seq).val()==$('#txtMon_'+k).val() &&$('#txtCno_'+b_seq).val()==$('#txtCno_'+k).val()){
								alert('月份與公司重覆!!');
								$('#txtCno_'+b_seq).val('');
								$('#txtComp_'+b_seq).val('');
								return;
							}
						}
					}
					if(emp($('#txtNoq_'+b_seq).val()) && !emp($('#txtMon_'+b_seq).val())&&!emp($('#txtCno_'+b_seq).val()))
						$('#txtNoq_'+b_seq).val(replaceAll($('#txtMon_'+b_seq).val(),'/','')+$('#txtCno_'+b_seq).val());
				});
				
				//合計
				$('#txtHe_person_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumperson(b_seq); });
				$('#txtLa_person_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumperson(b_seq); });
				$('#txtRe_person_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumperson(b_seq); });
				
				$('#txtHe_comp_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumcomp(b_seq); });
				$('#txtLa_comp_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumcomp(b_seq); });
				$('#txtRe_comp_'+j).blur(function() { 	t_IdSeq = -1;	q_bodyId($(this).attr('id'));	b_seq = t_IdSeq;	sumcomp(b_seq); });
				
			}
			_bbsAssign();
			if(q_getPara('sys.comp').indexOf('大昌')>-1){
				for(var j = 0; j < q_bbsCount; j++) {
					if(dec($('#txtSysgen_'+j).val())==1){
						$('#sel_'+j).css('background-color','red');
					}
				}
			 	 $('.hidecust').show();
			 }else{
			 	$('.hidecust').hide();
			 }
		}
		
		function q_popPost(s1) {
			switch (s1) {
				case 'txtCno_':
		             if(!emp($('#txtMon_'+b_seq).val()) &&!emp($('#txtCno_'+b_seq).val())){
						for(var k = 0; k < q_bbsCount; k++) { //檢查是否有重覆
							if(b_seq!=k&&!emp($('#txtMon_'+k).val()) &&!emp($('#txtCno_'+k).val())&& $('#txtMon_'+b_seq).val()==$('#txtMon_'+k).val() &&$('#txtCno_'+b_seq).val()==$('#txtCno_'+k).val()){
								alert('月份與公司重覆!!');
								$('#txtCno_'+b_seq).val('');
								$('#txtComp_'+b_seq).val('');
								return;
							}
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
		}
		
		function btnPlus(org_htm, dest_tag, afield) {
			_btnPlus(org_htm, dest_tag, afield);
			if(q_tables == 's')
				bbsAssign();
		}
        function q_gtPost() {  
        }

        function refresh() {
            _refresh();
            
        }
        
        function sumperson(xseq) {
            q_tr('txtTotal1_'+xseq,q_float('txtHe_person_'+xseq)+q_float('txtLa_person_'+xseq)+q_float('txtRe_person_'+xseq));
        }
        
        function sumcomp(xseq) {
            q_tr('txtTotal2_'+xseq,q_float('txtHe_comp_'+xseq)+q_float('txtLa_comp_'+xseq)+q_float('txtRe_comp_'+xseq));
        }
        
    </script>
    <style type="text/css">
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        }      
        .txt.c1
        {
            width: 97%;
        }
        .num {
                text-align: right;
            }
    </style>
</head>

<body> 
<div  id="dbbs"  style="width: 1600px;">
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style="width: 1600px;">
            <tr>
				<td class="td1" align="center" style="width:36px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
                <!--<td align="center" style="color:Blue; width:36px;" class="td2"><a id='lblNoa'></a></td>-->
                <td align="center" style="color:Blue;width:60px;" class="td2"><a id='lblMon'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblHe_person'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblHe_comp'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblLa_person'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblLa_comp'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblRe_person'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td1"><a id='lblRe_comp'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblDisaster'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblTotal1'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblTotal2'></a></td>
                <!--<td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblPayc'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblPay'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblUnpay'></a></td>-->
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblSalary'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblSa_retire'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblSa_labor'></a></td>
                <td align="center" style="color:Blue;width:70px;" class="td2"><a id='lblSa_health'></a></td>
                <td align="center" style="color:Blue;width:40px;" class="td2"><a id='lblMount'></a></td>
                <td align="center" style="color:Blue;width:250px;" class="td1"><a id='lblComp'></a></td>
                <td align="center" style="color:Blue;" class="td1"><a id='lblMemo'></a></td>
                <td class="hidecust" align="center" style="color:Blue;width:100px;"><a id='lblCust'></a></td>
            </tr>
            <tr id="sel.*">
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
                <td >
                	<input class="txt c1" id="txtMon.*" type="text"   readonly="readonly" />
                	<input class="txt c1" id="txtNoa.*" type="hidden"   readonly="readonly" />
                	<input class="txt c1" id="txtNoq.*" type="hidden"   readonly="readonly" />
                	<input class="txt c1" id="txtSysgen.*" type="hidden"   readonly="readonly" />
                </td>
                <td ><input class="txt num c1" id="txtHe_person.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtHe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtLa_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtLa_comp.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtRe_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtRe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtDisaster.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtTotal1.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtTotal2.*" type="text"   readonly="readonly" /></td>
                <!--<td ><input class="txt c1" id="txtPayc.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtPay.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtUnpay.*" type="text"  readonly="readonly" /></td>-->
                <td ><input class="txt num c1" id="txtSalary.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_retire.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_labor.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_health.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"  readonly="readonly" /></td>
                <td >
                	<input class="txt c1" id="txtCno.*" type="text"  readonly="readonly"  style="width: 20%;"/>
                	<input id="btnCno.*" type="button" value="." style="width: 1%;" />
                	<input class="txt c1" id="txtComp.*" type="text"  readonly="readonly"  style="width: 65%;"/>
                </td>
                <td ><input class="txt c1" id="txtMemo.*" type="text"  readonly="readonly" /></td>
                <td class="hidecust"><input class="txt c1" id="txtCustno.*" type="text"  readonly="readonly" /></td>
            </tr>
        </table>
			<!--#include file="../inc/pop_modi.inc"-->
</div>
</body>
</html> 

