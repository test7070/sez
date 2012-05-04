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
            var q_name = "tranorde";
            var decbbs = ['mount'];
            var decbbm = ['mount', 'price', 'price2', 'price3', 'discount', 'reserve', 'gross', 'plus', 'minus', 'mount2', 'total', 'total2', 'commission','unpack','thirdprice'];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtAddno1', 'lblAdd1', 'addr', 'noa,addr', 'txtAddno1,txtAdd1', 'addr_b.aspx'], ['txtAddno2', 'lblAdd2', 'addr', 'noa,addr', 'txtAddno2,txtAdd2', 'addr_b.aspx'],['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,namea', 'txtWorkerno,txtWorker', 'sss_b.aspx'],
            ['txtAddr_place', 'lblAddr_place', 'addr', 'noa,addr', 'txtAddr_placeno,txtAddr_place', 'addr_b.aspx'], ['txtAddr_trans', 'lblAddr_trans', 'addr', 'noa,addr', 'txtAddr_transno,txtAddr_trans', 'addr_b.aspx']);
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
            function q_funcPost(t_func, result) {
                if (result.substr(0, 5) == '<Data') {
                    var tmp = _q_appendData('carteam', '', true);
                    var value = '';
                    for (var z = 0; z < tmp.length; z++) {
                        value = value + (value.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
                    }
                    q_cmbParse("cmbCarteamno", value);
                    refresh(q_recno);
                } else
                    alert('Error!' + '\r' + t_func + '\r' + result);
            }
            function mainPost() {
                fbbm[fbbm.length] = 'txtMemo';
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbCalctype", q_getPara('trans.calctype'));
                q_cmbParse("cmbTtype", q_getPara('trans.ttype'));
                q_cmbParse("cmbCasetype", q_getPara('trans.casetype'));
                q_cmbParse("cmbTypea", q_getPara('trans.typea'));
                q_func('car2.getItem', '3,4,5');

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
                    case q_name:
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
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['dodate']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];

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
                for(var j = 0; j < q_bbsCount; j++) {

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
                if(q_tables == 's')
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
            .tview {
                FONT-SIZE: 12pt;
                COLOR: Blue;
                background: #FFCC00;
                padding: 3px;
                TEXT-ALIGN: center;
            }
            .tbbm {
                FONT-SIZE: 12pt;
                COLOR: blue;
                TEXT-ALIGN: left;
                border-color: white;
                width: 98%;
                border-collapse: collapse;
                background: #cad3ff;
            }
            .tbbs {
                FONT-SIZE: 12pt;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 98%;
                height: 98%;
            }
            .th1, .th3, .th5, .th7 {
                width: 11%;
                text-align: right;
                background: #FFEC8B;
            }
            .th2, .th4, .th6, .th8 {
                width: 14%;
                background: #FFEC8B;
            }
            .txt.c1 {
                width: 93%;
            }
            .txt.c2 {
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 66%;
                float: left;
            }
            .ch1 {
                width: 8%;
            }
            .ch2 {
                width: 11%;
            }
            .tbbm tr {
                height: 35px;
            }
            .td1, .td3, .td5, .td7 {
                width: 11%;
            }
            .td2, .td4, .td6, .td8 {
                width: 14%;
            }
            .lbl {
                float: right;
                color: blue;
                font-size: 16px;
            }
            .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .lbl.btn:hover {
                color: #FF8F19;
            }

        </style>
    </head>
    <body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
            <div class="dview" id="dview" style="float: left;  width:25%;"  >
                <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'></a></td>
                        <td align="center" style="width:15%"><a id='vewDatea'></a></td>
                        <td align="center" style="width:20%"><a id='vewOrdeno'></a></td>
                        <td align="center" style="width:20%"><a id='vewCust'></a></td>
                    </tr>
                    <tr>
                        <td >
                        <input id="chkBrow.*" type="checkbox" style=' '/>
                        </td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='ordeno'>~ordeno</td>
                        <td align="center" id='cust,4'>~cust,4</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm' style="width: 75%;float:left">
                <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
                    <tr class="tr1">
                        <td class='td1'><a id="lblOrdeno" class="lbl"></a></td>
                        <td class="td2"><input id="txtOrdeno"  type="text" class="txt c1"/></td>                      
                        <td class='td3'><a id="lblNoa" class="lbl"></a></td>
                        <td class="td4"><input id="txtNoa"  type="text" class="txt c1"/></td>
                        <td class='td5'><a id="lblDatea" class="lbl"></a></td>
                        <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td class="td7" ><a id="lblKdate" class="lbl"></a></td>
                        <td class="td8" ><input id="txtKdate" type="text"  class="txt c1"/></td></tr>
                        
                    </tr>
                    <tr class="tr2">                        
                        <td class='td1'><a id="lblBoat" class="lbl btn"></a></td>
                        <td class="td2" colspan="3">
                        <input id="txtBoatno"  type="text" class="txt c2"/>
                        <input id="txtBoat"  type="text" class="txt c3"/>
                        </td>
                        <td class='td5'><a id="lblBcomp" class="lbl"></a></td>
                        <td class="td6"><input id="txtBcomp"  type="text" class="txt c1" /></td>
                        <td class='td7'><a id="lblVccno" class="lbl"></a></td>
                        <td class="td8"><input id="txtVccno"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr3">
                        <td class="td1" ><a id="lblCust" class="lbl btn"></a></td>
                        <td class="td2" colspan="3">
                        <input id="txtCustno" type="text"  class="txt c2"/>
                        <input id="txtCust" type="text" class="txt c3"/>
                        </td>
                        <td class="td5"><a id="lblType" class="lbl"></a></td>
                        <td class="td6"><select id="cmbTypea" class="txt c1"></select></td>
                        <td class="td7"><a id="lblEnda" class="lbl"></a></td>
                        <td class="td8"><input id="txtEnda"  type="text" class="txt c1" /></td>
                    <tr class="tr4">
                        <td class="td1" ><a id="lblCalctype" class="lbl"></a></td>
                        <td class="td2" ><select id="cmbCalctype" class="txt c1"></select></td>
                        <td class="td3" ><a id="lblTtype" class="lbl"></a></td>
                        <td class="td4" ><select id="cmbTtype" class="txt c1"></select></td>
                        <td class="td5" ><a id="lblCarteam" class="lbl"></a></td>
                        <td class="td6" ><select id="cmbCarteamno" class="txt c1"></select></td>
                    </tr>
                    <tr class="tr5">
                        <td class="td1" ><a id="lblAdd1" class="lbl btn"></a></td>
                        <td class="td2" colspan="3">
                        <input id="txtAddno1" type="text"  class="txt c2"/>
                        <input id="txtAdd1" type="text"  class="txt c3"/>
                        </td>
                        <td class="td5" ><a id="lblAdd2" class="lbl btn"></a></td>
                        <td class="td6" colspan="3">
                        <input id="txtAddno2" type="text" class="txt c2"/>
                        <input id="txtAdd2" type="text"  class="txt c3"/>
                        </td>
                    </tr>
                    <tr class="tr6">
                        <td class="td1" ><a id="lblSales" class="lbl btn"></a></td>
                        <td class="td2" colspan="3">
                        <input id="txtSalesno" type="text"  class="txt c2"/>
                        <input id="txtSales" type="text"  class="txt c3"/>
                        </td>
                        <td class="td5" ><a id="lblWorker" class="lbl btn"></a></td>
                        <td class="td6" colspan="3">
                        <input id="txtWorkerno" type="text" class="txt c2"/>
                        <input id="txtWorker" type="text"  class="txt c3"/>
                        </td>
                    </tr>
                    <tr class="tr7">
                        <td class="td1" ><a id="lblUcc" class="lbl btn"></a></td>
                        <td class="td2" colspan="3">
                         <input id="txtUccno" type="text"  class="txt c2"/>
                        <input id="txtProduct" type="text"  class="txt c3"/>  
                        </td>
                    </tr>
                    <tr class="tr8">
                        <td class="td1" ><a id="lblMount" class="lbl"></a></td>
                        <td class="td2" ><input id="txtMount" type="text" class="txt c1" style="text-align: right;"/></td>
                        <td class="td3"><a id="lblMount2" class="lbl"></a></td>
                        <td class="td4"><input id="txtMount2" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td5"><a id="lblGross" class="lbl"></a></td>
                        <td class="td6"><input id="txtGross" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td7"><a id="lblThirdprice" class="lbl"></a></td>
                        <td class="td8"><input id="txtThirdprice" type="text"  class="txt c1" style="text-align: right;"/></td>
                    </tr>
                    <tr class="tr9">
                        <td class="td1" ><a id="lblPrice" class="lbl"></a></td>
                        <td class="td2" ><input id="txtPrice" type="text"  class="txt c1"style="text-align: right;"/></td>
                        <td class="td3" ><a id="lblPrice2" class="lbl"></a></td>
                        <td class="td4" ><input id="txtPrice2" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td5" ><a id="lblPrice3" class="lbl"></a></td>
                        <td class="td6" ><input id="txtPrice3" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td7" ><a id="lblDiscount" class="lbl"></a></td>
                        <td class="td8" ><input id="txtDiscount" type="text"  class="txt c1" style="text-align: right;"/></td>
                    </tr>
                    <tr class="tr10">
                        <td class="td1" ><a id="lblMinus" class="lbl"></a></td>
                        <td class="td2" ><input id="txtMinus" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td3" ><a id="lblPlus" class="lbl"></a></td>
                        <td class="td4" ><input id="txtPlus" type="text" class="txt c1" style="text-align: right;"/></td>
                        <td class="td5" ><a id="lblReserve" class="lbl"></a></td>
                        <td class="td6" ><input id="txtReserve" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td7"><a id="lblUnpack" class="lbl"></a></td>
                        <td class="td8"><input id="txtUnpack" type="text" class="txt c1" style="text-align: right;"/></td>
                    </tr>
                    <tr class="tr11">
                        <td class="td1" ><a id="lblCaseuse" class="lbl" style="font-size: 14px;"></a></td>
                        <td class="td2" ><input id="txtCaseuse" type="text"  class="txt c1"/></td>
                        <td class="td3" ><a id="lblPo" class="lbl"></a></td>
                        <td class="td4" ><input id="txtPo" type="text" class="txt c1"/></td>
                        <td class="td5" ><a id="lblTraceno" class="lbl"></a></td>
                        <td class="td6" ><input id="txtTraceno" type="text" class="txt c1"/></td>
                        <td class="td7" ><a id="lblSo" class="lbl"></a></td>
                        <td class="td8" ><input id="txtSo" type="text"  class="txt c1"/></td>
                    </tr>
                    <tr class="tr12">
                        <td class="td1" ><a id="lblCaseno" class="lbl"></a></td>
                        <td class="td2" colspan="3">
                        <input id="txtCaseno" type="text"  style='width:48%; float:left;'/>
                        <input id="txtCaseno2" type="text"  style='width:47%; float:left;'/>
                        </td>
                        <td class="td5" ><a id="lblCasetype" class="lbl"></a></td>
                        <td class="td6" ><select id="cmbCasetype" class="txt c1"></select></td>
                        <td class="td7" ></td>
                        <td class="td8" ></td>
                    </tr>
                    <tr class="tr13">
                        <td class="td1"><a id="lblFill" class="lbl"></a></td>
                        <td class="td2"><input id="txtFill" type="text"  class="txt c1"/></td>
                        <td class="td3"><a id="lblCaseend" class="lbl"></a></td>
                        <td class="td4"><input id="txtCaseend" type="text"  class="txt c1"/></td>
                        <td class="td5"><a id="lblBilldate" class="lbl"></a></td>
                        <td class="td6"><input id="txtBilldate" type="text"  class="txt c1"/></td>
                        <td class="td7"><a id="lblTotal" class="lbl"></a></td>
                        <td class="td8"><input id="txtTotal" type="text"  class="txt c1" style="text-align: right;"/></td>
                    </tr>
                    <tr class="tr14">
                        <td class="td1"><a id="lblMemo" class="lbl"></a></td>
                        <td class="td2" colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width:99%; height: 50px;"></textarea></td>
                    </tr>
                    <tr class="tr15">
                        <td class="td1"><a id="lblUnit" class="lbl" style="font-size: 14px;"></a></td>
                        <td class="td2"><input id="txtUnit" type="text"  class="txt c1"/></td>
                        <td class="td3"><a id="lblUnit2" class="lbl" style="font-size: 14px;"></a></td>
                        <td class="td4"><input id="txtUnit2" type="text"  class="txt c1"/></td>
                        <td class="td5"><a id="lblTotal2" class="lbl"></a></td>
                        <td class="td6"><input id="txtTotal2" type="text"  class="txt c1" style="text-align: right;"/></td>
                        <td class="td7"><a id="lblCommission" class="lbl"></a></td>
                        <td class="td8"><input id="txtCommission" type="text"  class="txt c1" style="text-align: right;"/></td>
                    </tr>                           
                    <tr class="tr16">
                        <td class='th1'><a id="lblExcon" class="lbl" style="color: #ff0033;font-weight:bolder;"></a></td>
                        <td class="th2"></td>
                        <td class='th3'></td>
                        <td class="th4"></td>
                        <td class="th5"><a id="lblImcon" class="lbl" style="color: #ff0033;font-weight:bolder;"></a></td>
                        <td class="th6"></td>
                        <td class="th7"></td>
                        <td class="th8"></td>  
                   </tr>
                   <tr class="tr17">
                        <td class="th1"><a id="lblBoatname" class="lbl"></a></td>
                        <td class="th2"><input id="txtBoatname"  type="text" class="txt c1"/></td>                       
                        <td class="th3"><a id="lblShip" class="lbl"></a></td>
                        <td class="th4"><input id="txtShip"  type="text" class="txt c1"/></td>
                        <td class="th5"><a id="lblAddr_place" class="lbl btn" style="font-size: 14px;"></a></td>
                        <td class="th6" colspan="3">
                        <input id="txtAddr_placeno"  type="text" class="txt c2"/>
                        <input id="txtAddr_place"  type="text" class="txt c3"/>
                        </td>
                   </tr>
                   <tr class="tr18">
                        <td class="th1"><a id="lblPort" class="lbl"></a></td>
                        <td class="th2"><input id="txtPort"  type="text" class="txt c1"/></td>
                        <td class="th3"></td>
                        <td class="th4"></td>
                        <td class="th5"><a id="lblAddr_orde" class="lbl" style="font-size: 14px;"></a></td>
                        <td class="th6" colspan="3"><input id="txtAddr_orde"  type="text" style="width: 98%;"/></td>                        
                   </tr>
                   <tr class="tr19">
                       <td class="th1"><a id="lblAddr_trans" class="lbl btn"></a></td>
                       <td class="th2" colspan="3">
                          <input id="txtAddr_transno"  type="text" class="txt c2"/>
                          <input id="txtAddr_trans"  type="text" class="txt c3"/>
                       </td>
                        <td class="th5"></td>
                        <td class="th6"><input id="txtPortno"  type="text" class="txt c1"/></td>
                        <td class="th8"align="left" colspan="2"><a id="lblPortno"class="txt c1" ></a></td>
                   </tr>
                   <tr class="tr20">
                       <td class="th1"><a id="lblCldate" class="lbl"></a></td>
                       <td class="th2"><input id="txtCldate"  type="text" class="txt c1"/></td>
                       <td class="th3"><a id="lblNodate" class="lbl"></a></td>
                       <td class="th4"><input id="txtNodate"  type="text" class="txt c1"/></td>
                       <td class="th5"><a id="lblMadate" class="lbl"></a></td>
                       <td class="th6"><input id="txtMadate"  type="text" class="txt c1"/></td>
                       <td class="th7"><a id="lblRedate" class="lbl"></a></td>
                       <td class="th8"><input id="txtRedate"  type="text" class="txt c1"/></td>
                  </tr>
                </table>
            </div>
            <div class='dbbs' >
                <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
                    <tr style='color:White; background:#003366;' >
                        <td align="center">
                        <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                        </td>
                        <td align="center" class="ch1"><a id='lblDodate'></a></td>
                        <td align="center" class="ch2"><a id='lblAddr_do'></a></td>
                        <td align="center" class="ch1"><a id='lblCasetypes'></a></td>
                        <td align="center" class="ch2"><a id='lblAddr_get'></a></td>
                        <td align="center" class="ch2"><a id='lblCasenos'></a></td>
                        <td align="center" class="ch1"><a id='lblMounts'></a></td>
                        <td align="center" ><a id='lblMemos'></a></td>
                        <td align="center" class="ch1"><a id='lblMount_undo'></a></td>
                        <td align="center" class="ch1"><a id='lblMount_unre'></a></td>
                    </tr>
                    <tr  style='background:#cad3ff;'>
                        <td style="width:1%;">
                        <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtDodate.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtAddr_do.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtCasetype.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtAddr_get.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtCaseno.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtMount.*" type="text" style="text-align: right;"/>
                        </td>
                        <td >
                        <input class="txt c1" id="txtMemo.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtMount_undo.*" type="text" />
                        </td>
                        <td >
                        <input class="txt c1" id="txtMount_unre.*" type="text" />
                        <input id="txtNoq.*" type="hidden" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
