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
            var q_name = "trd";
            var decbbs = ['tranmoney', 'ch_oweight', 'ch_other'];
            var decbbm = ['taxrate', 'sum', 'tax', 'total'];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [['txtPrice', 11, 3]];
            var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtAddno1', 'lblAdd1', 'addr', 'noa,addr', 'txtAddno1,txtAdd1', 'addr_b.aspx'],
             ['txtAddno2', 'lblAdd2', 'addr', 'noa,addr', 'txtAddno2,txtAdd2', 'addr_b.aspx'],['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,namea', 'txtWorkerno,txtWorker', 'sss_b.aspx'],['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']);
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
            function mainPost() {
                fbbm[fbbm.length] = 'txtMemo';
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
				$('#lblAccno').parent().click(function(e) {
                    q_box("accc.aspx?" + $('#txtAccno').val() + "'", 'accc', "850px", "600px", q_getMsg("popAccc"));
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
                if(!as['boat']) {
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
                width: 59%;
                float: left;
            }
            .ch1 {
                width: 4%;
            }
            .ch2 {
                width: 8%;
            }
            .tbbm tr {
                height: 35px;
            }
            .td1, .td3, .td5, .td7, .td9 {
                width: 8%;
            }
            .td2, .td4, .td6, .td8, .td10 {
                width: 10%;
            }
            .lbl {
                float: right;
                color: blue;
                font-size: 16px;
            }
            .lbl.c1 {
                float: left;
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
			.btnLbl.button {
                cursor: pointer;
                color: #4297D7;
                font-weight: bolder;
                float:right;
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
                            <td class="td1" ><a id="lblDatea" class="lbl"></a></td>
                            <td class="td2" ><input id="txtDatea" type="text"  class="txt c1"/></td>
                            <td class="td3" ><a id="lblTrtype" class="lbl"></a></td>
                            <td class="td4" ><input id="txtTrtype" type="text"  class="txt c1"/></td>
                            <td class="td5" ><a id="lblNoa" class="lbl"></a></td>
                            <td class="td6" ><input id="txtNoa" type="text"  class="txt c1"/></td>
                            <td class="td7" ><a id="lblTuvcca" class="lbl btn"></a></td>
                            <td class="td8" ><input id="txtTovcca" type="text"  class="txt c2"/><input id="txtMon" type="text"  class="txt c3"/></td>
                            <td class="td9" ><a id="lblTaxrate" class="lbl btn"></a></td>
                            <td class="td10"><input id="txtTaxrate" type="text"  class="txt c2"/><input id="txtTaxtype" type="text"  style="width: 56%;"/></td>
                        </tr>
                        <tr class="tr2">
                            <td class="td1" ><a id="lblCust" class="lbl btn"></a></td>
                            <td class="td2" colspan="3">
                            <input id="txtCustno" type="text"  style='width:20%; float:left;'/>
                            <input id="txtCust" type="text"  style='width:76%; float:left;'/>
                            </td>
                            <td class="td5" ><a id="lblBoat" class="lbl btn"></a></td>
                            <td class="td6" ><input id="txtBoatno" type="text"  class="txt c2"/><input id="txtBoat" type="text"  class="txt c3"/></td>
                            <td class="td7" ><input id="chkIspdash" type="checkbox"/><a id="lblIspdash" ></a></td>
                            <td class="td8" ></td>
                            <td class="td9"><a id="lblVccano" class="lbl"></a></td>
                            <td class="td10"><input id="txtVccano" type="text" class="txt c1" /></td>
                        </tr>
                        <tr class="tr3">
                            <td class="td1" ><a id="lblBbdate" class="lbl"></a></td>
                            <td class="td2" ><input id="txtBbdate" type="text" class="txt c1" /></td>
                            <td class="td3" align="center"><a id="lblSymbol" style="font-weight: bolder;"></a></td>
                            <td class="td4" ><input id="txtBedate" type="text" class="txt c1" /></td>
                            <td class="td5" ><a id="lblAdd1" class="lbl btn"></a></td>
                            <td class="td6">
                            <input id="txtAddno1" type="text"  class="txt c2"/>
                            <input id="txtAdd1" type="text"  class="txt c3"/>
                            </td>
                            <td class="td7" ><input id="chkIsallbadd" type="checkbox" /><a id="lblIsallbadd" style="font-size: 14px;"></a></td>
                            <td class="td8" ><input id="chkIsbprov" type="checkbox" /><a id="lblIsbprov" ></a></td>
                            <td class="td9" ><a id="lblVccadate" class="lbl"></a></td>
                            <td class="td10" ><input id="txtVccadate" type="text" class="txt c1" /></td>
                        </tr>
                        <tr class="tr4">
                            <td class="td1" ><a id="lblEbdate" class="lbl"></a></td>
                            <td class="td2" ><input id="txtEbdate" type="text" class="txt c1" /></td>
                            <td class="td3" align="center"><a id="lblSymbol2" style="font-weight: bolder;"></a></td>
                            <td class="td4" ><input id="txtEedate" type="text" class="txt c1" /></td>
                            <td class="td5" ><a id="lblAdd2" class="lbl btn"></a></td>
                            <td class="td6">
                            <input id="txtAddno2" type="text" class="txt c2"/>
                            <input id="txtAdd2" type="text"  class="txt c3"/>
                            </td>
                            <td class="td7" ><input id="chkIsalleadd" type="checkbox" /><a id="lblIsalleadd" style="font-size: 14px;"></a></td>
                            <td class="td8" ><input id="chkIseprov" type="checkbox" /><a id="lblIseprov"></a></td>
                            <td class="td9" ><a id="lblOrdeno" class="lbl"></a></td>
                            <td class="td10" ><input id="txtOrdeno" type="text" class="txt c1" /></td>
                        </tr>
                        <tr class="tr5">
                            <td class="td1" ><a id="lblBoatname" class="lbl"></a></td>
                            <td class="td2" colspan="3"><input id="txtBoatname" type="text" style="width: 100%;" /></td>                            
                            <td class="td5" colspan="4"><input id="txtShip" type="text" style="width: 98%;" /></td>                    
                            <td class="td9" ><input id="chkIsochk" type="checkbox" /><a id="lblIsochk" ></a></td>
                            <td class="td10"><a id="lblBill" class="lbl btn"></a></td>
                        </tr>
                        <tr class="tr6">
                            <td class="td1" ><a id="lblMemo" class="lbl"></a></td>
                            <td class="td2" colspan="5"><textarea id="txtMemo" cols="10" rows="5" style="width: 98%;height: 50px;"></textarea></td>
                            <td class="td7" ><a id="lblType" class="lbl"></a></td>
                            <td class="td8" ><input id="txtType" type="text"  class="txt c1"/></td>
                            <td class="td9" ></td>
                            <td class="td10" ><a id="lblReport" class="lbl btn"></a></td>
                        </tr>
                        <tr class="tr8">
                            <td class="td1"><a id="lblAccno" class="btnLbl button"></a></td>
                            <td class="td2">
                            <input id="txtAccno" type="text"  class="txt c1"/>
                            </td>
                            <td class="td3"><a id="lblSum" class="lbl"></a></td>
                            <td class="td4"><input id="txtSum" type="text"  class="txt c1"/></td>
                            <td class="td5"><a id="lblTax" class="lbl"></a></td>
                            <td class="td6"><input id="txtTax" type="text" class="txt c1"/></td>
                            <td class="td7"><a id="lblTotal" class="lbl"></a></td>
                            <td class="td8"><input id="txtTotal" type="text" class="txt c1" /></td>
                        </tr>
                </table>
            </div>
            </div>
            <div class='dbbs' >
                <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 2000px;"  >
                    <tr style='color:White; background:#003366;' >
                        <td align="center">
                        <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                        </td>
                        <td align="center" class="ch1"><a id='lblDateas'></a></td>
                        <td align="center" class="ch1"><a id='lblCarno'></a></td>
                        <td align="center" class="ch1"><a id='lblRs'></a></td>
                        <td align="center" class="ch1"><a id='lblAdd1s'></a></td>
                        <td align="center" class="ch1"><a id='lblAdd2s'></a></td>
                        <td align="center" class="ch1"><a id='lblTranmoney'></a></td>
                        <td align="center" class="ch2"><a id='lblPaymemo'></a></td>
                        <td align="center" class="ch1"><a id='lblFill'></a></td>
                        <td align="center" class="ch1"><a id='lblCasetype'></a></td>
                        <td align="center" class="ch1"><a id='lblCaseno1'></a></td>
                        <td align="center" class="ch1"><a id='lblCaseno2'></a></td>
                        <td align="center" class="ch1"><a id='lblTranno'></a></td>
                        <td align="center" class="ch2"><a id='lblBoats'></a></td>
                        <td align="center" class="ch2"><a id='lblBoatnames'></a></td>
                        <td align="center" class="ch2"><a id='lblShips'></a></td>
                        <td align="center" class="ch2"><a id='lblMemos'></a></td>
                        <td align="center" class="ch1"><a id='lblCh_oweight'></a></td>
                        <td align="center" class="ch1"><a id='lblCh_other'></a></td>
                    </tr>
                    <tr  style='background:#cad3ff;'>
                        <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                        <td ><input class="txt c1" id="txtDatea.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCarno.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtRs.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtAdd1.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtAdd2.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtTranmoney.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtPaymemo.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtFill.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCasetype.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCaseno1.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCaseno2.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtTranno.*" type="text" /></td>
                         <td ><input class="txt c1" id="txtBoat.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtBoatname.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtShip.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCh_oweight.*" type="text" /></td>
                        <td ><input class="txt c1" id="txtCh_other.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
                    </tr>
                </table>
            </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
