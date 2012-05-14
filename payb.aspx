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
            var q_name = "payb";
            var decbbs = ['money', 'tax', 'total'];
            var decbbm = ['money', 'tax', 'total'];
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
            //ajaxPath = "";
			aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtPartno2', 'btnPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],['txtSalesno2', 'btnSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']);
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

            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                fbbm[fbbm.length] = 'txtMemo'; 
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('worka_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
                $('#txtProductno').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['invono']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for(var j = 0; j < q_bbsCount; j++) {

                }// j
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
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center;
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
        
       
         .column1
        {
            width: 5%;
        }
         .column1a
        {
            width: 10%;
        }
        .column2
        {
            width: 5%;
        }  
         .column2a
        {
            width: 10%;
        }      
        .column3
        {
            width: 10%;
        }   
        .column4
        {
            width: 10%;
        }           
         .label1
        {
            width: 10%;text-align:right;
        }       
        .label2
        {
            width: 10%;text-align:right;
        }
        .label3
        {
            width: 10%;text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
        .txt.c2
        {
            width: 93%;
        }
        .td1
        {
            width: 10%;
        }
        .td2
        {
            width: 8%;
        }
       
        
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                <td align="center" id='datea'>~datea</td>
                <td align="center" id='cno acomp,4'>~cno ~acomp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
           
            <tr>
               <td class="label1"><a id='lblNoa'></a></td>
               <td class="column1"colspan="2"><input id="txtNoa"   type="text"  class="txt c1"/></td> 
               <td class="label2"><a id='lblDatea'></a></td>
               <td class="column2" colspan="2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="label3"><a id='lblMon'></a></td>
               <td class="column3"><input id="txtMon"  type="text"  class="txt c1" /></td> 
            </tr>
     
            <tr>
               <td class="label1"><input id="btnAcomp" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
               <td class="column1"><input id="txtCno"  type="text"  class="txt c1" /></td>
               <td class="column1a" ><input id="txtAcomp"    type="text" class="txt c2"/></td>
               <td class="label2"><a id='lblVccno'></a></td>
               <td class="column2" colspan="2"><input id="txtVccno"  type="text" class="txt c1"/></td> 
               <td class="label3"><a id='lblPic'></a></td>
               <td class="column3"><input id="txtPic"  type="text" class="txt c1"/></td> 
            </tr>

           <tr>
                <td class="label1"><input id="btnTgg" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td class="column1" ><input id="txtTggno" type="text" class="txt c1"/></td>
                <td class="column1a"><input id="txtTgg"  type="text" class="txt c2"/></td>
                <td class="label2" ><a id='lblPayc'></a></td>
                <td class="column2"  colspan='2'><input id="txtPayc" type="text" class="txt c1"/></td> 
                <td class="label3" ><a id='lblInvono'></a></td>
                <td class="column3" ><input id="txtInvono" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="label1" class="label1"><a id='lblVdate' ></a></td>
                <td class="column1"><input id="txtVbdate" type="text"  class="txt c1"/></td> 
                <td class="column1a"><input id="txtVedate" type="text"  class="txt c2"/></td> 
                <td class="label2"><a id='lblCno2'></a></td>
                <td class="column2" ><input id="txtCno2"    type="text"  class="txt c1" /></td>
                <td class="column2a"><input id="txtAccno2"    type="text"  class="txt c2"/></td>
             </tr>
            <tr>
                <td class="label1" class="label1"><input id="btnPart2" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td class="column1"><input id="txtPartno2"    type="text"  class="txt c1"/></td> 
                <td class="column1a"><input id="txtPart2"    type="text" class="txt c2"/></td> 
                <td class="label2"><input id="btnSales2" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td class="column2"><input id="txtSalesno2" type="text" class="txt c1"/></td>
                <td class="column2a" ><input id="txtSales2"    type="text" class="txt c2"/></td>
            </tr>
            <tr>
                <td  class="label1"><a id='lblMoney'></a></td>
                <td class="column1" colspan="2"><input id="txtMoney" type="text" class="txt c1" style="text-align: right;"/></td> 
                <td class="label2" ><a id='lblTax'></a></td>
                <td class="column2" colspan="2"><input id="txtTax" type="text"  class="txt c1" style="text-align: right;"/></td>
                <td class="label3" ><a id='lblTotal'></a></td>
                <td class="column3" ><input id="txtTotal" type="text" class="txt c1" style="text-align: right;"/></td>  
            </tr>
            <tr><td class="label1" ><a id='lblMemo'></a></td>
                <td class="column1" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 127px;"></textarea></td>
                </tr>
            <tr>
                <td class="label1"></td>
                <td class="label1" colspan="2"></td>
                <td class="label2"></td>
                <td class="label2" colspan="2"></td>
                <td class="label3"><a id='lblWorker'></a></td>
                <td class="column3"><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td2"><a id='lblNoas'></a></td>
                <td align="center" class="td1"><a id='lblKind'></a></td>
                <td align="center" style="width: 4%;"><a id='lblType'></a></td>
                <td align="center" class="td2"><a id='lblInvonos'></a></td>
                <td align="center" class="td1"><a id='lblPart'></a></td>
                <td align="center" class="td2"><a id='lblMoneys'></a></td>
                <td align="center" style="width: 5%;"><a id='lblTaxs'></a></td>
                <td align="center" class="td1"><a id='lblTotals'></a></td>
                <td align="center" style="width: 15%;"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td><input id="txtNoq.*" type="text"  class="txt c1"/>
                <td><input id="txtKind.*" type="text"class="txt c1"/></td>
                <td><input id="txtTypea.*" type="text"  class="txt c1"/></td>
                <td><input id="txtInvono.*" type="text" class="txt c1"/>
                <td><input id="txtPartno.*" type="text" class="txt c1"/>
                    <input id="txtPart.*" type="text" class="txt c1"/></td>
                <td><input id="txtMoney.*" type="text" class="txt c1" style="text-align: right;"/></td>
                <td><input id="txtTax.*" type="text" class="txt c1" style="text-align: right;"/></td>
                <td><input id="txtTotal.*" type="text"  class="txt c1" style="text-align: right;"/></td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td ><input id="txtMemo.*" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
