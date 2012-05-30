<%@ Page Language="C#" AutoEventWireup="true" %>
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
        var q_name = "bcce";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        aPop = new Array(['txtPartno','btnPart','part','noa,part','txtPartno,txtPart','part_b.aspx'],['txtBccno_', 'btnBccno_', 'bcc', 'noa,product', 'txtBccno_,txtBccname_', 'bcc_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
       function main() {
           if (dataErr) 
           {
               dataErr = false;
               return;
           }

            mainForm(1); 

            $('#txtDatea').focus();
            
        }  ///  end Main()

       /* function pop(form) {
            b_pop = form;
            switch (form) {
                case 'ucc': q_pop('txtProductno_' + b_seq, 'ucc_b.aspx', 'ucc', 'noa', 'product', "70%", "650px", q_getMsg('popUcc')); break;
                case 'store': q_pop('txtStoreno', 'store_b.aspx', 'store', 'noa', 'store', "60%", "650px", q_getMsg('popStore')); break;
                case 'station': q_pop('txtStationno', 'station_b.aspx', 'station', 'noa', 'station', "60%", "650px", q_getMsg('popStation')); break;
            }
        }*/

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
            q_mask(bbmMask);
            fbbm[fbbm.length] = 'txtMemo'; 
              

           /* $('#btnStore').click(function () { pop('store'); }); 
            $('#btnStore').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtStoreno").change(function () { q_change($(this), 'store', 'noa', 'noa,store'); }); 

            $('#btnStation').click(function () { pop('station'); }); 
            $('#btnStation').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtStationno").change(function () { q_change($(this), 'station', 'noa', 'noa,station'); }); 

            $('#btnquat').click(function () { btnquat(); });*/
        }

        function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {   
                case 'tgg':  
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
                    break;

                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStoreno,txtStore', ret, 'noa,store');
                    break;

                case 'station':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStationno,txtStation', ret, 'noa,station');
                    break;

                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
                                                           , 'txtProductno,txtProduct,txtSpec');   
                        bbsAssign();

                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                            }

                        }  /// for i
                    }
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case 'ucc':  
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case 'store':  
                    q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    break;

                case 'station':  
                    q_changeFill(t_name, 'txtStationno,txtStation', 'noa,station');
                    break;

                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
//        function btnquat() {
//            var t_custno = trim($('#txtCustno').val());
//            var t_where='';
//            if (t_custno.length > 0) {
//                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND ?y?k?A??? &&  
//                t_where =  t_where ;
//            }
//            else {
//                alert(q_getMsg('msgCustEmp'));
//                return;
//            }

//            q_box('ordes_b.aspx', 'ordes;' + t_where , "95%", "650px", "????");
//        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // ??d??? 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// ??????s??
                q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('bcce_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() { 
            _bbsAssign();
            for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#btnProductno_' + j).click(function () {
                    t_IdSeq = -1;  
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('ucc');
                 });
                 $('#txtProductno_' + j).change(function () {
                     t_IdSeq = -1; 
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'ucc', 'noa', 'noa,product,unit');  
                 });

            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {
 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   
            if (!as['bccno'] && !as['bccname'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            as['custno'] = abbm2['custno'];
//            t_err ='';
//            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
//                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

//            
//            if (t_err) {
//                alert(t_err)
//                return false;
//            }
//            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
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
            if (q_tables == 's')
                bbsAssign();  
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek(){
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
        #dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:medium;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 
		 .tbbm .td1,.tbbm .td3,.tbbm .td5,.tbbm .td7{width: 10%; text-align: right;}
		 .tbbm .td2,.tbbm .td4,.tbbm .td6,.tbbm .td8{width: 15%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:16px;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:98%;float:left;}
		 .tbbm tr td .txt.c2{width:50%;float:left;}
		 .tbbm tr td .txt.c3{width:47%;float:left;}
		 .tbbm tr td .txt.c4{width:53%;float:left;}
		 .tbbm tr td .txt.c5{width:35%;float:left;}
		 .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 .dbbm input[type="button"]{float:right;width:auto;font-size: medium;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;font-size: medium;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
      	 .tbbs .td1{width: 6%;}
      	 .tbbs .td2{width: 10%;}
      	 .tbbs .td3{width: 17%;}
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='1'  cellspacing='0'>
        <tr class="tr1">
               <td class="td1"><span> </span><a id='lblDatea'></a></td>
               <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblNoa'></a></td>
               <td class="td4"><input id="txtNoa" type="text" class="txt c1" /></td>               
               <td class="td5"><span> </span><a id='lblSname'> </a></td>
               <td class="td6"><input id="txtSname"  type="text" class="txt c1" /></td> 
               <td class="td7"><span> </span><input id="btnPart" type="button" /></td>               
               <td class="td8"><input id="txtPartno"  type="text"  class="txt c5"/><input id="txtPart"  type="text"  class="txt c6"/></td>
        </tr>
        <tr class="tr2">
            <td class="td1"></td>
            <td class="td2"></td>
            <td class="td3"><span> </span><a id='lblTotal'> </a></td>
            <td class="td4"><input id="txtTotal"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id='lblApprover'> </a></td>
            <td class="td6"><input id="txtApprover"  type="text" class="txt c1"/></td>  
        </tr>  
        <tr class="tr3">
            <td class="td1"><span> </span><a id="lblMemo"></a></td>
            <td class="td2" colspan="7"><textarea id="txtMemo" cols="10" rows="5" style="width: 95%; height: 127px;"></textarea></td>
            
        </tr>       
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'>
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class='td3'><a id='lblBccno'></a></td>
                <td align="center" class='td3'><a id='lblBccname'></a></td>
                <td align="center" class='td2'><a id='lblMount'></a></td>
                <td align="center" class='td2'><a id='lblWeight'></a></td>
                <td align="center" class='td2'><a id='lblPrice'></a></td>
                <td align="center" class='td3'><a id='lblTotals'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
              
            </tr>
            <tr  style='background:#cad3ff;'> 
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>              
                <td ><input id="txtBccno.*" type="text" style="width: 60%;"/><input id="btnBccno.*" type="button" value="..." style="width: auto;font-size: medium;" /></td>
                <td ><input  id="txtBccname.*"type="text" class="txt c8"/></td>
                <td ><input  id="txtMount.*" type="text" class="txt c7"/></td>
                <td ><input  id="txtWeight.*" type="text" class="txt c7"/></td>
                <td ><input  id="txtPrice.*" type="text" class="txt c7"/></td>
                <td ><input  id="txtTotal.*" type="text" class="txt c7"/></td>
                <td ><input  id="txtMemo.*" type="text" class="txt c8"/><input id="txtNoq.*" type="hidden" /></td>
           </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
